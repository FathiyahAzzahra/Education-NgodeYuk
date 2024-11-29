import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ngodeyuk/models/event_model.dart';
import 'package:ngodeyuk/services/firestore_service.dart';

class DailyTaskWidget extends StatefulWidget {
  final Function onEventAdded; // Add a callback for event added

  const DailyTaskWidget({super.key, required this.onEventAdded});

  @override
  DailyTaskWidgetState createState() => DailyTaskWidgetState();
}

class DailyTaskWidgetState extends State<DailyTaskWidget> {
  late List<EventModel> tasks = [];

  @override
  void initState() {
    super.initState();
    loadEvents();
  }

  void loadEvents() async {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      try {
        FirestoreService firestoreService = FirestoreService();
        List<EventModel> loadedEvents =
            await firestoreService.getEventsByUserId(userId);

        setState(() {
          tasks = loadedEvents;
        });
      } catch (e) {
        print('Failed to load events: $e');
      }
    }
  }

  void _onDeleteTask(EventModel event) async {
    try {
      await FirestoreService().deleteEvent(event.id);
      loadEvents(); // Reload events after deletion
    } catch (e) {
      print('Failed to delete event: $e');
    }
  }

  void onEventAdded() async {
    print('hai');
    loadEvents();
  }

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? Center(child: Text('No events for this day.'))
        : ListView.builder(
            itemCount: tasks.length,
            padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              final event = tasks[index];
              return Card(
                color: Color(0xFF383A56),
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                child: ListTile(
                  title: Text(
                    event.title,
                    style: TextStyle(
                      color: Color(0xFFEDE68A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    "${event.date} - ${event.time}",
                    style: TextStyle(color: Color(0xFFEDE68A)),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFFB0A565),
                    child: Icon(
                      Icons.event,
                      color: Colors.white,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Color(0xFFEDE68A),
                    ),
                    onPressed: () {
                      _onDeleteTask(event);
                    },
                  ),
                ),
              );
            },
          );
  }
}

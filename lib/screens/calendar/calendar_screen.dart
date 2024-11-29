import 'package:flutter/material.dart';
import 'package:ngodeyuk/models/event_model.dart';
import '../../services/firestore_service.dart';
import '../calendar/widgets/calendar_widget.dart';
import '../calendar/widgets/daily_task_widget.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final FirestoreService firebaseService = FirestoreService();
  Map<DateTime, List<EventModel>> events = {};
  DateTime? selectedDate;
  List<String> dailyTasks = [];
  String selectedTime = '';

  final GlobalKey<DailyTaskWidgetState> _dailyTaskKey =
      GlobalKey<DailyTaskWidgetState>();

  void onEventAdded() {
    // Trigger a refresh of the daily tasks when an event is added
    if (selectedDate != null) {
      onDateSelected(selectedDate!);
    }
    _dailyTaskKey.currentState?.loadEvents();
  }

  void onDateSelected(DateTime date) {
    // setState(() {
    //   selectedDate = DateTime(date.year, date.month, date.day);
    //   dailyTasks = events[selectedDate] ?? [];
    //   selectedTime = '';
    // });
  }

  @override
  void initState() {
    super.initState();
    loadEv();
  }

  Future<void> loadEv() async {
    FirestoreService firestoreService = FirestoreService();
    Map<DateTime, List<EventModel>> fetchedEvents =
        await firestoreService.fetchEventsFromDatabase();
    setState(() {
      events = fetchedEvents;
    });
  }

  void addEvent(String name, DateTime date, String time) async {
    if (name.isEmpty || time.isEmpty || selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please complete all fields.")),
      );
      return;
    }

    String? userId = await FirestoreService.getCurrentUserId();

    try {
      await firebaseService.addEvent(name, date, time, userId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Event added successfully.")),
      );

      // Notify the child widget (DailyTaskWidget) to update
      onEventAdded();
    } catch (e) {
      print("Error adding event: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add event: $e")),
      );
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked.format(context); // Format waktu menjadi string
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 119, 121, 126),
      appBar: AppBar(
        backgroundColor: Color(0xFF383A56),
        elevation: 2,
        centerTitle: true,
        title: Text(
          'Calendar',
          style: TextStyle(
            color: Color(0xFFEDE68A),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              color: Color(0xFFB0A565),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: CalendarWidget(
                  events: events,
                  onDateSelected: onDateSelected,
                  holidayTextColor: Colors.red,
                  previousMonthTextColor: Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            child: DailyTaskWidget(onEventAdded: onEventAdded),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFB0A565),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final nameController = TextEditingController();
              DateTime pickedDate = selectedDate ?? DateTime.now();

              return AlertDialog(
                backgroundColor: Color(0xFF383A56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                title: Text(
                  "Add New Event",
                  style: TextStyle(
                    color: Color(0xFFEDE68A),
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                content: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Event Name",
                          style: TextStyle(
                            color: Color(0xFFEDE68A),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        style: TextStyle(color: Color(0xFFEDE68A)),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFF50546D),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 12.0,
                          ),
                          hintText: 'Enter event name',
                          hintStyle: TextStyle(color: Color(0xFFA0A0A0)),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Selected Date: ${pickedDate.toLocal().toString().split(' ')[0]}",
                        style: TextStyle(
                          color: Color(0xFFEDE68A),
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () async {
                          final DateTime? date = await showDatePicker(
                            context: context,
                            initialDate: pickedDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2123),
                          );
                          if (date != null && date != pickedDate) {
                            setState(() {
                              pickedDate = date;
                              selectedDate = pickedDate;
                              selectedTime = '';
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB0A565),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 32.0),
                        ),
                        child: Text(
                          'Pick Date',
                          style: TextStyle(
                            color: Color(0xFF383A56),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => _selectTime(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFB0A565),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 32.0),
                        ),
                        child: Text(
                          'Pick Time',
                          style: TextStyle(
                            color: Color(0xFF383A56),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        selectedTime.isEmpty
                            ? 'No time selected'
                            : 'Selected Time: $selectedTime',
                        style: TextStyle(color: Color(0xFFEDE68A)),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Color(0xFFEDE68A)),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      String name = nameController.text;
                      addEvent(name, pickedDate, selectedTime);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB0A565),
                    ),
                    child: Text(
                      "Add Event",
                      style: TextStyle(color: Color(0xFFEDE68A)),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

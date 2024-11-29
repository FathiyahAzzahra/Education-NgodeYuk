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
  Map<DateTime, List<String>> events = {};
  DateTime? selectedDate;
  List<String> dailyTasks = [];
  String selectedTime = ''; // Menyimpan waktu yang dipilih

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  void fetchEvents() async {
    try {
      print("Fetching events...");
      final eventsMap = await firebaseService.getEventsAsMap();
      setState(() {
        events = eventsMap;
      });
      print("Events fetched successfully: $events");

      if (selectedDate != null) {
        onDateSelected(selectedDate!);
      }
    } catch (e) {
      print("Error fetching events: $e");
    }
  }

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = DateTime(date.year, date.month, date.day);
      dailyTasks = events[selectedDate] ?? [];
      selectedTime = ''; // Reset selectedTime when the date changes
    });
  }

  void addEvent(String name, DateTime date, String time) async {
    if (name.isEmpty || time.isEmpty || selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please complete all fields.")),
      );
      return;
    }

    try {
      print("Adding event...");
      await firebaseService.addEvent(name, date, time);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Event added successfully.")),
      );

      fetchEvents();

      if (selectedDate != null) {
        onDateSelected(selectedDate!);
      }
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
            child: DailyTaskWidget(
              tasks: dailyTasks,
              onDeleteTask: (task) {
                // Implementasi hapus task
                setState(() {
                  dailyTasks.remove(task);
                  events[selectedDate]?.remove(task);
                });
              },
            ),
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
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Color(0xFFEDE68A)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      addEvent(nameController.text, pickedDate, selectedTime);
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Save",
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

import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../calendar/widgets/calendar_widget.dart';

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
      final eventsMap = await firebaseService.getEventsAsMap();
      setState(() {
        events = eventsMap;
      });
    } catch (e) {
      print("Error fetching events: $e");
    }
  }

  void onDateSelected(DateTime date) {
    setState(() {
      selectedDate = DateTime(date.year, date.month, date.day);
      dailyTasks = events[selectedDate] ?? [];
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
      fetchEvents(); // Memanggil fetchEvents untuk mendapatkan event terbaru
      onDateSelected(
          selectedDate!); // Memperbarui tugas harian untuk tanggal yang dipilih
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
            child: dailyTasks.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.event_note,
                            size: 80, color: Color(0xFFB0A565)),
                        SizedBox(height: 12),
                        Text(
                          "No tasks for today!",
                          style: TextStyle(
                            color: Color(0xFFEDE68A),
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: dailyTasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Color(0xFF383A56),
                        elevation: 6,
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12.0),
                          leading: CircleAvatar(
                            backgroundColor: Color(0xFFB0A565),
                            child: Icon(Icons.check, color: Colors.white),
                          ),
                          title: Text(
                            dailyTasks[index],
                            style: TextStyle(
                              color: Color(0xFFEDE68A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFB0A565),
        onPressed: () {
          print("Add Event button clicked");
          showDialog(
            context: context,
            builder: (context) {
              final nameController = TextEditingController();
              DateTime pickedDate = DateTime.now();

              return AlertDialog(
                backgroundColor: Color(0xFF383A56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                title: Text(
                  "Add New Event",
                  style: TextStyle(color: Color(0xFFEDE68A)),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      style: TextStyle(color: Color(0xFFEDE68A)),
                      decoration: InputDecoration(
                        labelText: "Event Name",
                        labelStyle: TextStyle(color: Color(0xFFEDE68A)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFB0A565)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFEDE68A)),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(selectedTime.isEmpty
                        ? "Select Time"
                        : "Time: $selectedTime"),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFB0A565),
                      ),
                      onPressed: () {
                        _selectTime(context);
                      },
                      child: Text("Pick Time"),
                    ),
                    SizedBox(height: 10),
                    CalendarDatePicker(
                      initialDate: pickedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onDateChanged: (newDate) {
                        pickedDate = newDate;
                      },
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Color(0xFFEDE68A)),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB0A565),
                    ),
                    onPressed: () {
                      print("Add button pressed");
                      addEvent(
                        nameController.text,
                        pickedDate,
                        selectedTime,
                      );
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

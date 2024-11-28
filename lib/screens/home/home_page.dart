import 'package:flutter/material.dart';
import '../courses/courses_page.dart';
import '../activity/NotificationView.dart'; // Tambahkan halaman Activity
import '../calendar/calendar_page.dart'; // Tambahkan halaman Calendar
import '../assignments/assignments_page.dart'; // Tambahkan halaman Assignments
import '../chat/chat_page.dart'; // Tambahkan halaman Chat
import '../profile/profile_page.dart'; // Tambahkan halaman Profile

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;

  // Daftar halaman yang akan ditampilkan berdasarkan tab yang dipilih
  static final List<Widget> _widgetOptions = <Widget>[
    CoursesPage(), // Halaman Courses
    NotificationView(), // Halaman Activity
    CalendarPage(), // Halaman Calendar
    AssignmentsPage(), // Halaman Assignments
    ChatPage(), // Halaman Chat
    ProfilePage(), // Halaman Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Menambahkan tipe navigasi fixed
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Assignments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFFB0A565), // Menggunakan warna #B0A565
        unselectedItemColor: Color(0xFF383A56), // Menggunakan warna #383A56
        backgroundColor: Color(0xFFEDE68A).withOpacity(0.8), // Transparansi 80%
        onTap: _onItemTapped,
      ),
    );
  }
}

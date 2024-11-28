import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activity',
          style: TextStyle(
            color: Color(0xFFB0A565), // Mengubah warna teks
            fontWeight: FontWeight.bold, // Membuat teks menjadi bold
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF383A56), // Mengubah warna AppBar
      ),
      body: Center(
        child: Text('Activity Page Content Goes Here'),
      ),
    );
  }
}

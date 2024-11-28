import 'package:flutter/material.dart';

class AssignmentsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Assignments',
          style: TextStyle(
            color: Color(0xFFB0A565), // Mengubah warna teks
            fontWeight: FontWeight.bold, // Membuat teks menjadi bold
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF383A56), // Mengubah warna AppBar
      ),
      body: Center(
        child: Text('Assignments Page Content Goes Here'),
      ),
    );
  }
}

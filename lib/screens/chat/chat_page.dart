import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(
            color: Color(0xFFB0A565), // Mengubah warna teks
            fontWeight: FontWeight.bold, // Membuat teks menjadi bold
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF383A56), // Mengubah warna AppBar
      ),
      body: Center(
        child: Text('Chat Page Content Goes Here'),
      ),
    );
  }
}

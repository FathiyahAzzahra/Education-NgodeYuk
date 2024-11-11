import 'package:flutter/material.dart';
import 'message_bubble.dart';
import 'send_message_form.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> _messages = [];
  String _userRole = 'student';

  void _sendMessage(String message) {
    setState(() {
      _messages.insert(0, {
        'text': message,
        'userRole': _userRole,
      });
    });
  }

  void _toggleRole() {
    setState(() {
      _userRole = _userRole == 'student' ? 'teacher' : 'student';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih
      appBar: AppBar(
        backgroundColor: Color(0xFF383A56), // Warna #383A56
        title: Text('Class Forum',
            style: TextStyle(color: Color(0xFFEDE68A))), // Warna teks #EDE68A
        actions: [
          IconButton(
            icon: Icon(Icons.person,
                color: Color(0xFFEDE68A)), // Ikon warna #EDE68A
            onPressed: _toggleRole,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (ctx, index) {
                return MessageBubble(
                  _messages[index]['text'],
                  _messages[index]['userRole'] == 'teacher',
                );
              },
            ),
          ),
          SendMessageForm(_sendMessage),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFB0A565), // Warna #B0A565
        onPressed: _toggleRole,
        child: Icon(
          _userRole == 'student' ? Icons.school : Icons.person,
          color: Colors.white, // Ikon putih
        ),
        tooltip:
            'Switch Role to ${_userRole == 'student' ? 'Teacher' : 'Student'}',
      ),
    );
  }
}

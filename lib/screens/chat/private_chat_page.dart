import 'package:flutter/material.dart';

class PrivateChatPage extends StatefulWidget {
  final String chatPartnerName;

  const PrivateChatPage({required this.chatPartnerName, Key? key})
      : super(key: key);

  @override
  _PrivateChatPageState createState() => _PrivateChatPageState();
}

class _PrivateChatPageState extends State<PrivateChatPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> _messages = [];
  bool _isTeacher = true; // Menyimpan status Teacher/Student

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;

    setState(() {
      _messages.add({
        'text': message,
        'isSentByMe':
            _isTeacher, // Jika Teacher, kirim ke kanan (isSentByMe = true)
        'time': DateTime.now(),
      });
    });

    _messageController.clear();
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }

  void _toggleRole() {
    setState(() {
      _isTeacher = !_isTeacher; // Mengubah role menjadi Teacher/Student
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatPartnerName),
        backgroundColor: Color(0xFF383A56),
      ),
      body: Column(
        children: [
          // Menampilkan status peran (Teacher/Student)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment:
                  _isTeacher ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: _isTeacher
                      ? Color(0xFF383A56)
                      : Color(
                          0xFFB0A565), // Warna berbeda untuk Teacher/Student
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _isTeacher ? "You are the Teacher" : "You are the Student",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message['isSentByMe']
                      ? Alignment.centerRight // Pesan dari Teacher (kanan)
                      : Alignment.centerLeft, // Pesan dari Student (kiri)
                  child: Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message['isSentByMe']
                          ? Color(0xFF383A56) // Pesan Teacher
                          : Color(0xFFB0A565), // Pesan Student
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: message['isSentByMe']
                          ? CrossAxisAlignment.end // Pesan Teacher di kanan
                          : CrossAxisAlignment.start, // Pesan Student di kiri
                      children: [
                        Text(
                          message['text'],
                          style: TextStyle(
                            color: Colors
                                .white, // Pastikan teksnya putih agar kontras
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          _formatTime(message['time']),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors
                                .white70, // Warna lebih terang untuk waktu
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyle(color: Colors.black54),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Color(0xFFEDE68A),
                  onPressed: () => _sendMessage(_messageController.text),
                ),
              ],
            ),
          ),
          // Tombol untuk toggle antara Teacher dan Student
          IconButton(
            icon: Icon(Icons.switch_account),
            color: Colors.white,
            onPressed: _toggleRole,
            tooltip: 'Switch Role (Teacher/Student)',
          ),
        ],
      ),
      backgroundColor: Color(0xFF2F3032),
    );
  }
}

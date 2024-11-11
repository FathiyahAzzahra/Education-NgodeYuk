import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isTeacher;

  MessageBubble(this.message, this.isTeacher);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isTeacher ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isTeacher
                ? Color(0xFFB0A565)
                : Color(0xFFEDE68A), // Warna bubble
            borderRadius: BorderRadius.circular(12),
          ),
          width: 200,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isTeacher ? 'Guru' : 'Siswa',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isTeacher
                      ? Color(0xFF2F3032)
                      : Color(0xFF383A56), // Warna teks sesuai peran
                ),
              ),
              Text(
                message,
                style: TextStyle(
                    color: Color(0xFF2F3032)), // Warna teks bubble #2F3032
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

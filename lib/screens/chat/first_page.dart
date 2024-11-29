import 'package:flutter/material.dart';
import 'forum_page.dart';
import 'private_chat_page.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to Chat App',
          style: TextStyle(color: Color(0xFFEDE68A)),
        ),
        backgroundColor: Color(0xFF383A56),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Gambar header
            Container(
              margin: EdgeInsets.all(16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/128/9166/9166378.png',
                  height: 100, // Ubah ukuran tinggi
                  width: 100, // Ubah ukuran lebar
                  fit: BoxFit.contain, // Sesuaikan ukuran gambar
                ),
              ),
            ),
            SizedBox(height: 20),

            // Card untuk informasi aplikasi
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                color: Color(0xFFB0A565),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chat App Features',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '✨ Join public forums to share ideas.\n'
                        '✨ Private chat for personal conversations.\n'
                        '✨ Easy-to-use and secure.',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Tombol navigasi
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ForumPage()),
                      );
                    },
                    icon: Icon(Icons.forum),
                    label: Text('Forum'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB0A565),
                      foregroundColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PrivateChatPage(chatPartnerName: "User"),
                        ),
                      );
                    },
                    icon: Icon(Icons.chat),
                    label: Text('Private Chat'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFB0A565),
                      foregroundColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF2F3032),
    );
  }
}

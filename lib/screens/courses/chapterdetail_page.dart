import 'package:flutter/material.dart';
import '../../models/chapter_model.dart';

class ChapterDetailPage extends StatelessWidget {
  final Chapter chapter;
  final VoidCallback onComplete; // Callback untuk menyelesaikan chapter

  ChapterDetailPage({
    required this.chapter,
    required this.onComplete, // Terima parameter onComplete
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE68A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2F3032),
        title: Row(
          children: [
            Icon(
              Icons.school,
              color: Color(0xFFEDE68A),
            ),
            SizedBox(width: 8),
            Text(
              "Course Details",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xFFEDE68A),
              ),
            ),
          ],
        ),
        elevation: 4,
        shadowColor: Color(0xFF383A56),
      ),
      body: Container(
        color: Color(0xFFEDE68A),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thumbnail Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/zara/thumnail1.png',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 16),
                // Title Section
                Text(
                  chapter.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F3032),
                  ),
                ),
                SizedBox(height: 8),
                // Lesson Info
                Row(
                  children: [
                    Icon(Icons.timer, size: 18, color: Color(0xFF383A56)),
                    SizedBox(width: 4),
                    Text(
                      "10 Min", // Durasi bisa dinamis jika ada di data
                      style: TextStyle(color: Color(0xFF383A56)),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.star, size: 18, color: Colors.orange),
                    SizedBox(width: 4),
                    Text(
                      "4.8 Rating", // Rating dari data
                      style: TextStyle(color: Color(0xFF383A56)),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Description Section
                Text(
                  chapter.content,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Color(0xFF2F3032),
                  ),
                ),
                SizedBox(height: 24),
                // Comment Section
                Text(
                  "Comments",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F3032),
                  ),
                ),
                SizedBox(height: 8),
                _buildCommentsSection(),
                SizedBox(height: 24),
                // End of Chapter Button
                GestureDetector(
                  onTap: () {
                    onComplete(); // Panggil callback saat bab selesai
                    Navigator.pop(context); // Kembali ke halaman sebelumnya
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFF383A56),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'End of Chapter',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFEDE68A),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCommentsSection() {
    return Column(
      children: [
        _buildCommentItem(
          "Annie Duffy",
          "Great explanation! I really enjoyed this chapter.",
          "assets/images/user1.png", // Path gambar user (placeholder)
        ),
        _buildCommentItem(
          "John Smith",
          "I had some doubts but this cleared everything.",
          "assets/images/user2.png", // Path gambar user (placeholder)
        ),
        _buildCommentInput(),
      ],
    );
  }

  Widget _buildCommentItem(String userName, String comment, String userImage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(userImage),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F3032),
                  ),
                ),
                Text(
                  comment,
                  style: TextStyle(
                    color: Color(0xFF383A56),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInput() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFFEDE68A),
            child: Icon(Icons.person, color: Color(0xFF2F3032)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Write a comment...",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          IconButton(
            onPressed: () {
              // Tambahkan logika untuk mengirim komentar
            },
            icon: Icon(Icons.send, color: Color(0xFF2F3032)),
          ),
        ],
      ),
    );
  }
}

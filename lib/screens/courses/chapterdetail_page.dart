import 'package:flutter/material.dart';
import '../../models/chapter_model.dart';
import '../../models/comment_model.dart';
import '../../services/comment_service.dart';

class ChapterDetailPage extends StatefulWidget {
  final Chapter chapter;
  final VoidCallback onComplete;

  ChapterDetailPage({
    required this.chapter,
    required this.onComplete,
  });

  @override
  _ChapterDetailPageState createState() => _ChapterDetailPageState();
}

class _ChapterDetailPageState extends State<ChapterDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  final CommentService _commentService = CommentService();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Buat ID berdasarkan judul atau indeks bab
    final chapterId = widget.chapter.title.replaceAll(' ', '_').toLowerCase();

    return Scaffold(
      backgroundColor: Color(0xFFEDE68A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2F3032),
        title: Row(
          children: [
            Icon(Icons.school, color: Color(0xFFEDE68A)),
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
                  widget.chapter.title,
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
                      "${widget.chapter.rating} Rating",
                      style: TextStyle(color: Color(0xFF383A56)),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                // Description Section
                Text(
                  widget.chapter.content,
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
                _buildCommentsSection(chapterId),
                SizedBox(height: 24),
                // End of Chapter Button
                GestureDetector(
                  onTap: () {
                    widget.onComplete(); // Panggil callback saat bab selesai
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

  Widget _buildCommentsSection(String chapterId) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder<List<Comment>>(
          stream: _commentService.getComments(chapterId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Text(
                "Error loading comments",
                style: TextStyle(color: Colors.red),
              );
            }

            final comments = snapshot.data ?? [];
            if (comments.isEmpty) {
              return Text(
                "Belum ada komentar untuk bab ini.",
                style: TextStyle(color: Colors.grey),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return _buildCommentItem(comment.userName, comment.comment);
              },
            );
          },
        ),
        _buildCommentInput(chapterId),
      ],
    );
  }

  Widget _buildCommentItem(String userName, String comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/ngodeyuk_logo.png'),
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

  Widget _buildCommentInput(String chapterId) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/ngodeyuk_logo.png'),
          ),
          SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: _commentController,
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
            onPressed: () async {
              final commentText = _commentController.text.trim();
              if (commentText.isNotEmpty) {
                await _commentService.addComment(
                  chapterId,
                  commentText,
                );
                _commentController.clear();
              }
            },
            icon: Icon(Icons.send, color: Color(0xFF2F3032)),
          ),
        ],
      ),
    );
  }
}

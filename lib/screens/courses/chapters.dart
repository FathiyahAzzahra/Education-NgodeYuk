import 'package:flutter/material.dart';

class ChapterListPage extends StatelessWidget {
  final String subjectName;

  ChapterListPage({required this.subjectName});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> chapters = [
      {
        "title": "Introduction to $subjectName",
        "views": "125 Views",
        "rating": "4.8"
      },
      {"title": "$subjectName Basics", "views": "100 Views", "rating": "4.5"},
      {"title": "Advanced $subjectName", "views": "150 Views", "rating": "4.9"},
      // Tambahkan lebih banyak chapter sesuai kebutuhan
    ];

    return Scaffold(
      backgroundColor: Color(0xFFFFF7D1),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFB0B0),
        title: Text("Chapter List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: chapters.length,
          itemBuilder: (context, index) {
            return _buildChapterCard(chapters[index], index + 1);
          },
        ),
      ),
    );
  }

  Widget _buildChapterCard(Map<String, String> chapter, int chapterNumber) {
    return Card(
      color: Color(0xFFFFECC8),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(0xFFFFD09B),
          child: Text(chapterNumber.toString()),
        ),
        title: Text(chapter['title']!),
        subtitle: Row(
          children: [
            Text(chapter['views']!),
            SizedBox(width: 16),
            Text("⭐ ${chapter['rating']}"),
          ],
        ),
        trailing: Icon(Icons.lock_outline, color: Color(0xFFFFB0B0)),
      ),
    );
  }
}

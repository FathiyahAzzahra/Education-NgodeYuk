import 'package:flutter/material.dart';
import '../../services/firestore_service.dart';
import '../../models/chapter_model.dart'; // Pastikan path-nya sesuai
import '../courses/chapterdetail_page.dart';

class ChapterListPage extends StatelessWidget {
  final String subjectName;
  final FirestoreService firestoreService =
      FirestoreService(); // Instance FirestoreService

  ChapterListPage({required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF7D1),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFB0B0),
        title: Text("$subjectName Chapters"),
      ),
      body: FutureBuilder(
        future: firestoreService
            .getChapters(subjectName), // Ambil data bab dari Firestore
        builder: (context, AsyncSnapshot<List<Chapter>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No chapters available."));
          }

          final chapters = snapshot.data!;

          return ListView.builder(
            itemCount: chapters.length,
            itemBuilder: (context, index) {
              return _buildChapterCard(context, chapters[index], index + 1);
            },
          );
        },
      ),
    );
  }

  Widget _buildChapterCard(
      BuildContext context, Chapter chapter, int chapterNumber) {
    return GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail bab ketika card diklik
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChapterDetailPage(chapter: chapter),
          ),
        );
      },
      child: Card(
        color: Color(0xFFFFECC8),
        margin: EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color(0xFFFFD09B),
            child: Text(chapterNumber.toString()),
          ),
          title: Text(chapter.title),
          subtitle: Row(
            children: [
              Text(chapter.views),
              SizedBox(width: 16),
              Text("⭐ ${chapter.rating}"),
            ],
          ),
          trailing: Icon(Icons.lock_outline, color: Color(0xFFFFB0B0)),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../models/chapter_model.dart';
import '../../models/user_model.dart';
import '../../services/firestore_service.dart';
import '../courses/chapterdetail_page.dart';
import '../assignments/assignments_page.dart';

class ChapterListPage extends StatefulWidget {
  final String subjectName;

  ChapterListPage({required this.subjectName});

  @override
  _ChapterListPageState createState() => _ChapterListPageState();
}

class _ChapterListPageState extends State<ChapterListPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? currentUser;
  List<Chapter> allChapters = [];
  List<Chapter> filteredChapters = [];
  List<String> completedChapters = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Memuat data pengguna
      final userDoc = await _firestore
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .get();
      final userData = userDoc.data();

      // Ambil completedCourses untuk subjectName
      final courseProgress = userData?["completedCourses"] ?? {};
      final completed = courseProgress[widget.subjectName] ?? [];

      final chapters = await FirestoreService()
          .getChapters(widget.subjectName); // Pastikan ini Future

      setState(() {
        completedChapters = List<String>.from(completed
            .map((e) => e.toString())); // Konversi setiap elemen ke String
        allChapters = chapters;
        filteredChapters = chapters;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading data: $e");
    }
  }

  Future<void> _markChapterComplete(String chapterId) async {
    if (!completedChapters.contains(chapterId)) {
      setState(() {
        completedChapters.add(chapterId);
      });

      await _firestore.collection("users").doc(_auth.currentUser!.uid).set({
        'completedCourses': {
          widget.subjectName: FieldValue.arrayUnion([chapterId]),
        },
      }, SetOptions(merge: true));
    }
  }

  void _filterChapters(String query) {
    final results = allChapters.where((chapter) {
      final title = chapter.title.toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input);
    }).toList();

    setState(() {
      filteredChapters = results;
    });
  }

  double _calculateProgress() {
    if (allChapters.isEmpty) return 0.0;
    return completedChapters.length / allChapters.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header dan Progress Bar
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 30.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF383A56),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24.0),
                      bottomRight: Radius.circular(24.0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back,
                                color: Color(0xFFEDE68A), size: 28),
                          ),
                          Icon(Icons.filter_alt_outlined,
                              color: Color(0xFFEDE68A), size: 28),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        widget.subjectName.toUpperCase(),
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFEDE68A)),
                      ),
                      SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: _calculateProgress(),
                        backgroundColor: Colors.grey[300],
                        color: Color(0xFFEDE68A),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "${(_calculateProgress() * 100).toStringAsFixed(1)}% Completed",
                        style:
                            TextStyle(color: Color(0xFFEDE68A), fontSize: 14),
                      ),
                    ],
                  ),
                ),

                // Tombol Quiz Section
                _buildQuizSection(context),

                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Cari judul bab di mata pelajaran ini",
                      prefixIcon: Icon(Icons.search, color: Color(0xFF383A56)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    ),
                    onChanged: _filterChapters,
                  ),
                ),

                // Daftar Bab
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredChapters.length,
                    itemBuilder: (context, index) {
                      final chapter = filteredChapters[index];
                      final chapterId = 'chapter_${index + 1}';
                      final isLocked = index > 0 &&
                          !completedChapters.contains('chapter_${index}');

                      return ListTile(
                        title: Text(chapter.title),
                        subtitle: Text(
                            "⭐ ${chapter.rating} - ${chapter.views} views"),
                        leading: CircleAvatar(
                          backgroundColor:
                              Color(0xFFEDE68A), // Warna latar belakang
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                              color: Color(0xFF2F3032), // Warna teks
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        trailing: Icon(
                          isLocked ? Icons.lock_outline : Icons.check,
                          color: isLocked ? Colors.red : Colors.green,
                        ),
                        onTap: isLocked
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChapterDetailPage(
                                      chapter: chapter,
                                      onComplete: () =>
                                          _markChapterComplete(chapterId),
                                    ),
                                  ),
                                );
                              },
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildQuizSection(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2F3032),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            Icons.quiz,
            color: Color(0xFFEDE68A),
            size: 40,
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kerjakan Quiz",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEDE68A),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Tes pemahaman kamu di sini!",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AssignmentsPage(), // Navigasi ke quiz
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFEDE68A),
              foregroundColor: Color(0xFF2F3032),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Mulai",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

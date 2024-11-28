import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ngodeyuk/screens/courses/chapters.dart';
import '../../services/firestore_service.dart'; // Import FirestoreService
import '../../models/course_model.dart'; // Pastikan path-nya sesuai

class CoursesPage extends StatelessWidget {
  final FirestoreService firestoreService =
      FirestoreService(); // Instance FirestoreService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Courses',
          style: TextStyle(
            color: Color(0xFFB0A565), // Mengubah warna teks
            fontWeight: FontWeight.bold, // Membuat teks menjadi bold
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF383A56), // Mengubah warna AppBar
      ),
      body: FutureBuilder(
        future:
            firestoreService.getCourses(), // Ambil data kursus dari Firestore
        builder: (context, AsyncSnapshot<List<Course>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No courses available."));
          }

          final courses = snapshot.data!;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserProfile(),
                  SizedBox(height: 20),
                  _buildSubjectsGrid(courses, context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserProfile() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Annie Duffy',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Class X, CBSE, Board Exam',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubjectsGrid(List<Course> courses, BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return _buildSubjectCard(context, courses[index]);
      },
    );
  }

  Widget _buildSubjectCard(BuildContext context, Course course) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChapterListPage(subjectName: course.name),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFECC8),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book, size: 40, color: Color(0xFFFFB0B0)),
            SizedBox(height: 8),
            Text(
              course.name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(course.students, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

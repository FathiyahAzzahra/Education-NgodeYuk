import 'package:flutter/material.dart';
import 'chapters.dart';

class CoursesPage extends StatelessWidget {
  final String userName = "Annie Duffy";
  final String userClass = "Class X, CBSE, Board Exam";

  final List<Map<String, String>> subjects = [
    {"name": "Java", "students": "150 Students"},
    {"name": "C++", "students": "120 Students"},
    {"name": "Python", "students": "200 Students"},
    {"name": "Dart", "students": "100 Students"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFF7D1),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFB0B0),
        title: Text("Courses"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserProfile(),
              SizedBox(height: 20),
              _buildSubjectsGrid(),
              SizedBox(height: 20),
              Text("General Videos",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              _buildCarousel(['Video 1', 'Video 2', 'Video 3']),
              SizedBox(height: 20),
              Text("Live Classes",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              _buildCarousel(['Live 1', 'Live 2', 'Live 3']),
              SizedBox(height: 20),
              Text("Popular Videos",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              _buildCarousel(['Popular 1', 'Popular 2', 'Popular 3']),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          // backgroundImage: AssetImage('assets/user_profile.jpg'), // Ganti dengan path gambar profil Anda
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              userClass,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubjectsGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        return _buildSubjectCard(context, subjects[index]);
      },
    );
  }

  Widget _buildSubjectCard(BuildContext context, Map<String, String> subject) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChapterListPage(subjectName: subject['name']!)),
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
              subject['name']!,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(subject['students']!, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel(List<String> items) {
    return Container(
      height: 150,
      child: PageView.builder(
        itemCount: items.length,
        controller: PageController(viewportFraction: 0.8),
        itemBuilder: (context, index) {
          return _buildVideoCard(items[index]);
        },
      ),
    );
  }

  Widget _buildVideoCard(String title) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Color(0xFFFFB0B0),
        borderRadius: BorderRadius.circular(16),
        // image: const DecorationImage(
        //   image: AssetImage(
        //       'assets/sample_video_thumbnail.jpg'), // Ganti dengan gambar video yang sesuai
        //   fit: BoxFit.cover,
        // ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.black.withOpacity(0.3),
        ),
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.all(12),
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ngodeyuk/screens/courses/chapters.dart';
import '../../services/firestore_service.dart'; // Import FirestoreService
import '../../models/course_model.dart'; // Pastikan path-nya sesuai
import '../courses/PremiumCoursesPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoursesPage extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color(0xffF5F5F5), // Latar belakang lebih terang agar elemen menonjol
      appBar: AppBar(
        backgroundColor:
            Color(0xFF383A56), // Gunakan warna lebih gelap pada AppBar
        title: Row(
          children: [
            Icon(Icons.school, color: Color(0xFFEDE68A)),
            SizedBox(width: 8),
            Text(
              "Courses",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xFFEDE68A), // Warna terang untuk teks judul
              ),
            ),
          ],
        ),
        elevation: 4,
        shadowColor: Color(0xFF383A56),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Color(0xFFEDE68A)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings, color: Color(0xFFEDE68A)),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder(
        future: firestoreService.getCourses(),
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
                  Text(
                    'Courses',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F3032), // Text color for headers
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildSubjectsGrid(courses, context),
                  SizedBox(height: 30),
                  _buildPremiumSection(context),
                  SizedBox(height: 20),
                  Text(
                    'Popular Courses',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F3032), // Text color for headers
                    ),
                  ),
                  SizedBox(height: 10),
                  _buildPopularCourse(
                    'Front End Web Development',
                    'Jeni Ikandar',
                    '\$350',
                    '1h 37m',
                    17,
                  ),
                  _buildPopularCourse(
                    'Intro to Design System',
                    'Ahmad Musa',
                    '\$175',
                    '1h 23m',
                    15,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserProfile() {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Tampilkan loader saat menunggu data
        }

        if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
          return Text(
              'Error loading user data'); // Tampilkan error jika data tidak ada
        }

        var userData = snapshot.data!.data() as Map<String, dynamic>;

        return Row(
          children: [
            CircleAvatar(
              radius: 30,
              child: Text(
                userData['name'][0], // Huruf pertama nama sebagai avatar
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData['name'], // Nama pengguna dari Firestore
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F3032),
                  ),
                ),
                Text(
                  userData['email'], // Email pengguna dari Firestore
                  style: TextStyle(
                    fontSize: 14,
                    color:
                        Color(0xFF383A56), // Slightly muted for the description
                  ),
                ),
              ],
            ),
          ],
        );
      },
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
          color: Color(0xFFEDE68A), // New gold color for card background
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book, size: 40, color: Color(0xFF2F3032)),
            SizedBox(height: 8),
            Text(
              course.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF2F3032),
              ),
            ),
            SizedBox(height: 4),
            Text(
              course.students,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFF383A56),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF383A56), // Dark background for premium section
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      height: 160,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/zara/prem-class.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ingin belajar lebih?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:
                        Color(0xFFEDE68A), // Light yellow color for the heading
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PremiumCoursesPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFF2F3032), // Dark button background
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    "Kelas Premium",
                    style: TextStyle(
                      color: Color(0xFFEDE68A),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularCourse(String title, String instructor, String price,
      String duration, int lessons) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 5,
      color: Color(0xFFEDE68A), // Using gold background color
      child: ListTile(
        leading: Icon(
          Icons.book,
          color: Color(0xFF2F3032), // Icon color
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF2F3032), // Title color
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              instructor,
              style: TextStyle(
                color: Color(0xFF2F3032),
              ),
            ),
            Text(
              price,
              style: TextStyle(
                color: Color(0xFF2F3032),
              ),
            ),
            Row(
              children: [
                Text(
                  duration,
                  style: TextStyle(
                    color: Color(0xFF2F3032),
                  ),
                ),
                Spacer(),
                Text(
                  '$lessons Lessons',
                  style: TextStyle(
                    color: Color(0xFF2F3032),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward,
          color: Color(0xFF2F3032),
        ),
        onTap: () {},
      ),
    );
  }
}

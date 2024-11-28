import 'package:flutter/material.dart';
import 'package_page.dart';

class PremiumCoursesPage extends StatelessWidget {
  final List<Map<String, String>> courses = [
    {
      'title': 'English Academy Premium Dasher',
      'price': 'Rp3.428.600',
      'description': 'Untuk anak usia 3-6 tahun'
    },
    {
      'title': 'Science Explorer Pro',
      'price': 'Rp4.500.000',
      'description': 'Kursus eksklusif untuk pelajar usia 7-12 tahun'
    },
    {
      'title': 'Math Mastery Advanced',
      'price': 'Rp5.250.000',
      'description': 'Program intensif untuk menguasai matematika SD-SMA'
    },
    {
      'title': 'Coding For Kids',
      'price': 'Rp3.800.000',
      'description': 'Program belajar coding untuk anak usia 8-15 tahun'
    },
    {
      'title': 'Public Speaking Masterclass',
      'price': 'Rp6.000.000',
      'description':
          'Kursus untuk meningkatkan kemampuan berbicara di depan umum, usia 12+'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFF2F3032),
        title: Row(
          children: [
            Icon(Icons.star, color: Color(0xFFEDE68A)),
            SizedBox(width: 8),
            Text(
              "Kelas Premium",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Color(0xFFEDE68A)),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: courses.map((course) {
              return Column(
                children: [
                  _buildPremiumCourseCard(context, course),
                  SizedBox(height: 16), // Menambahkan jarak antar card
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumCourseCard(
      BuildContext context, Map<String, String> course) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFEDE68A),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course['title']!,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF2F3032)),
          ),
          SizedBox(height: 8),
          Text(
            course['description']!,
            style: TextStyle(fontSize: 14, color: Color(0xFF383A56)),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                course['price']!,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              ElevatedButton(
                onPressed: () {
                  // Kirim data paket yang dipilih ke PackagePage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PackagePage(course: course),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2F3032),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text("Cek Paket",
                    style: TextStyle(color: Color(0xFFEDE68A))),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
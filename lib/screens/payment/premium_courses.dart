import 'package:flutter/material.dart';
import 'package_page.dart';

class PremiumCoursesPage extends StatelessWidget {
  final List<Map<String, String>> courses = [
    {
      'title': 'English Academy Premium Dasher',
      'price': 'Rp3.428.600',
      'description': 'Untuk anak usia 3-6 tahun',
      'imageURL':
          'https://images.unsplash.com/photo-1543109740-4bdb38fda756?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    },
    {
      'title': 'Science Explorer Pro',
      'price': 'Rp4.500.000',
      'description': 'Kursus eksklusif untuk pelajar usia 7-12 tahun',
      'imageURL':
          'https://images.unsplash.com/photo-1596496356956-bbc213c96988?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    },
    {
      'title': 'Math Mastery Advanced',
      'price': 'Rp5.250.000',
      'description': 'Program intensif untuk menguasai matematika SD-SMA',
      'imageURL':
          'https://images.unsplash.com/photo-1676302440263-c6b4cea29567?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    },
    {
      'title': 'Coding For Kids',
      'price': 'Rp3.800.000',
      'description': 'Program belajar coding untuk anak usia 8-15 tahun',
      'imageURL':
          'https://images.unsplash.com/photo-1565229284535-2cbbe3049123?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    },
    {
      'title': 'Public Speaking Masterclass',
      'price': 'Rp6.000.000',
      'description':
          'Kursus untuk meningkatkan kemampuan berbicara di depan umum, usia 12+',
      'imageURL':
          'https://images.unsplash.com/photo-1505373877841-8d25f7d46678?q=80&w=2012&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFF383A56),
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
                fontSize: 20,
                color: Color(0xFF2F3032)),
          ),
          SizedBox(height: 8),
          if (course['imageURL'] != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                course['imageURL']!,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
            ),
          SizedBox(height: 8),
          Text(
            course['description']!,
            style: TextStyle(fontSize: 17, color: Color(0xFF383A56)),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                course['price']!,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PackagePage(course: course),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF383A56),
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

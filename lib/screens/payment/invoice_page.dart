import 'package:flutter/material.dart';
import 'premium_courses.dart';

class InvoicePage extends StatelessWidget {
  final Map<String, String> course;

  InvoicePage({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE68A),
      appBar: AppBar(
        backgroundColor: Color(0xFF2F3032),
        title: Text("Invoice", style: TextStyle(color: Color(0xFFEDE68A))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Pesan sukses dengan animasi
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              child: Icon(
                Icons.check_circle,
                color: Color(0xFF4CAF50),
                size: 80,
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Pembelian Berhasil!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: Color(0xFF4E4D09),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Selamat Belajar!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6D6B1D),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),

            // Gambar ilustrasi dengan animasi opacity
            AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(seconds: 1),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/128/8488/8488751.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 32),

            // Detail pembelian dalam card dengan bayangan lembut
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "📋 Detail Pembelian:",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2F3032),
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildDetailRow("Paket:", course['title']!),
                  SizedBox(height: 8),
                  _buildDetailRow("Harga:", course['price']!, isRed: true),
                ],
              ),
            ),

            Spacer(),

            // Tombol kembali dengan desain yang lebih modern
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => PremiumCoursesPage()),
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2F3032),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: Icon(Icons.home, color: Color(0xFFEDE68A)),
              label: Text(
                "Kembali",
                style: TextStyle(color: Color(0xFFEDE68A), fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isRed = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2F3032),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: isRed ? Colors.red : Color(0xFF2F3032),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class PremiumCoursesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF), // Warna latar belakang
      appBar: AppBar(
        backgroundColor: Color(0xFF2F3032), // Warna latar belakang AppBar
        title: Row(
          children: [
            Icon(Icons.star,
                color: Color(0xFFEDE68A)), // Ikon dengan warna kontras
            SizedBox(width: 8),
            Text(
              "Kelas Premium",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Color(0xFFEDE68A), // Warna teks judul
              ),
            ),
          ],
        ),
        elevation: 4, // Bayangan untuk AppBar
        shadowColor: Color(0xFF383A56), // Warna bayangan
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pilih paket kelas premium yang sesuai dengan kebutuhan Anda.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF383A56), // Warna teks
                ),
              ),
              SizedBox(height: 20),
              _buildPremiumCourseCard(
                context,
                "English Academy Premium Dasher",
                "Rp3.428.600",
                "Untuk anak usia 3 s.d. 6 tahun",
              ),
              SizedBox(height: 16),
              _buildPremiumCourseCard(
                context,
                "Science Explorer Pro",
                "Rp4.500.000",
                "Kursus eksklusif untuk pelajar usia 7-12 tahun",
              ),
              SizedBox(height: 16),
              _buildPremiumCourseCard(
                context,
                "Math Mastery Advanced",
                "Rp5.250.000",
                "Program intensif untuk menguasai matematika",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumCourseCard(
      BuildContext context, String title, String price, String description) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFEDE68A), // Warna latar belakang kartu
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF2F3032), // Warna teks judul
            ),
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF383A56), // Warna teks deskripsi
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red, // Warna harga
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Aksi untuk tombol
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(
                      0xFF2F3032), // Gunakan `backgroundColor` untuk versi Flutter terbaru
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Cek Paket",
                  style:
                      TextStyle(color: Color(0xFFEDE68A)), // Warna teks tombol
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget {
  final Map<String, String> course;

  InvoicePage({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFF2F3032),
        title: Text("Invoice", style: TextStyle(color: Color(0xFFEDE68A))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Pesan sukses
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 60,
            ),
            SizedBox(height: 16),
            Text(
              "Pembelian Berhasil!",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              "Selamat Belajar!",
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
                color: Colors.green,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),

            // Gambar ilustrasi
            Image.network(
              'https://cdn-icons-png.flaticon.com/512/9245/9245020.png',
              height: 150,
              width: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 32),

            // Detail pembelian
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "📋 Detail Pembelian:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F3032),
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildDetailRow("Paket:", course['title']!),
            SizedBox(height: 8),
            _buildDetailRow("Harga:", course['price']!, isRed: true),

            Spacer(),

            // Tombol kembali
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2F3032),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(Icons.arrow_back, color: Color(0xFFEDE68A)),
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
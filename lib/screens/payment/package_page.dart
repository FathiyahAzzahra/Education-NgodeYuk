import 'package:flutter/material.dart';
import 'invoice_page.dart';

class PackagePage extends StatelessWidget {
  final Map<String, String> course;

  PackagePage({required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFF2F3032),
        title: Text(
          "Paket Pilihan",
          style: TextStyle(color: Color(0xFFEDE68A)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Detail Paket:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2F3032),
                ),
              ),
              SizedBox(height: 16),
              _buildDetailCard(),
              SizedBox(height: 32),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _showPaymentDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2F3032),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    "Beli Paket",
                    style: TextStyle(color: Color(0xFFEDE68A)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFEDE68A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${course['title']}",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2F3032),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "💰 Harga: ${course['price']}",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "📚 Deskripsi Paket:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2F3032),
            ),
          ),
          SizedBox(height: 8),
          Text(
            _getCourseDescription(course['title']!),
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF2F3032),
            ),
          ),
        ],
      ),
    );
  }

  String _getCourseDescription(String title) {
    switch (title) {
      case 'English Academy Premium Dasher':
        return '''
Program ini dirancang khusus untuk anak usia 3-6 tahun agar dapat membangun fondasi bahasa Inggris yang kokoh melalui pendekatan interaktif dan menyenangkan. Paket ini meliputi:

• 20x Live Class Premium dengan pengajar berpengalaman internasional.
• Video Pembelajaran Eksklusif yang dapat diakses kapan saja.
• Penilaian Perkembangan Anak melalui laporan belajar bulanan.
• Aktivitas Interaktif berbasis cerita dan permainan.
• Rekomendasi Latihan Pribadi untuk meningkatkan kemampuan sesuai kebutuhan individu.
• Bonus: Sertifikat kelulusan untuk meningkatkan kepercayaan diri si kecil!
        ''';
      case 'Science Explorer Pro':
        return '''
Jelajahi dunia sains melalui kursus eksklusif untuk anak usia 7-12 tahun yang penuh eksperimen dan pengetahuan mendalam. Paket ini meliputi:

• 25x Live Class Interaktif dengan materi berbasis STEM (Sains, Teknologi, Teknik, Matematika).
• Modul Eksperimen Mandiri yang mudah diikuti di rumah.
• Penilaian Kompetensi Sains melalui kuis dan latihan interaktif.
• Materi Video Lengkap untuk mempelajari konsep-konsep ilmiah secara visual.
• Forum Diskusi Online dengan pengajar dan teman-teman seusia.
• Bonus: Akses ke "Virtual Science Lab" untuk simulasi eksperimen nyata!
        ''';
      case 'Math Mastery Advanced':
        return '''
Tingkatkan kemampuan matematika Anda dengan program intensif yang dirancang untuk pelajar yang ingin menguasai konsep dan teknik tingkat lanjut. Paket ini meliputi:

• 30x Sesi Live Class Premium dengan pembahasan soal dari dasar hingga kompleks.
• Rekaman Kelas yang dapat diakses kapan saja untuk mengulang materi.
• Variasi Soal Latihan dari level dasar hingga level olimpiade.
• Rasionalisasi Konsep Matematika untuk membantu memahami teori secara mendalam.
• Leaderboard Kompetisi Latihan untuk memacu semangat belajar dengan siswa lain.
• Bonus: Ebook "Strategi Menaklukkan Matematika" dan sertifikat keahlian eksklusif!
        ''';
      case 'Coding For Kids':
        return '''
Mulailah perjalanan seru belajar coding dengan kursus yang dirancang khusus untuk anak usia 8-15 tahun. Paket ini meliputi:

• 15x Live Class Interaktif untuk mempelajari dasar-dasar pemrograman.
• Modul Projek Coding untuk menciptakan aplikasi sederhana.
• Pengenalan Logika dan Algoritma melalui permainan edukatif.
• Akses ke Platform Pembelajaran Online untuk latihan tambahan.
• Sertifikat Proyek Coding sebagai pengakuan atas hasil belajar.
• Bonus: E-book "Langkah Awal Menjadi Programmer" untuk eksplorasi lebih lanjut.
      ''';
      case 'Public Speaking Masterclass':
        return '''
Kuasai seni berbicara di depan umum dengan kursus yang dirancang untuk meningkatkan kepercayaan diri dan kemampuan komunikasi Anda. Paket ini meliputi:

• 10x Sesi Live Workshop dengan pelatih public speaking berpengalaman.
• Latihan Praktik dalam kelas untuk meningkatkan keterampilan secara langsung.
• Video Panduan Lengkap untuk membangun teknik komunikasi yang efektif.
• Feedback Pribadi dari pelatih untuk memperbaiki kelemahan individu.
• Penilaian Progres dengan simulasi presentasi di akhir kursus.
• Bonus: Sertifikat Masterclass dan video rekaman performa Anda!
      ''';
      default:
        return "Deskripsi tidak tersedia.";
    }
  }

  void _showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Pilih Metode Pembayaran",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F3032),
                  ),
                ),
                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 8),
                _buildPaymentTile(
                  "Gopay",
                  "https://crm.thetempogroup.com/api/v1/media/product_image/image/6",
                  context,
                ),
                _buildPaymentTile(
                  "ShopeePay",
                  "https://seeklogo.com/images/S/shopeepay-logo-11DACD6CCF-seeklogo.com.png",
                  context,
                ),
                _buildPaymentTile(
                  "OVO",
                  "https://vectorez.biz.id/wp-content/uploads/2024/05/Logo-OVO-1@0.5x.png",
                  context,
                ),
                _buildPaymentTile(
                  "E-Banking",
                  "https://seeklogo.com/images/B/bca-mobile-app-logo-226045B76E-seeklogo.com.png",
                  context,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentTile(
      String title, String imageUrl, BuildContext context) {
    return ListTile(
      leading: Image.network(
        imageUrl,
        width: 40,
        height: 40,
        fit: BoxFit.contain,
      ),
      title: Text(
        title,
        style: TextStyle(color: Color(0xFF2F3032)),
      ),
      onTap: () {
        _showPinDialog(context, title);
      },
    );
  }

  // Function to show the PIN dialog
  void _showPinDialog(BuildContext context, String paymentMethod) {
    List<String> pinDigits = List.filled(6, ""); // Menyimpan PIN
    int currentIndex = 0; // Indeks saat ini untuk input PIN

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Color(0xFFEDE68A), // Warna latar belakang
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Masukkan PIN untuk $paymentMethod",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2F3032),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(6, (index) {
                        return Container(
                          width: 40,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              pinDigits[index].isEmpty ? "" : "●", // Simbol PIN
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2F3032),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        String value = index < 9
                            ? "${index + 1}"
                            : (index == 9
                                ? "B"
                                : index == 10
                                    ? "0"
                                    : "C");
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (value == "B" && currentIndex > 0) {
                                currentIndex--;
                                pinDigits[currentIndex] =
                                    ""; // Hapus digit terakhir
                              } else if (value == "C") {
                                pinDigits.fillRange(0, 6, ""); // Reset semua
                                currentIndex = 0;
                              } else if (currentIndex < 6) {
                                pinDigits[currentIndex] = value;
                                currentIndex++;
                              }
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF2F3032),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFEDE68A),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Batal",
                            style: TextStyle(color: Color(0xFF2F3032)),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            if (currentIndex == 6) {
                              // Pastikan PIN lengkap
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      InvoicePage(course: course),
                                ),
                              );
                            }
                          },
                          child: Text(
                            "Konfirmasi",
                            style: TextStyle(color: Color(0xFF2F3032)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

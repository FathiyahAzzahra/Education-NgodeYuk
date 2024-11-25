import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  // Color constants
  static const Color primaryColor = Colors.white; // Background color
  static const Color secondaryColor =
      Color(0xFFFFF8C7); // Notification item background color
  static const Color accentColor =
      Color(0xFF383A56); // Navbar and divider color
  static const Color iconBackgroundColor = Color(0xFFDDCA63); // Icon background
  static const Color iconColor = Color(0xFF2F3032); // Icon color

  final List<Map<String, String>> notifications = const [
    {
      'title': '🔥 Diskon Spesial!',
      'description':
          '💰 50% OFF untuk kursus Bahasa Inggris Premium! Promo berlaku hingga 30 November 2024.',
      'date': '24-11-2024',
      'time': '10:00 am',
    },
    {
      'title': '📚 Kelas Promo untuk Anak SMA',
      'description':
          '✨ Kursus Matematika Tingkat SMA tersedia dengan harga spesial! Daftar sekarang dan mulai belajar.',
      'date': '23-11-2024',
      'time': '02:30 pm',
    },
    {
      'title': '🎁 Voucher Gratis!',
      'description':
          '🎉 Ikuti kelas Coding for Kids dan dapatkan Voucher Rp100.000. Hanya untuk 10 pendaftar pertama!',
      'date': '22-11-2024',
      'time': '01:00 pm',
    },
    {
      'title': '🌟 Eksklusif untuk Pelanggan Baru',
      'description':
          '✨ Pelanggan baru akan mendapatkan modul gratis untuk kursus apa saja yang dipilih.',
      'date': '21-11-2024',
      'time': '04:00 pm',
    },
    {
      'title': '⏳ Periode Terbatas!',
      'description':
          '🗣️ Pendaftaran kursus Public Speaking dibuka hingga 1 Desember 2024. Jangan lewatkan!',
      'date': '20-11-2024',
      'time': '08:45 am',
    },
    {
      'title': '🎓 Seminar Gratis!',
      'description':
          '👩‍🏫 Ikuti seminar How to Ace Your Exams tanpa biaya! Registrasi sebelum 25 November 2024.',
      'date': '19-11-2024',
      'time': '09:30 am',
    },
    {
      'title': '🚀 Update Materi Baru!',
      'description':
          '📖 Materi kursus Data Science telah diperbarui dengan bab terbaru! Jangan sampai ketinggalan.',
      'date': '18-11-2024',
      'time': '07:00 pm',
    },
    {
      'title': '👨‍💻 Kursus Coding untuk Pemula',
      'description':
          '💻 Mulai belajar coding dari nol dengan kursus interaktif. Promo berlaku hingga 27 November 2024.',
      'date': '17-11-2024',
      'time': '06:15 pm',
    },
    {
      'title': '🎯 Tantangan Belajar Bulanan',
      'description':
          '🏆 Ikuti tantangan belajar dan dapatkan kesempatan memenangkan hadiah menarik!',
      'date': '16-11-2024',
      'time': '11:00 am',
    },
    {
      'title': '📝 Kursus Menulis Kreatif',
      'description':
          '📜 Temukan cara menjadi penulis kreatif! Kursus dengan mentor profesional dimulai 5 Desember 2024.',
      'date': '15-11-2024',
      'time': '03:45 pm',
    },
    {
      'title': '🔔 Reminder: Perbarui Paket Premium',
      'description':
          '⏰ Jangan lupa perbarui paket premium Anda untuk terus mengakses materi tanpa gangguan.',
      'date': '14-11-2024',
      'time': '10:20 am',
    },
    {
      'title': '🛍️ Flash Sale Hari Ini!',
      'description':
          '⏳ Dapatkan diskon hingga 70% untuk semua kursus dalam kategori teknologi. Promo hanya berlaku hari ini!',
      'date': '13-11-2024',
      'time': '08:00 am',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor, // Set background color
      appBar: appBar(),
      body: buildListView(),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      backgroundColor: accentColor, // Set navbar background color
      elevation: 0,
      title: Row(
        children: [
          Icon(
            Icons.notifications,
            color: Color(0xFFEDE68A), // Bell icon color
          ),
          SizedBox(width: 8), // Space between icon and title
          Text(
            'Notification Screen',
            style: TextStyle(
              color: Color(0xFFEDE68A), // Title text color
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.settings,
            color: Color(0xFFEDE68A), // Settings icon color
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildListView() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListViewItem(notifications[index]);
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 0,
          color: accentColor, // Divider color
        );
      },
      itemCount: notifications.length,
    );
  }

  Widget ListViewItem(Map<String, String> notification) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      decoration: BoxDecoration(
        color: secondaryColor, // Set list item background color
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message(notification),
                  timeAndDate(notification),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget prefixIcon() {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: iconBackgroundColor, // Icon background color
      ),
      child: Icon(
        Icons.notifications,
        size: 25,
        color: iconColor, // Icon color
      ),
    );
  }

  Widget message(Map<String, String> notification) {
    return Container(
      child: RichText(
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: '${notification['title']} ',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: notification['description'],
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeAndDate(Map<String, String> notification) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            notification['date']!,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black54,
            ),
          ),
          Text(
            notification['time']!,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  static const Color primaryColor = Colors.white;
  static const Color secondaryColor = Color(0xFFFFF8C7);
  static const Color accentColor = Color(0xFF383A56);
  static const Color iconBackgroundColor = Color(0xFFDDCA63);
  static const Color iconColor = Color(0xFF2F3032);

  final List<Map<String, String>> notifications = const [
    {
      'title': '🔥 Diskon Spesial!',
      'description':
          '💰 50% OFF untuk kursus Bahasa Inggris Premium! Promo berlaku hingga 30 November 2024.',
      'date': '24-11-2024',
      'time': '10:00 am',
      'imageUrl':
          'https://images.unsplash.com/photo-1543109740-4bdb38fda756?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': '📚 Kelas Promo untuk Anak SMA',
      'description':
          '✨ Kursus Matematika Tingkat SMA tersedia dengan harga spesial! Daftar sekarang dan mulai belajar.',
      'date': '23-11-2024',
      'time': '02:30 pm',
      'imageUrl':
          'https://images.unsplash.com/photo-1509869175650-a1d97972541a?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': '🎁 Voucher Gratis!',
      'description':
          '🎉 Ikuti kelas Coding for Kids dan dapatkan Voucher Rp100.000. Hanya untuk 10 pendaftar pertama!',
      'date': '22-11-2024',
      'time': '01:00 pm',
      'imageUrl':
          'https://images.unsplash.com/photo-1662116138312-ad7926c2e018?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': '🌟 Eksklusif untuk Pelanggan Baru',
      'description':
          '✨ Pelanggan baru akan mendapatkan modul gratis untuk kursus apa saja yang dipilih.',
      'date': '21-11-2024',
      'time': '04:00 pm',
      'imageUrl':
          'https://images.unsplash.com/photo-1543269865-cbf427effbad?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': '⏳ Periode Terbatas!',
      'description':
          '🗣 Pendaftaran kursus Public Speaking dibuka hingga 1 Desember 2024. Jangan lewatkan!',
      'date': '20-11-2024',
      'time': '08:45 am',
      'imageUrl':
          'https://images.unsplash.com/photo-1515603403036-f3d35f75ca52?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': '🎓 Seminar Gratis!',
      'description':
          '👩‍🏫 Ikuti seminar How to Ace Your Exams tanpa biaya! Registrasi sebelum 25 November 2024.',
      'date': '19-11-2024',
      'time': '09:30 am',
      'imageUrl':
          'https://images.unsplash.com/photo-1606326608606-aa0b62935f2b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': '🚀 Update Materi Baru!',
      'description':
          '📖 Materi kursus Data Science telah diperbarui dengan bab terbaru! Jangan sampai ketinggalan.',
      'date': '18-11-2024',
      'time': '07:00 pm',
      'imageUrl':
          'https://images.unsplash.com/photo-1542744173-05336fcc7ad4?q=80&w=2002&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': '👨‍💻 Kursus Coding untuk Pemula',
      'description':
          '💻 Mulai belajar coding dari nol dengan kursus interaktif. Promo berlaku hingga 27 November 2024.',
      'date': '17-11-2024',
      'time': '06:15 pm',
      'imageUrl':
          'https://images.unsplash.com/photo-1504639725590-34d0984388bd?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': '🎯 Tantangan Belajar Bulanan',
      'description':
          '🏆 Ikuti tantangan belajar dan dapatkan kesempatan memenangkan hadiah menarik!',
      'date': '16-11-2024',
      'time': '11:00 am',
      'imageUrl':
          'https://images.unsplash.com/photo-1517673132405-a56a62b18caf?q=80&w=1776&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': '📝 Kursus Menulis Kreatif',
      'description':
          '📜 Temukan cara menjadi penulis kreatif! Kursus dengan mentor profesional dimulai 5 Desember 2024.',
      'date': '15-11-2024',
      'time': '03:45 pm',
      'imageUrl':
          'https://images.unsplash.com/photo-1501504905252-473c47e087f8?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': '🔔 Reminder: Perbarui Paket Premium',
      'description':
          '⏰ Jangan lupa perbarui paket premium Anda untuk terus mengakses materi tanpa gangguan.',
      'date': '14-11-2024',
      'time': '10:20 am',
      'imageUrl':
          'https://images.unsplash.com/photo-1556761175-b413da4baf72?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': '🛍 Flash Sale Hari Ini!',
      'description':
          '⏳ Dapatkan diskon hingga 70% untuk semua kursus dalam kategori teknologi. Promo hanya berlaku hari ini!',
      'date': '13-11-2024',
      'time': '08:00 am',
      'imageUrl':
          'https://images.unsplash.com/photo-1531482615713-2afd69097998?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: accentColor,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.notifications, color: Color(0xFFEDE68A)),
            SizedBox(width: 8),
            Text(
              'Notification Screen',
              style: TextStyle(color: Color(0xFFEDE68A)),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Color(0xFFEDE68A)),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationDetailPage(
                    notification: notifications[index],
                  ),
                ),
              );
            },
            child: ListViewItem(notifications[index]),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 0, color: accentColor);
        },
      ),
    );
  }

  Widget ListViewItem(Map<String, String> notification) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          prefixIcon(),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
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
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      notification['date']!,
                      style: TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                    Text(
                      notification['time']!,
                      style: TextStyle(fontSize: 10, color: Colors.black54),
                    ),
                  ],
                ),
              ],
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
        color: iconBackgroundColor,
      ),
      child: Icon(Icons.notifications, size: 25, color: iconColor),
    );
  }
}

class NotificationDetailPage extends StatelessWidget {
  final Map<String, String> notification;

  const NotificationDetailPage({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF383A56),
        elevation: 0,
        title: Text(notification['title']!,
            style: TextStyle(color: Color(0xFFEDE68A))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFEDE68A),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(notification['imageUrl']!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              notification['title']!,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              notification['description']!,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${notification['date']}',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Text(
                  'Time: ${notification['time']}',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
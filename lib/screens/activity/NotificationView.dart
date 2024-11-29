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
    // Tambahkan elemen lainnya di sini...
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
              style: TextStyle(
                color: Color(0xFFEDE68A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
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
            child: listViewItem(notifications[index]),
          );
        },
        separatorBuilder: (context, index) => Divider(
          height: 0,
          color: accentColor,
        ),
      ),
    );
  }

  Widget listViewItem(Map<String, String> notification) {
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
          ),
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
        title: Text(
          notification['title']!,
          style: TextStyle(color: Color(0xFFEDE68A)),
        ),
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

import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  // Color constants from provided palette
  static const Color primaryColor = Color(0xFFFFF7D1);
  static const Color secondaryColor = Color(0xFFFFECC8);
  static const Color accentColor = Color(0xFFFFD09B);
  static const Color highlightColor = Color(0xFFFFB0B0);

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
      title: Text('Notification Screen'),
      backgroundColor: highlightColor, // Set app bar color
      elevation: 0,
    );
  }

  Widget buildListView() {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListViewItem(index);
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 0,
          color: accentColor, // Set divider color
        );
      },
      itemCount: 15,
    );
  }

  Widget ListViewItem(int index) {
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
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message(index),
                  timeAndDate(index),
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
        color: accentColor, // Set icon background color
      ),
      child: Icon(
        Icons.notifications,
        size: 25,
        color: highlightColor, // Set icon color
      ),
    );
  }

  Widget message(int index) {
    double textSize = 14;
    return Container(
      child: RichText(
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        text: TextSpan(
          text: 'Message ',
          style: TextStyle(
            fontSize: textSize,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: 'Notification Description',
              style: TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget timeAndDate(int index) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '04-11-2024',
            style: TextStyle(
              fontSize: 10,
              color: Colors.black54,
            ),
          ),
          Text(
            '08.00 am',
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

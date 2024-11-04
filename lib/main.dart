import 'package:flutter/material.dart';
import 'screens/home/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(), // Menetapkan HomePage sebagai halaman utama
    );
  }
}

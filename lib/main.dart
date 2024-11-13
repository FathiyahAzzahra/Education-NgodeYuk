// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firestore_service.dart';
import 'package:ngodeyuk/controller/course_controller.dart';
import 'screens/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirestoreService firestoreService = FirestoreService();
  AppController appController = AppController(firestoreService);

  // Inisialisasi data awal
  await appController.initializeAppData();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

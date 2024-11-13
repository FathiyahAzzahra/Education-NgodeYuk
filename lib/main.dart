// lib/main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/firestore_service.dart';
import '../controller/course_controller.dart';
import 'screens/home/home_page.dart';
import 'screens/welcome/login_screen.dart'; // Impor LoginScreen
import 'screens/welcome/welcome_screen.dart'; // Impor WelcomeScreen

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/welcome', // Rute awal diatur ke WelcomeScreen
      routes: {
        '/welcome': (context) =>
            WelcomeScreen(), // Definisikan rute WelcomeScreen
        '/login': (context) => LoginScreen(), // Definisikan rute LoginScreen
        '/home': (context) => HomePage(), // Definisikan rute HomePage
      },
    );
  }
}

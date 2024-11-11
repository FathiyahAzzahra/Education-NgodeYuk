// lib/controllers/app_controller.dart
import '../services/firestore_service.dart';

class AppController {
  final FirestoreService firestoreService;

  AppController(this.firestoreService);

  Future<void> initializeAppData() async {
    await firestoreService
        .addInitialData(); // Menambahkan data awal ke Firebase
  }
}

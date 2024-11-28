import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/comment_model.dart';
import '../models/user_model.dart';

class CommentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Mendapatkan komentar berdasarkan chapterId
  Stream<List<Comment>> getComments(String chapterId) {
    return _firestore
        .collection('comments') // Pastikan nama koleksi sesuai
        .where('chapterId',
            isEqualTo: chapterId) // Filter berdasarkan chapterId
        .orderBy('timestamp', descending: true) // Urutkan berdasarkan waktu
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map<Comment>((doc) {
        final data = doc.data();
        return Comment(
          userName: data['userName'] ?? 'Anonymous', // Default ke "Anonymous"
          userId: data['userId'] ?? '', // Default ke string kosong
          comment: data['comment'] ?? '', // Default ke string kosong
          timestamp: data['timestamp'] != null
              ? (data['timestamp'] as Timestamp).toDate()
              : DateTime.now(), // Default ke waktu sekarang jika null
          chapterId: data['chapterId'] ?? '', // Default ke string kosong
        );
      }).toList();
    });
  }

  // Menambahkan komentar baru
  Future<void> addComment(String chapterId, String comment) async {
    final userId = await _getUserId(); // Mendapatkan userId dari Firestore
    await _firestore.collection('comments').add({
      'chapterId': chapterId,
      'comment': comment,
      'userName': 'Anonymous', // Bisa diganti dengan data user
      'userId': userId,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // Mendapatkan userId dari Firestore berdasarkan FirebaseAuth user
  Future<String> _getUserId() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      // Mengambil userId dari Firestore berdasarkan uid
      final userDoc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();
      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          final userModel = UserModel.fromMap(userData);
          return userModel.uid; // Kembalikan userId
        }
      }
    }
    return 'Anonymous'; // Jika tidak ada pengguna atau kesalahan, kembalikan 'Anonymous'
  }
}

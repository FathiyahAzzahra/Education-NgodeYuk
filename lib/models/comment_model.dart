import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String userName;
  final String userId;
  final String comment;
  final DateTime timestamp; // Gunakan DateTime untuk lebih fleksibel
  final String chapterId;

  Comment({
    required this.userName,
    required this.userId,
    required this.comment,
    required this.timestamp,
    required this.chapterId,
  });

  /// Membuat objek `Comment` dari Map yang didapatkan dari Firestore
  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      userName:
          map['userName'] ?? 'Anonymous', // Default jika `userName` kosong
      userId: map['userId'] ?? '', // Default ke string kosong jika tidak ada
      comment: map['comment'] ?? '', // Default ke string kosong
      timestamp: map['timestamp'] is Timestamp
          ? (map['timestamp'] as Timestamp)
              .toDate() // Konversi jika `Timestamp`
          : DateTime
              .now(), // Default ke waktu sekarang jika null atau tidak valid
      chapterId: map['chapterId'] ?? '', // Default ke string kosong
    );
  }

  /// Mengonversi objek `Comment` menjadi Map untuk disimpan di Firestore
  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'userId': userId,
      'comment': comment,
      'timestamp': Timestamp.fromDate(timestamp), // Konversi ke Timestamp
      'chapterId': chapterId,
    };
  }
}

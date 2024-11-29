import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String title;
  final DateTime date; // Ubah menjadi DateTime
  final String time;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
  });

  factory EventModel.fromMap(Map<String, dynamic> map, String id) {
    return EventModel(
      id: id,
      title: map['name'],
      date: (map['date'] as Timestamp)
          .toDate(), // Mengonversi Timestamp ke DateTime
      time: map['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': Timestamp.fromDate(date), // Mengonversi DateTime ke Timestamp
      'time': time,
    };
  }
}

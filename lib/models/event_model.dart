class Event {
  String id;
  String name;
  DateTime date;
  String time;

  Event({
    required this.id,
    required this.name,
    required this.date,
    required this.time,
  });

  factory Event.fromMap(Map<String, dynamic> map, String id) {
    return Event(
      id: id,
      name: map['name'],
      date: DateTime.parse(map['date']), // Pastikan formatnya sesuai
      time: map['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Tambahkan id agar sesuai struktur Firebase
      'name': name,
      'date': date.toIso8601String(), // Simpan dalam format ISO
      'time': time,
    };
  }
}

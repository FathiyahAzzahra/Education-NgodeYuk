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

  // Menyesuaikan dariMap untuk mendukung waktu
  factory Event.fromMap(Map<String, dynamic> map, String id) {
    return Event(
      id: id,
      name: map['name'],
      date: DateTime.parse(map['date']),
      time: map['time'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date.toIso8601String(),
      'time': time,
    };
  }
}

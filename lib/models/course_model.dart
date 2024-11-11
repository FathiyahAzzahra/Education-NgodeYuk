class Course {
  final String name;
  final String students;

  Course({
    required this.name,
    required this.students,
  });

  // Membuat objek Course dari Map yang didapatkan dari Firestore
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      name: map['name'] ?? '',
      students: map['students'] ?? '',
    );
  }

  // Mengubah objek Course menjadi Map untuk disimpan di Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'students': students,
    };
  }
}

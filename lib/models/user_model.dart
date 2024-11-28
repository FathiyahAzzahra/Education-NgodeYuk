class UserModel {
  final String uid;
  final String name;
  final String email;
  final Map<String, List<String>> completedCourses;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.completedCourses,
  });

  // Factory method untuk membuat objek UserModel dari Map (Firestore)
  factory UserModel.fromMap(Map<String, dynamic> map) {
    // Ambil completedCourses dari Map dan pastikan itu Map<String, List<dynamic>>
    var completedCoursesMap =
        map['completedCourses'] as Map<String, dynamic>? ?? {};

    // Konversi Map<String, List<dynamic>> menjadi Map<String, List<String>>
    Map<String, List<String>> courses = {};
    completedCoursesMap.forEach((key, value) {
      if (value is List) {
        courses[key] = List<String>.from(value.map(
            (e) => e.toString())); // Pastikan elemen dalam List adalah String
      } else {
        courses[key] = [];
      }
    });

    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      completedCourses: courses,
    );
  }

  // Method untuk mengonversi objek UserModel menjadi Map (Firestore)
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'completedCourses': completedCourses,
    };
  }
}

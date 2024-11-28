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
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      completedCourses:
          Map<String, List<String>>.from(map['completedCourses'] ?? {}),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/user_model.dart';

class AuthMethod {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // SignUp User
  Future<String> signupUser({
    required String email,
    required String password,
    required String name,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        UserModel newUser = UserModel(
          uid: cred.user!.uid,
          name: name,
          email: email,
          completedCourses: {}, // Inisialisasi map kosong untuk completedCourses
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(newUser.toMap());

        res = "success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // logIn user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // Memuat data pengguna
  Future<UserModel?> getUserData() async {
    try {
      final userId = _auth.currentUser!.uid;
      final userDoc = await _firestore.collection("users").doc(userId).get();

      if (userDoc.exists) {
        return UserModel.fromMap(userDoc.data()!);
      }
    } catch (err) {
      print("Error fetching user data: $err");
    }
    return null;
  }

  // LogOut User
  Future<void> signOut() async {
    await _auth.signOut();
  }
}

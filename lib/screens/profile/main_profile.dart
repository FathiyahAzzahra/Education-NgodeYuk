import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_profile_screen.dart';
import '../authentication/login.dart';

class MainProfileScreen extends StatefulWidget {
  @override
  _MainProfileScreenState createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends State<MainProfileScreen> {
  Map<String, dynamic>? _userData;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  // Fetch user profile from Firestore
  Future<void> _fetchUserProfile() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        setState(() {
          _userData = userDoc.data() as Map<String, dynamic>?;
        });
      }
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  // Logout function
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFFB0A565), // Mengubah warna teks
            fontWeight: FontWeight.bold, // Membuat teks menjadi bold
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF383A56), // Mengubah warna AppBar
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFEDE68A),
              Color(0xFFB7C8F6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: _userData == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture Section
                      _buildProfilePicture(),
                      const SizedBox(height: 30),

                      // Profile Details Section
                      _buildProfileDetail(
                          'Full Name', _userData?['name'] ?? '', Icons.person),
                      const SizedBox(height: 20),
                      _buildProfileDetail(
                          'Email', _userData?['email'] ?? '', Icons.email),
                      const SizedBox(height: 20),
                      _buildProfileDetail(
                          'Phone', _userData?['mobile'] ?? '', Icons.phone),
                      const SizedBox(height: 20),
                      _buildProfileDetail(
                          'Status', _userData?['status'] ?? '', Icons.info),

                      const SizedBox(height: 30),

                      // Edit Profile Button
                      _buildButton(
                        text: 'Edit Profile',
                        onPressed: () async {
                          final updatedData = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(),
                            ),
                          );
                          if (updatedData != null) {
                            setState(() {
                              _userData = updatedData;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20),

                      // Log Out Button
                      _buildButton(
                        text: 'Log Out',
                        onPressed: _logout,
                      ),

                      // Extra space for scrolling
                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // Widget to build profile picture
  Widget _buildProfilePicture() {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(100),
      ),
      child: CircleAvatar(
        radius: 60,
        backgroundColor: Colors.white,
        backgroundImage: (_userData?['profile_image'] != null &&
                _userData?['profile_image'].isNotEmpty)
            ? NetworkImage(_userData?['profile_image'])
            : const AssetImage('assets/ngodeyuk_logo.png') as ImageProvider,
      ),
    );
  }

  // Widget to display profile details
  Widget _buildProfileDetail(String label, String value, IconData icon) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color(0xFF383A56),
        ),
        title: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(value),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      ),
    );
  }

  // Widget to build buttons
  Widget _buildButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        backgroundColor: const Color(0xFF383A56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 8,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}

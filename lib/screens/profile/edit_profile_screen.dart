import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic>? userData; // Accept userData as a parameter

  // Constructor to accept userData
  EditProfileScreen({this.userData});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _profileImage;
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _emailController;
  late TextEditingController _mobileController;
  late TextEditingController _passwordController;
  String _status = 'Student'; // Default value for status

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with user data if available
    _nameController = TextEditingController(text: widget.userData?['name']);
    _surnameController =
        TextEditingController(text: widget.userData?['surname']);
    _emailController = TextEditingController(text: widget.userData?['email']);
    _mobileController = TextEditingController(text: widget.userData?['mobile']);
    _passwordController =
        TextEditingController(text: widget.userData?['password']);

    // Initialize the status field based on user data if available
    if (widget.userData?['status'] != null) {
      _status = widget.userData!['status'];
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage() async {
    if (_profileImage == null)
      return ""; // Return empty string if no image selected
    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profile_pictures/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageRef.putFile(_profileImage!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print("Error uploading image: $e");
      return "";
    }
  }

  Future<void> _saveProfile() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) return;

      String imageUrl = await _uploadImage();
      Map<String, dynamic> userData = {
        'name': _nameController.text,
        'surname': _surnameController.text,
        'email': _emailController.text,
        'mobile': _mobileController.text,
        'password': _passwordController.text,
        'status': _status,
        'profile_image': imageUrl,
      };

      // Save data to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .set(userData);

      // Notify success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile saved successfully!")),
      );

      // Return to the previous screen with updated data
      Navigator.pop(context, userData);
    } catch (e) {
      print("Error saving profile: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to save profile")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Edit Profile",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB0A565),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : (widget.userData?['profile_image'] != null
                                ? NetworkImage(
                                    widget.userData!['profile_image'])
                                : const AssetImage('assets/avatar.png')
                                    as ImageProvider),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: const CircleAvatar(
                            radius: 18,
                            backgroundColor: Color(0xFF383A56),
                            child: Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                _buildTextField("Name", _nameController),
                const SizedBox(height: 15),
                _buildTextField("Surname", _surnameController),
                const SizedBox(height: 15),
                _buildTextField("Email", _emailController),
                const SizedBox(height: 15),
                _buildTextField("Mobile", _mobileController),
                const SizedBox(height: 15),
                _buildTextField("Password", _passwordController,
                    obscureText: true),
                const SizedBox(height: 15),

                // Status Dropdown
                DropdownButton<String>(
                  value: _status,
                  onChanged: (String? newValue) {
                    setState(() {
                      _status = newValue!;
                    });
                  },
                  items: <String>['Student', 'Teacher']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 60,
                    ),
                    backgroundColor: const Color(0xFF383A56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller,
      {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

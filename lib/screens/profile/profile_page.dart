import 'package:flutter/material.dart';
import 'package:ngodeyuk/screens/authentication/widgets/button.dart';
import 'package:ngodeyuk/screens/authentication/login.dart';
import 'package:ngodeyuk/screens/authentication/loginGoogle/google_auth.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Profile Page Content Goes Here',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20), // Add spacing between text and button
            MyButtons(
              onTap: () async {
                await FirebaseServices().googleSignOut();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              text: "Log Out",
            ),
          ],
        ),
      ),
    );
  }
}

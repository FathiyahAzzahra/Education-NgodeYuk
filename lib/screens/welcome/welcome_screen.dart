import '../welcome/login_screen.dart';
import '../widgets/customized_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _buildLogo(),
            const SizedBox(height: 40),
            _buildButton(
              context: context,
              text: "Login",
              backgroundColor: Colors.black,
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),
            _buildButton(
              context: context,
              text: "Register",
              backgroundColor: Colors.white,
              textColor: Colors.black,
              onPressed: () {
                // Register logic here
              },
            ),
            const SizedBox(height: 20),
            _buildGuestText(),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return const SizedBox(
      height: 130,
      width: 180,
      child: Image(
        image: AssetImage("assets/logo.png"),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return CustomizedButton(
      buttonText: text,
      buttonColor: backgroundColor,
      textColor: textColor,
      onPressed: onPressed,
    );
  }

  Widget _buildGuestText() {
    return const Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        "Continue as a Guest",
        style: TextStyle(
          color: Color(0xFFB0B0C7),
          fontSize: 25,
        ),
      ),
    );
  }
}

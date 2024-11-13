import '../widgets/customized_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/customized_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          color: const Color.fromARGB(255, 255, 255, 255),
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBackButton(context),
                const SizedBox(height: 20),
                _buildWelcomeText(),
                const SizedBox(height: 20),
                CustomizedTextfield(
                  myController: _emailController,
                  hintText: "Enter your Email",
                  isPassword: false,
                ),
                const SizedBox(height: 20),
                CustomizedTextfield(
                  myController: _passwordController,
                  hintText: "Enter your Password",
                  isPassword: true,
                ),
                const SizedBox(height: 10),
                _buildForgotPassword(),
                const SizedBox(height: 20),
                CustomizedButton(
                  buttonText: "Login",
                  buttonColor: const Color.fromARGB(56, 58, 86, 0),
                  textColor: const Color.fromARGB(56, 58, 86, 0),
                  onPressed: () {
                    // Add login logic here
                  },
                ),
                const SizedBox(height: 20),
                _buildSocialButtons(),
                const SizedBox(height: 140),
                _buildRegisterOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          icon: const Icon(Icons.arrow_back_ios_sharp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return const Text(
      "Welcome Back! Glad \nto see you again",
      style: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () {
          // Forgot Password logic
        },
        child: const Text(
          "Forgot Password?",
          style: TextStyle(
            color: Color(0x2F3032),
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialButton(FontAwesomeIcons.facebookF, Colors.blue, () {}),
        _buildSocialButton(FontAwesomeIcons.google, null, () {}),
        _buildSocialButton(FontAwesomeIcons.github, null, () {}),
      ],
    );
  }

  Widget _buildSocialButton(
      IconData icon, Color? color, VoidCallback onPressed) {
    return Container(
      height: 50,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildRegisterOption() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 8, 8, 8.0),
      child: Row(
        children: const [
          Text(
            "Don't have an account?",
            style: TextStyle(
              color: Color(0xff1E232C),
              fontSize: 15,
            ),
          ),
          SizedBox(width: 8),
          Text(
            "Register Now",
            style: TextStyle(
              color: Color(0xff35C2C1),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

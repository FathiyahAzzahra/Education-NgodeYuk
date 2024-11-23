import 'package:flutter/material.dart';
import 'package:ngodeyuk/screens/authentication/widgets/button.dart';
import 'package:ngodeyuk/screens/authentication/services/authentication.dart';
import 'package:ngodeyuk/screens/authentication/widgets/snackbar.dart';
import 'package:ngodeyuk/screens/authentication/widgets/text_field.dart';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signupUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethod().signupUser(
      email: emailController.text,
      password: passwordController.text,
      name: nameController.text,
    );
    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff183058),
      body: Stack(
        children: [
          // Latar belakang statis
          Positioned(
            top: size.height * 0.6,
            left: size.width * 0.2,
            child: CustomPaint(
              painter: MyPainter(50),
            ),
          ),
          Positioned(
            top: size.height * 0.9,
            left: size.width * 0.1,
            child: CustomPaint(
              painter: MyPainter(70),
            ),
          ),
          Positioned(
            top: size.height * 0.1,
            left: size.width * 0.7,
            child: CustomPaint(
              painter: MyPainter(90),
            ),
          ),
          // Konten utama
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height / 2.8,
                      child: Image.asset('assets/signup.png'),
                    ),
                    TextFieldInput(
                      icon: Icons.person,
                      textEditingController: nameController,
                      hintText: 'Enter your name',
                      textInputType: TextInputType.text,
                    ),
                    TextFieldInput(
                      icon: Icons.email,
                      textEditingController: emailController,
                      hintText: 'Enter your email',
                      textInputType: TextInputType.emailAddress,
                    ),
                    TextFieldInput(
                      icon: Icons.lock,
                      textEditingController: passwordController,
                      hintText: 'Enter your password',
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    MyButtons(onTap: signupUser, text: "Sign Up"),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: TextStyle(
                            color: Colors.white, // Color set to white
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double radius;

  MyPainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xffffffC5), Color(0xff706830)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(
        center: const Offset(0, 0),
        radius: radius,
      ));
    canvas.drawCircle(Offset.zero, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

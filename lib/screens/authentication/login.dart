import 'package:flutter/material.dart';
import 'package:ngodeyuk/screens/authentication/widgets/button.dart';
import 'package:ngodeyuk/screens/authentication/loginGoogle/google_auth.dart';
import 'package:ngodeyuk/screens/authentication/forgotPassword/forgot_password.dart';
import 'package:ngodeyuk/screens/authentication/phoneAuth/phone_login.dart';
import 'package:ngodeyuk/screens/authentication/services/authentication.dart';
import 'package:ngodeyuk/screens/authentication/widgets/snackbar.dart';
import 'package:ngodeyuk/screens/authentication/widgets/text_field.dart';
import 'package:ngodeyuk/screens/home/home_page.dart';
import 'signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthMethod().loginUser(
        email: emailController.text, password: passwordController.text);

    if (res == "success") {
      setState(() {
        isLoading = false;
      });

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
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
    double height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xff183058),
      body: Stack(
        children: [
          // Latar belakang
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
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: SizedBox(
                              height: height / 3,
                              child: Image.asset('assets/login.png'),
                            ),
                          ),
                          TextFieldInput(
                            icon: Icons.person,
                            textEditingController: emailController,
                            hintText: 'Enter your email',
                            textInputType: TextInputType.text,
                          ),
                          TextFieldInput(
                            icon: Icons.lock,
                            textEditingController: passwordController,
                            hintText: 'Enter your password',
                            textInputType: TextInputType.text,
                            isPass: true,
                          ),
                          const ForgotPassword(),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: MyButtons(onTap: loginUser, text: "Log In"),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child:
                                    Container(height: 1, color: Colors.black26),
                              ),
                              const Text("  or  "),
                              Expanded(
                                child:
                                    Container(height: 1, color: Colors.black26),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey),
                              onPressed: () async {
                                await FirebaseServices().signInWithGoogle();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomePage(),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Image.network(
                                      "https://ouch-cdn2.icons8.com/VGHyfDgzIiyEwg3RIll1nYupfj653vnEPRLr0AeoJ8g/rs:fit:456:456/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODg2/LzRjNzU2YThjLTQx/MjgtNGZlZS04MDNl/LTAwMTM0YzEwOTMy/Ny5wbmc.png",
                                      height: 35,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    "Continue with Google",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const PhoneAuthentication(),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: Colors
                                        .white, // Color set to white for the first part of the text
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "SignUp",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors
                                          .blue, // Color set to red for the "SignUp" part
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                );
              },
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

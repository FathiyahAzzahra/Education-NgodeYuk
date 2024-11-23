import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ngodeyuk/screens/home/home_page.dart';

class OTPScreen extends StatefulWidget {
  final String verificationId;

  const OTPScreen({super.key, required this.verificationId});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Menambahkan gambar di atas input OTP
            Image.asset(
              'assets/otp.png', // Ganti URL dengan URL gambar yang diinginkan
              height: 200, // Atur tinggi gambar sesuai kebutuhan
              width: 200, // Atur lebar gambar jika diperlukan
            ),
            const SizedBox(height: 20), // Spasi setelah gambar
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter OTP',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String otp = otpController.text.trim();

                // Verifikasi OTP dengan menggunakan verificationId
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: widget
                        .verificationId, // Menggunakan verificationId dari konstruktor
                    smsCode: otp,
                  );

                  // Menggunakan credential untuk sign-in
                  await FirebaseAuth.instance.signInWithCredential(credential);
                  print("OTP Verified and User Signed In!");
                  // Setelah berhasil login, arahkan ke halaman utama atau halaman lainnya
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                } catch (e) {
                  print("Error: $e");
                  // Tampilkan pesan kesalahan atau proses lebih lanjut jika diperlukan
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text(
                'Verify OTP',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

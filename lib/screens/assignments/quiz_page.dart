// import 'dart:async';
// import 'package:flutter/material.dart';

// // Pastikan class QuizPage tetap public agar bisa diakses oleh widget lainnya.
// class QuizPage extends StatefulWidget {
//   const QuizPage({Key? key}) : super(key: key); // Constructor dengan key

//   @override
//   _QuizPageState createState() =>
//       _QuizPageState(); // Membuat instance _QuizPageState
// }

// class _QuizPageState extends State<QuizPage> {
//   int _timeRemaining = 30; // Timer waktu kuis
//   late Timer _timer; // Timer yang akan menghitung mundur
//   bool _isQuizSubmitted = false; // Status jika kuis sudah disubmit
//   int _score = 0; // Skor kuis

//   // Daftar soal dan pilihan jawabannya
//   final List<Map<String, Object>> _questions = [
//     {
//       'question': 'Apa fungsi utama dari loop dalam pemrograman?',
//       'options': [
//         'Menampilkan teks',
//         'Mengulang perintah',
//         'Menghapus data',
//         'Menutup program'
//       ],
//       'answer': 'Mengulang perintah'
//     },
//     {
//       'question':
//           'Apa bahasa pemrograman yang paling umum digunakan untuk pengembangan aplikasi Android?',
//       'options': ['Python', 'Swift', 'Java', 'Ruby'],
//       'answer': 'Java'
//     },
//     {
//       'question': 'HTML adalah singkatan dari...',
//       'options': [
//         'Hyper Text Markup Language',
//         'High Transfer Machine Language',
//         'Hyperlink Machine Text',
//         'Hyper Text Made Language'
//       ],
//       'answer': 'Hyper Text Markup Language'
//     },
//     // Tambahkan soal lainnya jika perlu
//   ];

//   int _currentQuestionIndex = 0; // Menyimpan indeks soal yang sedang aktif
//   String? _selectedOption; // Menyimpan pilihan yang dipilih oleh pengguna

//   // Fungsi untuk memulai timer
//   void startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_timeRemaining > 0) {
//         setState(() {
//           _timeRemaining--;
//         });
//       } else {
//         _submitQuiz(); // Jika waktu habis, langsung kirimkan kuis
//       }
//     });
//   }

//   // Fungsi untuk mengirimkan kuis
//   void _submitQuiz() {
//     _timer.cancel(); // Menghentikan timer
//     setState(() {
//       _isQuizSubmitted = true; // Mengubah status menjadi sudah dikumpulkan
//     });
//   }

//   // Fungsi untuk mengecek jawaban yang dipilih
//   void _checkAnswer() {
//     if (_selectedOption == _questions[_currentQuestionIndex]['answer']) {
//       _score++; // Menambah skor jika jawaban benar
//     }
//     if (_currentQuestionIndex < _questions.length - 1) {
//       setState(() {
//         _currentQuestionIndex++; // Beralih ke soal berikutnya
//         _selectedOption = null; // Reset pilihan jawaban
//       });
//     } else {
//       _submitQuiz(); // Jika sudah pada soal terakhir, kirimkan kuis
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     startTimer(); // Memulai timer ketika widget pertama kali dimuat
//   }

//   @override
//   void dispose() {
//     _timer.cancel(); // Menghentikan timer saat widget dihancurkan
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Quiz'),
//       ),
//       body: Center(
//         child: _isQuizSubmitted
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Quiz telah dikumpulkan!',
//                     style: TextStyle(fontSize: 18, color: Colors.green[700]),
//                   ),
//                   const SizedBox(height: 10),
//                   Text(
//                     'Skor Anda: $_score dari ${_questions.length}',
//                     style: const TextStyle(
//                         fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                 ],
//               )
//             : Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Waktu tersisa: $_timeRemaining detik',
//                       style: const TextStyle(
//                           fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 20),
//                     Text(
//                       _questions[_currentQuestionIndex]['question'] as String,
//                       style: const TextStyle(
//                           fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 10),
//                     // Daftar pilihan jawaban dalam bentuk RadioListTile
//                     ...(_questions[_currentQuestionIndex]['options']
//                             as List<String>)
//                         .map((option) {
//                       return RadioListTile<String>(
//                         title: Text(option),
//                         value: option,
//                         groupValue: _selectedOption,
//                         onChanged: (value) {
//                           setState(() {
//                             _selectedOption = value; // Set pilihan yang dipilih
//                           });
//                         },
//                       );
//                     }).toList(),
//                     const SizedBox(height: 20),
//                     ElevatedButton(
//                       onPressed: _selectedOption != null ? _checkAnswer : null,
//                       child: const Text('Selanjutnya'),
//                     ),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }
// }

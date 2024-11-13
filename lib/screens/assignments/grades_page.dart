// import 'package:flutter/material.dart';

// class GradesPage extends StatelessWidget {
//   static const List<Map<String, dynamic>> grades = [
//     {'assignment': 'Tugas 1', 'score': 85},
//     {'assignment': 'Quiz 1', 'score': 90},
//   ];

//   const GradesPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFFF7D1), // Light background color
//       appBar: AppBar(
//         title: const Text('Hasil Nilai'),
//         backgroundColor: const Color(0xFFFFECC8), // Slightly darker for app bar
//       ),
//       body: ListView.builder(
//         padding: const EdgeInsets.all(20),
//         itemCount: grades.length,
//         itemBuilder: (context, index) {
//           final grade = grades[index];
//           return Card(
//             color: const Color(0xFFFFD09B), // Card background color
//             margin: const EdgeInsets.symmetric(vertical: 8),
//             child: ListTile(
//               title: Text(
//                 grade['assignment'],
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white, // White text for contrast
//                 ),
//               ),
//               subtitle: Text(
//                 'Nilai: ${grade['score']}',
//                 style:
//                     const TextStyle(color: Colors.white), // White subtitle text
//               ),
//               leading: const Icon(Icons.grade, color: Colors.indigo),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

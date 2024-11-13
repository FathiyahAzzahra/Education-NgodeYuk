// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';

// class AssignmentPage extends StatefulWidget {
//   const AssignmentPage({super.key});

//   @override
//   _AssignmentPageState createState() => _AssignmentPageState();
// }

// class _AssignmentPageState extends State<AssignmentPage> {
//   String? filePath;

//   Future<void> pickFile() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//     if (result != null) {
//       setState(() {
//         filePath = result.files.single.path;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Unggah Tugas'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 filePath != null
//                     ? "File: ${filePath!.split('/').last}"
//                     : "Belum ada file dipilih",
//                 style: TextStyle(fontSize: 16, color: Colors.grey[700]),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton.icon(
//                 onPressed: pickFile,
//                 icon: const Icon(Icons.attach_file),
//                 label: const Text('Pilih File'),
//               ),
//               const SizedBox(height: 20),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   // Implementasikan pengunggahan file
//                 },
//                 icon: const Icon(Icons.cloud_upload),
//                 label: const Text('Unggah Tugas'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

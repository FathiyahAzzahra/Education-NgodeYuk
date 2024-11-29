// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';

class AssignmentQuizPage extends StatefulWidget {
  const AssignmentQuizPage({super.key});

  @override
  _AssignmentQuizPageState createState() => _AssignmentQuizPageState();
}

class _AssignmentQuizPageState extends State<AssignmentQuizPage> {
  // ignore: unused_field
  final _paletteColors = <Color>[
    const Color(0xFF2F3032), // Dark Gray
    const Color(0xFF383A56), // Slate Blue
    const Color(0xFFB0A565), // Olive Green
    const Color(0xFFEDE68A), // Light Yellow
  ];

  String? filePath;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Assignment & Quiz'),
          backgroundColor: const Color(0xFFEDE68A),
          bottom: const TabBar(
            labelStyle: TextStyle(
              fontWeight: FontWeight.w900, // Apply bold to selected tab text
              color:
                  Color(0xFF383A56), // Set the color for the selected tab text
              fontSize: 18, // Increase the font size for the selected tab text
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight:
                  FontWeight.w500, // Apply normal weight to unselected tab text
              color: Color(
                  0xFF2F3032), // Set the color for the unselected tab text
              fontSize:
                  16, // Increase the font size for the unselected tab text
            ),
            tabs: [
              Tab(text: 'Assignment'),
              Tab(text: 'Quiz'),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: TabBarView(
          children: [
            // Tab Assignment
            Scaffold(
              backgroundColor: _paletteColors[0],
              appBar: AppBar(
                backgroundColor: _paletteColors[1],
                title: const Text("Welcome Back!",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                actions: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          'assets/foto1.jpg'), // Ganti dengan path gambar profil Anda
                    ),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search bar
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: _paletteColors[1],
                                hintText: 'Search tasks',
                                hintStyle:
                                    const TextStyle(color: Colors.white54),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(Icons.search,
                                    color: Colors.white),
                              ),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: _paletteColors[3],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.filter_list,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // Completed Tasks
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Completed Tasks",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "See all",
                                  style: TextStyle(color: Colors.white54),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 150, // Tinggi widget card
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  _buildTaskCard(
                                    title: "Dasar-Dasar Pemrograman",

                                    color: _paletteColors[2],
                                    // members: [
                                    //   'assets/foto1.jpg',
                                    //   'assets/foto1.jpg'
                                    // ],
                                    completed: true,
                                  ),
                                  const SizedBox(width: 10),
                                  _buildTaskCard(
                                    title: "Pemrograman Web",
                                    color: _paletteColors[1],
                                    // members: ['foto1.jpg', 'assets/foto1.jpg'],
                                    completed: true,
                                  ),
                                  const SizedBox(width: 10),
                                  _buildTaskCard(
                                    title: "Matematika dalam Coding",
                                    color: _paletteColors[2],
                                    // members: [
                                    //   'assets/user1.png',
                                    //   'assets/user5.png'
                                    // ],
                                    completed: true,
                                  ),
                                  const SizedBox(width: 10),
                                  _buildTaskCard(
                                    title: "OOP",
                                    color: _paletteColors[3],
                                    // members: [
                                    //   'assets/user1.png',
                                    //   'assets/user2.png'
                                    // ],
                                    completed:
                                        true, // Misalnya, tugas belum selesai
                                    progress: 100, // Progress 60%
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      // Ongoing Projects
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Ongoing Projects",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "See all",
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                        ],
                      ),

                      _buildProjectCard(
                        destinationScreen: const SubmitScreen(),
                        context: context, // Pass the context here
                        title: "Dasar-Dasar Pemrograman",
                        // color: Colors.blue,
                        dueDate: "20 June",
                      ),

                      _buildProjectCard(
                        destinationScreen: const SubmitScreen(),
                        context: context, // Pass the context here
                        title: "Logika dan Matematika dalam Coding",
                        // color: Colors.blue,
                        dueDate: "20 June",
                      )
                    ],
                  ),
                ),
              ),
            ),

            // Tab Quiz
            QuizListPage(),
          ],
        ),
      ),
    );
  }
}

Widget _buildTaskCard({
  required String title,
  required Color color,
  // required List<String> members,
  required bool completed,
  double progress = 0.0, // Menambahkan progress (opsional)
  Color textColor = Colors.black,
}) {
  return Card(
    color: color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    elevation: 5,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Section
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          // Member Images Section
          // Row(
          //   children: members.map((member) {
          //     return Padding(
          //       padding: const EdgeInsets.only(right: 5),
          //       child: CircleAvatar(
          //         radius: 15,
          //         backgroundImage: AssetImage(member),
          //       ),
          //     );
          //   }).toList(),
          // ),
          const SizedBox(height: 10),
          // Completed Status
          if (completed)
            Text(
              "Completed",
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          if (!completed)
            // Progress Bar Section (visible if not completed)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Progress",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 5),
                LinearProgressIndicator(
                  value:
                      progress / 100, // Using progress value from the argument
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
                const SizedBox(height: 5),
                Text(
                  "${progress.toInt()}% Completed",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
        ],
      ),
    ),
  );
}

Widget _buildProjectCard({
  required BuildContext context, // Add context as a parameter
  required String title,
  required String dueDate,
  String? subtitle, // Adding subtitle parameter
  required Widget destinationScreen, // New parameter for the destination screen
}) {
  return Container(
    width: MediaQuery.of(context).size.width, // Set the width to screen width
    child: GestureDetector(
      onTap: () {
        // Navigate to the destination screen when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationScreen),
        );
      },
      child: Card(
        color: const Color(0xFF383A56), // Use the specified color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              // Subtitle Section (optional)
              if (subtitle != null)
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70, // Lighter color for subtitle
                  ),
                ),
              const SizedBox(height: 10),

              // Due Date Section
              Text(
                'Due on: $dueDate',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white60,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class QuizListPage extends StatefulWidget {
  @override
  _QuizListPageState createState() => _QuizListPageState();
}

class _QuizListPageState extends State<QuizListPage> {
  final Map<String, int> quizScores = {};

  final List<Map<String, Object>> quizzes = [
    {
      'name': 'Dasar Pemrograman',
      'students': '125 Students',
      'icon': 'assets/ddp.jpg',
      'questions': [
        {
          'question': 'apa simbol segi empat pada flowchart?',
          'image': 'assets/ddp1.png',
          'options': ['Input/Output', 'Proses', 'Keputusan', 'Alur program'],
          'answer': 'Input/Output',
          'duration': 10,
        },
        {
          'question': 'Apa hasil dari printf di C?',
          'image': 'assets/ddp2.png',
          'options': ['5', '8', '3', '15'],
          'answer': '8',
          'duration': 10,
        },
        {
          'question': 'Tipe data dasar di C?',
          'image': 'assets/ddp3.png',
          'options': ['String', 'Float', 'Array', 'Object'],
          'answer': 'Float',
          'duration': 10,
        },
      ],
    },
    {
      'name': 'Bahasa Pemrograman',
      'students': '120 Students',
      'icon': 'assets/bp.jpg',
      'questions': [
        {
          'question': 'Apa output kode Python berikut?',
          'image': 'assets/bp1.png',
          'options': ['15', '0', '5', '10'],
          'answer': '15',
          'duration': 15,
        },
        {
          'question': 'Pilih deklarasi array yang benar di Java!',
          'image': 'assets/bp2.png',
          'options': [
            'int[] arr = {1, 2, 3};',
            'int arr[] = [1, 2, 3];',
            'array int[] = {1, 2, 3};',
            'arr[] int = {1, 2, 3};'
          ],
          'answer': 'int[] arr = {1, 2, 3};',
          'duration': 10,
        },
        {
          'question': 'Tipe data untuk angka desimal di C++?',
          'image': 'assets/bp3.png',
          'options': ['Int', 'Char', 'Float', 'Boolean'],
          'answer': 'Float',
          'duration': 10,
        },
      ],
    },
    {
      'name': 'Algoritma',
      'students': '125 Students',
      'icon': 'assets/asd.jpg',
      'questions': [
        {
          'question': 'Algoritma untuk mencari elemen di array terurut?',
          'image': 'assets/asd1.png',
          'options': [
            'Binary Search',
            'Linear Search',
            'Merge Sort',
            'Quick Sort'
          ],
          'answer': 'Binary Search',
          'duration': 10,
        },
        {
          'question': 'Struktur data untuk stack?',
          'image': 'assets/asd2.png',
          'options': ['Linked List', 'Array', 'Tree', 'Graph'],
          'answer': 'Array',
          'duration': 10,
        },
        {
          'question': 'Contoh struktur data pohon?',
          'image': 'assets/asd3.png',
          'options': ['Queue', 'Stack', 'Binary Tree', 'Array'],
          'answer': 'Binary Tree',
          'duration': 10,
        },
      ],
    },
    {
      'name': 'Pemrograman Web',
      'students': '125 Students',
      'icon': 'assets/pw.jpg',
      'questions': [
        {
          'question': 'Fungsi <div> dalam HTML?',
          'image': 'assets/pw1.png',
          'options': [
            'Menyusun paragraf',
            'Mengelompokkan elemen',
            'Membuat hyperlink',
            'Menampilkan gambar'
          ],
          'answer': 'Mengelompokkan elemen',
          'duration': 10,
        },
        {
          'question': 'Tag untuk menyisipkan CSS?',
          'image': 'assets/pw2.png',
          'options': ['<style>', '<link>', '<script>', '<div>'],
          'answer': '<style>',
          'duration': 10,
        },
        {
          'question': 'Tag untuk tabel HTML?',
          'image': 'assets/pw3.png',
          'options': ['<table>', '<tr>', '<td>', 'Semua jawaban benar'],
          'answer': 'Semua jawaban benar',
          'duration': 10,
        },
      ],
    },
    {
      'name': 'Matematika dalam Coding',
      'students': '125 Students',
      'icon': 'assets/lmc.jpg',
      'questions': [
        {
          'question': 'Hasil dari 10 > 5 && 5 != 5?',
          'image': 'assets/lmc1.png',
          'options': ['True', 'False', 'Error', 'Tidak terdefinisi'],
          'answer': 'False',
          'duration': 10,
        },
        {
          'question': 'Pernyataan benar tentang operasi logika?',
          'image': 'assets/lmc2.png',
          'options': [
            'AND hasil True jika kedua False',
            'OR hasil True jika salah satu True',
            'NOT membalikkan hasil AND',
            'XOR membandingkan nilai yang sama'
          ],
          'answer': 'OR hasil True jika salah satu True',
          'duration': 10,
        },
        {
          'question': 'Hasil operasi modulus?',
          'image': 'assets/lmc3.png',
          'options': [
            'Pembagian dua angka',
            'Hasil sisa pembagian',
            'Pembulatan angka',
            'Hasil perkalian'
          ],
          'answer': 'Hasil perkalian',
          'duration': 10,
        },
      ],
    },
    {
      'name': 'OOP',
      'students': '125 Students',
      'icon': 'assets/pbo.jpg',
      'questions': [
        {
          'question': 'Tujuan enkapsulasi?',
          'image': 'assets/pbo1.png',
          'options': [
            'Menyembunyikan data',
            'Mengorganisir kode',
            'Mengimplementasikan pewarisan',
            'Meningkatkan kecepatan'
          ],
          'answer': 'Menyembunyikan data',
          'duration': 10,
        },
        {
          'question': 'Apa itu pewarisan?',
          'image': 'assets/pbo2.png',
          'options': [
            'Mengganti nilai variabel',
            'Mengambil atribut dari kelas lain',
            'Menyembunyikan data',
            'Mengoptimalkan kode'
          ],
          'answer': 'Mengambil atribut dari kelas lain',
          'duration': 10,
        },
        {
          'question': 'Apa itu polimorfisme?',
          'image': 'assets/pbo3.png',
          'options': [
            'Menyembunyikan objek',
            'Menambahkan objek baru',
            'Menyesuaikan metode sesuai objek',
            'Menyalin kode objek'
          ],
          'answer': 'Menyesuaikan metode sesuai objek',
          'duration': 10,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: quizzes.length,
        itemBuilder: (context, index) {
          final quiz = quizzes[index];
          final score = quizScores[quiz['name']] ?? 0;

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizPage(
                    questions: quiz['questions'] as List<Map<String, Object>>,
                    quizName: quiz['name'] as String,
                    onQuizComplete: (int score) {
                      setState(() {
                        quizScores[quiz['name'] as String] = score;
                      });
                    },
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF383A56),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    quiz['icon'] as String,
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported,
                          size: 60, color: Colors.grey);
                    },
                  ),
                  Center(
                    child: Text(
                      quiz['name'] as String,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Score: $score',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(
                            questions:
                                quiz['questions'] as List<Map<String, Object>>,
                            quizName: quiz['name'] as String,
                            onQuizComplete: (int score) {
                              setState(() {
                                quizScores[quiz['name'] as String] = score;
                              });
                            },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFEDE68A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Enroll'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final List<Map<String, Object>> questions;
  final String quizName;
  final Function(int) onQuizComplete;

  const QuizPage({
    super.key,
    required this.questions,
    required this.quizName,
    required this.onQuizComplete,
  });

  @override
  _QuizPageState createState() => _QuizPageState();
}

class SubmitScreen extends StatefulWidget {
  const SubmitScreen({super.key});

  @override
  _SubmitScreenState createState() => _SubmitScreenState();
}

//submit pages
class _SubmitScreenState extends State<SubmitScreen> {
  String? filePath;

  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath =
            result.files.single.path; // update filePath to trigger UI update
      });

      // Show success alert dialog after file is picked
      _showSuccessDialog(context); // Pass context to show the dialog
    }
  }

  // Alert Dialog for file upload success
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('File Submitted'),
          content: Text(
              'You have successfully uploaded the file: ${filePath!.split('/').last}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(),
        body: TabBarView(
          children: [
            // Tab Assignment
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "My work",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Upload your Files",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Here",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => pickFile(context),
                            icon: const Icon(Icons.upload_file),
                            label: const Text("Unggah File"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (filePath != null)
                        Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 8),
                            Text(
                              filePath!.split('/').last,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
            // Tab Quiz
            QuizListPage(),
          ],
        ),
      ),
    );
  }
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  String? _selectedAnswer;
  int _score = 0;
  int _timeRemaining = 10;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timeRemaining = widget.questions[_currentQuestionIndex]['duration'] as int;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _submitAnswer();
      }
    });
  }

  void _submitAnswer() {
    _timer.cancel();

    if (_selectedAnswer == widget.questions[_currentQuestionIndex]['answer']) {
      setState(() {
        _score++;
      });
    }

    if (_currentQuestionIndex < widget.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedAnswer = null;
        startTimer();
      });
    } else {
      widget.onQuizComplete(_score);
      // Navigator.pop(context);
      _showCompletionDialog();
    }
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Quiz Completed'),
        content: const Text('You have completed the quiz!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentQuestionIndex + 1}'),
        backgroundColor: const Color(0xFF5C6BC0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (question['image'] != null)
              Image.asset(
                question['image'] as String,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 20),
            Text(
              'Time Remaining: $_timeRemaining seconds',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              question['question'] as String,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: (question['options'] as List<String>).map((option) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAnswer = option;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _selectedAnswer == option
                            ? const Color(0xFF7CB342)
                            : const Color(0xFF455A64),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // Ensure the container takes full width and height available
                      width: double.infinity,
                      height: double.infinity,
                      child: Center(
                        child: Text(
                          option,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign:
                              TextAlign.center, // Ensures the text is centered
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitAnswer,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5C6BC0),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                _currentQuestionIndex < widget.questions.length - 1
                    ? 'Next Question'
                    : 'Finish Quiz',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

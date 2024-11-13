import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:async';

class AssignmentQuizPage extends StatefulWidget {
  const AssignmentQuizPage({Key? key}) : super(key: key);

  @override
  _AssignmentQuizPageState createState() => _AssignmentQuizPageState();
}

class _AssignmentQuizPageState extends State<AssignmentQuizPage> {
  int _timeRemaining = 30;
  late Timer _timer;
  bool _isQuizSubmitted = false;
  int _score = 0;
  int _currentQuestionIndex = 0;
  String? _selectedOption;
  String? filePath;
  static const List<Map<String, dynamic>> grades = [
    {'assignment': 'Tugas 1', 'score': 85},
    {'assignment': 'Quiz 1', 'score': 90},
  ];
  final List<Map<String, Object>> _questions = [
    {
      'question': 'Apa fungsi utama dari loop dalam pemrograman?',
      'options': [
        'Menampilkan teks',
        'Mengulang perintah',
        'Menghapus data',
        'Menutup program'
      ],
      'answer': 'Mengulang perintah'
    },
    {
      'question':
          'Apa bahasa pemrograman yang paling umum digunakan untuk pengembangan aplikasi Android?',
      'options': ['Python', 'Swift', 'Java', 'Ruby'],
      'answer': 'Java'
    },
    {
      'question': 'HTML adalah singkatan dari...',
      'options': [
        'Hyper Text Markup Language',
        'High Transfer Machine Language',
        'Hyperlink Machine Text',
        'Hyper Text Made Language'
      ],
      'answer': 'Hyper Text Markup Language'
    },
  ];

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _submitQuiz();
      }
    });
  }

  void _submitQuiz() {
    _timer.cancel();
    setState(() {
      _isQuizSubmitted = true;
    });
  }

  void _checkAnswer() {
    if (_selectedOption == _questions[_currentQuestionIndex]['answer']) {
      _score++;
    }
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _selectedOption = null;
      });
    } else {
      _submitQuiz();
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Assignment, Grades & Quiz'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Assignment'),
              Tab(text: 'Grades'),
              Tab(text: 'Quiz'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Assignment Tab
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      filePath != null
                          ? "File: ${filePath!.split('/').last}"
                          : "Belum ada file dipilih",
                      style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: pickFile,
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Pilih File'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implementasikan pengunggahan file
                      },
                      icon: const Icon(Icons.cloud_upload),
                      label: const Text('Unggah Tugas'),
                    ),
                  ],
                ),
              ),
            ),
            // Grades Tab
            ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: grades.length,
              itemBuilder: (context, index) {
                final grade = grades[index];
                return Card(
                  color: const Color(0xFFFFD09B),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(
                      grade['assignment'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      'Nilai: ${grade['score']}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    leading: const Icon(Icons.grade, color: Colors.indigo),
                  ),
                );
              },
            ),
            // Quiz Tab
            Center(
              child: _isQuizSubmitted
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Quiz telah dikumpulkan!',
                          style:
                              TextStyle(fontSize: 18, color: Colors.green[700]),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Skor Anda: $_score dari ${_questions.length}',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Waktu tersisa: $_timeRemaining detik',
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _questions[_currentQuestionIndex]['question']
                                as String,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          ...(_questions[_currentQuestionIndex]['options']
                                  as List<String>)
                              .map((option) {
                            return RadioListTile<String>(
                              title: Text(option),
                              value: option,
                              groupValue: _selectedOption,
                              onChanged: (value) {
                                setState(() {
                                  _selectedOption = value;
                                });
                              },
                            );
                          }).toList(),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed:
                                _selectedOption != null ? _checkAnswer : null,
                            child: const Text('Selanjutnya'),
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

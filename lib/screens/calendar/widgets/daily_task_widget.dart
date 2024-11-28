import 'package:flutter/material.dart';

class DailyTaskWidget extends StatelessWidget {
  final List<String> tasks;
  final Function(String)? onDeleteTask; // Callback untuk menghapus tugas

  // Konstruktor
  DailyTaskWidget({
    required this.tasks,
    this.onDeleteTask, // Opsional: jika null, tombol hapus tidak akan muncul
  });

  @override
  Widget build(BuildContext context) {
    // Menampilkan pesan jika tidak ada tugas
    return tasks.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.task_alt,
                  color: Color(0xFFB0A565), // Warna ikon
                  size: 60,
                ),
                SizedBox(height: 10),
                Text(
                  "No tasks for this day!",
                  style: TextStyle(
                    color: Color(0xFFEDE68A), // Warna teks
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: tasks.length,
            padding: EdgeInsets.symmetric(vertical: 10),
            itemBuilder: (context, index) {
              return Card(
                color: Color(0xFF383A56), // Warna latar belakang kartu
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4, // Efek bayangan kartu
                child: ListTile(
                  key: ValueKey(
                      tasks[index]), // Memastikan key unik untuk setiap item
                  title: Text(
                    tasks[index],
                    style: TextStyle(
                      color: Color(0xFFEDE68A), // Warna teks
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Color(0xFFB0A565), // Warna avatar
                    child: Icon(
                      Icons.check,
                      color: Colors.white, // Warna ikon di dalam avatar
                    ),
                  ),
                  trailing: onDeleteTask != null
                      ? IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Color(0xFFEDE68A), // Warna ikon hapus
                          ),
                          onPressed: () {
                            // Memanggil callback onDeleteTask jika ada
                            onDeleteTask!(tasks[index]);
                          },
                        )
                      : null, // Jika tidak ada onDeleteTask, tidak menampilkan ikon hapus
                ),
              );
            },
          );
  }
}

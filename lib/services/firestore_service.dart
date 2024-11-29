// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chapter_model.dart';
import '../models/course_model.dart';
import '../models/event_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

// Menambahkan referensi koleksi untuk events
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('events');

  // Future<List<Course>> getCoursesPaginated({int limit = 10}) async {
  //   var snapshot = await _db.collection('courses').limit(limit).get();
  //   return snapshot.docs.map((doc) => Course.fromMap(doc.data())).toList();
  // }

  // Menambahkan kursus baru
  Future<void> addCourse(String courseName, String students) async {
    await _db.collection('courses').doc(courseName).set({
      'name': courseName,
      'students': students,
    });
  }

  Future<List<Chapter>> getChapters(String subjectName) async {
    try {
      final snapshot = await _db
          .collection("courses")
          .doc(subjectName)
          .collection("chapters")
          .get();

      return snapshot.docs.map((doc) => Chapter.fromMap(doc.data())).toList();
    } catch (e) {
      print("Error fetching chapters: $e");
      return [];
    }
  }

  // Menambahkan bab ke kursus
  Future<void> addChapter(String courseName, Chapter chapter) async {
    await _db
        .collection('courses')
        .doc(courseName)
        .collection('chapters')
        .doc(chapter.title)
        .set(chapter.toMap());
  }

  // Menambahkan beberapa kursus dan bab secara otomatis
  Future<void> addInitialData() async {
    // Menambahkan kursus
    await addCourse('Java', '150 Students');
    await addCourse('Python', '200 Students');
    await addCourse('C++', '120 Students');
    await addCourse('Dart', '100 Students');

    // Menambahkan bab untuk Java
// Menambahkan bab untuk Java
//     await addChapter(
//         'Java',
//         Chapter(
//           title: 'Pengenalan Java',
//           content:
//               'Deskripsi bab 1: Java adalah bahasa pemrograman yang populer dan digunakan secara luas untuk membangun berbagai jenis aplikasi, termasuk aplikasi desktop, web, dan mobile. '
//               'Bahasa ini dikenal dengan konsepnya yang sederhana dan kuat, serta didukung oleh ekosistem yang besar, termasuk berbagai framework dan pustaka yang mempermudah pengembangan perangkat lunak. '
//               'Pada bab ini, kita akan membahas sejarah singkat Java, tujuan pengembangannya, dan beberapa konsep dasar yang digunakan dalam bahasa ini.',
//           videoUrl: 'https://link_video.com/java/1',
//           views: '125 Views', // Menambahkan views
//           rating: '4.8', // Menambahkan rating
//         ));

//     await addChapter(
//         'Java',
//         Chapter(
//           title: 'Dasar Java',
//           content:
//               'Deskripsi bab 2: Pada bab ini, kita akan mempelajari sintaks dasar Java, termasuk cara mendeklarasikan variabel, menulis fungsi, dan mengelola kontrol alur seperti pengkondisian dan perulangan. '
//               'Java adalah bahasa berorientasi objek, yang berarti bahwa segala sesuatu dianggap sebagai objek. Kita juga akan membahas kelas dan objek, serta cara menggunakan mereka dalam aplikasi Java. '
//               'Di akhir bab ini, Anda akan dapat membuat program Java sederhana dengan mengimplementasikan dasar-dasar yang telah diajarkan.',
//           videoUrl: 'https://link_video.com/java/2',
//           views: '100 Views', // Menambahkan views
//           rating: '4.5', // Menambahkan rating
//         ));

//     await addChapter(
//         'Java',
//         Chapter(
//           title: 'Tipe Data dan Variabel',
//           content:
//               'Deskripsi bab 3: Dalam Java, tipe data adalah cara untuk mendefinisikan jenis data yang akan disimpan dalam variabel. Tipe data dasar seperti int, double, char, dan boolean digunakan untuk mendeklarasikan variabel. '
//               'Pada bab ini, kita akan mempelajari cara mendeklarasikan dan menggunakan berbagai tipe data, serta cara mengubah nilai variabel. '
//               'Selain itu, kita juga akan membahas tentang konversi tipe data dan bagaimana cara bekerja dengan tipe data primitif dan referensi.',
//           videoUrl: 'https://link_video.com/java/3',
//           views: '110 Views', // Menambahkan views
//           rating: '4.7', // Menambahkan rating
//         ));

//     await addChapter(
//         'Java',
//         Chapter(
//           title: 'Kontrol Alur dan Fungsi',
//           content:
//               'Deskripsi bab 4: Java memiliki berbagai cara untuk mengontrol alur program, termasuk perulangan (loop) dan pengkondisian. Pada bab ini, kita akan mempelajari tentang if, else, switch, dan berbagai jenis perulangan seperti for dan while. '
//               'Selain itu, kita juga akan membahas bagaimana cara menulis fungsi dalam Java, yang memungkinkan kita untuk mengorganisir kode dan membuatnya lebih mudah dipahami. '
//               'Bab ini juga akan membahas parameter dan pengembalian nilai dalam fungsi.',
//           videoUrl: 'https://link_video.com/java/4',
//           views: '95 Views', // Menambahkan views
//           rating: '4.6', // Menambahkan rating
//         ));

//     await addChapter(
//         'Java',
//         Chapter(
//           title: 'Array dan Koleksi',
//           content:
//               'Deskripsi bab 5: Array adalah struktur data yang digunakan untuk menyimpan banyak elemen dari tipe data yang sama dalam satu variabel. Pada bab ini, kita akan mempelajari cara mendeklarasikan dan mengelola array di Java. '
//               'Selain itu, kita juga akan mengeksplorasi koleksi lainnya seperti ArrayList dan HashMap, yang memungkinkan kita untuk menyimpan data dalam bentuk yang lebih fleksibel. '
//               'Bab ini akan mengajarkan Anda cara memanipulasi data menggunakan array dan koleksi dengan efisien.',
//           videoUrl: 'https://link_video.com/java/5',
//           views: '120 Views', // Menambahkan views
//           rating: '4.8', // Menambahkan rating
//         ));
//     // Tambahkan hingga Chapter 10 untuk Java //////////////////////////////////////////////////

//     // Menambahkan bab untuk Python
//     await addChapter(
//         'Python',
//         Chapter(
//           title: 'Pengenalan Python',
//           content:
//               'Deskripsi bab 1: Python adalah bahasa pemrograman yang sangat populer, dikenal karena sintaksnya yang sederhana dan mudah dipahami. Bahasa ini sering digunakan untuk pengembangan web, '
//               'analisis data, kecerdasan buatan, dan banyak lagi. Python memungkinkan pengembang untuk fokus pada solusi masalah daripada mengelola rincian teknis lainnya. '
//               'Pada bab ini, kita akan mengeksplorasi dasar-dasar Python, sejarahnya, serta kelebihan dan kekurangannya.',
//           videoUrl: 'https://link_video.com/python/1',
//           views: '200 Views', // Menambahkan views
//           rating: '4.9', // Menambahkan rating
//         ));

//     await addChapter(
//         'Python',
//         Chapter(
//           title: 'Dasar Python',
//           content:
//               'Deskripsi bab 2: Pada bab ini, kita akan membahas konsep-konsep dasar pemrograman di Python, seperti variabel, tipe data, kontrol alur, dan penggunaan fungsi. '
//               'Python mendukung pemrograman berorientasi objek, sehingga kita juga akan memperkenalkan kelas dan objek, serta cara menggunakannya. '
//               'Selain itu, kita akan mempelajari cara bekerja dengan koleksi data seperti list, tuple, set, dan dictionary.',
//           videoUrl: 'https://link_video.com/python/2',
//           views: '180 Views', // Menambahkan views
//           rating: '4.7', // Menambahkan rating
//         ));

//     await addChapter(
//         'Python',
//         Chapter(
//           title: 'Kontrol Alur dan Fungsi',
//           content:
//               'Deskripsi bab 3: Pada bab ini, kita akan mempelajari kontrol alur di Python, termasuk percabangan (if, elif, else) dan perulangan (for, while). '
//               'Selain itu, kita akan membahas bagaimana mendeklarasikan dan menggunakan fungsi untuk memecah program menjadi bagian-bagian yang lebih kecil dan dapat digunakan kembali. '
//               'Fungsi sangat penting dalam pemrograman Python, karena membantu meningkatkan keterbacaan dan pengelolaan kode.',
//           videoUrl: 'https://link_video.com/python/3',
//           views: '170 Views',
//           rating: '4.8',
//         ));

//     await addChapter(
//         'Python',
//         Chapter(
//           title: 'Pemrograman Berorientasi Objek (OOP)',
//           content:
//               'Deskripsi bab 4: Pada bab ini, kita akan mempelajari konsep pemrograman berorientasi objek (OOP) di Python. OOP adalah paradigma pemrograman yang memungkinkan kita untuk membuat objek-objek yang menyimpan data dan fungsi bersama. '
//               'Kita akan belajar tentang kelas, objek, pewarisan, dan polimorfisme. '
//               'Di akhir bab ini, Anda akan dapat memahami bagaimana membuat dan menggunakan kelas untuk membangun aplikasi Python yang lebih terstruktur dan dapat dipelihara.',
//           videoUrl: 'https://link_video.com/python/4',
//           views: '160 Views',
//           rating: '4.8',
//         ));

//     await addChapter(
//         'Python',
//         Chapter(
//           title: 'Modul dan Paket',
//           content:
//               'Deskripsi bab 5: Python memiliki kemampuan untuk mengorganisir kode menjadi modul dan paket yang lebih terstruktur. Pada bab ini, kita akan belajar cara membuat dan menggunakan modul di Python, serta bagaimana mengimpor modul eksternal untuk memperluas fungsionalitas program kita. '
//               'Modul dan paket memungkinkan kita untuk membuat aplikasi Python yang lebih modular dan mudah dipelihara.',
//           videoUrl: 'https://link_video.com/python/5',
//           views: '150 Views',
//           rating: '4.7',
//         ));

// // Menambahkan bab untuk C++ ====================================================================
//     await addChapter(
//         'C++',
//         Chapter(
//           title: 'Pengenalan C++',
//           content:
//               'Deskripsi bab 1: C++ adalah bahasa pemrograman yang dikembangkan oleh Bjarne Stroustrup pada awal 1980-an. Bahasa ini sangat populer dalam pengembangan aplikasi sistem, game, '
//               'dan perangkat lunak lainnya yang memerlukan kontrol tingkat rendah dan efisiensi tinggi. Di bab ini, kita akan membahas konsep dasar C++, seperti sintaks, struktur program, dan alur kontrol. '
//               'Kita juga akan mempelajari perbedaan antara C++ dengan bahasa pemrograman lain seperti C dan Java.',
//           videoUrl: 'https://link_video.com/c++/1',
//           views: '150 Views', // Menambahkan views
//           rating: '4.6', // Menambahkan rating
//         ));

//     await addChapter(
//         'C++',
//         Chapter(
//           title: 'Dasar C++',
//           content:
//               'Deskripsi bab 2: C++ adalah bahasa yang berbasis objek, dan pada bab ini, kita akan membahas dasar-dasar pemrograman berorientasi objek dalam C++. '
//               'Kita akan mempelajari cara mendeklarasikan dan menggunakan class, objek, serta pewarisan dan polimorfisme. Selain itu, kita juga akan membahas pengelolaan memori menggunakan pointer di C++, '
//               'yang menjadi salah satu kekuatan utama bahasa ini.',
//           videoUrl: 'https://link_video.com/c++/2',
//           views: '130 Views', // Menambahkan views
//           rating: '4.5', // Menambahkan rating
//         ));

//     await addChapter(
//         'C++',
//         Chapter(
//           title: 'Pemrograman Berorientasi Objek',
//           content:
//               'Deskripsi bab 3: Pada bab ini, kita akan memperdalam pemrograman berorientasi objek (OOP) di C++. Kita akan belajar tentang enkapsulasi, pewarisan, dan polimorfisme dalam konteks C++. '
//               'Kita juga akan mempelajari tentang konstruktor dan destruktor, serta operator overloading yang memungkinkan kita untuk mendefinisikan perilaku operator untuk kelas-kelas kustom.',
//           videoUrl: 'https://link_video.com/c++/3',
//           views: '120 Views',
//           rating: '4.7',
//         ));

//     await addChapter(
//         'C++',
//         Chapter(
//           title: 'Pengelolaan Memori dengan Pointer',
//           content:
//               'Deskripsi bab 4: C++ memungkinkan pengelolaan memori secara langsung menggunakan pointer, yang memberi kita kontrol lebih besar atas memori aplikasi. '
//               'Pada bab ini, kita akan mempelajari bagaimana mendeklarasikan dan menggunakan pointer, serta memahami konsep penting seperti alokasi dinamis dan deallocasi memori. '
//               'Kita juga akan membahas masalah umum terkait pointer, seperti pointer null dan pointer ganda.',
//           videoUrl: 'https://link_video.com/c++/4',
//           views: '115 Views',
//           rating: '4.6',
//         ));

//     await addChapter(
//         'C++',
//         Chapter(
//           title: 'Fungsi dan Template',
//           content:
//               'Deskripsi bab 5: Fungsi adalah bagian penting dari setiap bahasa pemrograman, dan C++ tidak terkecuali. Pada bab ini, kita akan belajar bagaimana mendeklarasikan dan menggunakan fungsi dalam C++. '
//               'Selain itu, kita akan membahas tentang template di C++, yang memungkinkan kita untuk membuat fungsi dan kelas generik yang dapat bekerja dengan berbagai tipe data.',
//           videoUrl: 'https://link_video.com/c++/5',
//           views: '110 Views',
//           rating: '4.8',
//         ));

// // Menambahkan bab untuk Dart ===============================================
//     await addChapter(
//         'Dart',
//         Chapter(
//           title: 'Pengenalan Dart',
//           content:
//               'Deskripsi bab 1: Dart adalah bahasa pemrograman yang dikembangkan oleh Google untuk membangun aplikasi web, mobile, dan server. Dart dirancang untuk menyederhanakan pengembangan aplikasi, dan sering digunakan bersama framework Flutter. '
//               'Dart dapat digunakan untuk membuat aplikasi lintas platform dengan antarmuka pengguna yang kaya dan performa tinggi. Sebagai bahasa berorientasi objek, Dart memiliki fitur-fitur seperti class, fungsi, dan pustaka standar yang mendukung pengembangan aplikasi yang efisien.',
//           videoUrl: 'https://link_video.com/dart/1',
//           views: '100 Views', // Menambahkan views
//           rating: '4.7', // Menambahkan rating
//         ));

//     await addChapter(
//         'Dart',
//         Chapter(
//           title: 'Dasar Dart',
//           content:
//               'Deskripsi bab 2: Dart memiliki struktur yang mirip dengan bahasa pemrograman lain seperti Java dan C#. Program Dart dimulai dengan fungsi utama, yaitu main(). Fungsi ini merupakan titik awal eksekusi program. '
//               'Dart mendukung tipe data dasar seperti int, double, String, dan bool. Program Dart juga dapat menggunakan kontrol alur seperti perulangan (for, while) dan pengkondisian (if, else).',
//           videoUrl: 'https://link_video.com/dart/2',
//           views: '95 Views', // Menambahkan views
//           rating: '4.4', // Menambahkan rating
//         ));

//     await addChapter(
//         'Dart',
//         Chapter(
//           title: 'Pemrograman Berorientasi Objek di Dart',
//           content:
//               'Deskripsi bab 3: Dart mendukung pemrograman berorientasi objek (OOP) dengan konsep dasar seperti class, objek, pewarisan, dan enkapsulasi. Pada bab ini, kita akan mempelajari cara mendeklarasikan class dan objek, serta cara menggunakan konstruktor, getter, dan setter. '
//               'Kita juga akan membahas konsep pewarisan dan cara menurunkan class serta cara menggunakan metode overriding di Dart.',
//           videoUrl: 'https://link_video.com/dart/3',
//           views: '90 Views',
//           rating: '4.6',
//         ));

//     await addChapter(
//         'Dart',
//         Chapter(
//           title: 'Fungsi dan Closure di Dart',
//           content:
//               'Deskripsi bab 4: Fungsi merupakan bagian penting dalam Dart. Pada bab ini, kita akan mempelajari cara mendeklarasikan dan menggunakan fungsi. Kita juga akan membahas closure, yaitu kemampuan fungsi untuk "mengingat" lingkungan di sekitarnya meskipun sudah dieksekusi di luar lingkungannya.',
//           videoUrl: 'https://link_video.com/dart/4',
//           views: '85 Views',
//           rating: '4.5',
//         ));

//     await addChapter(
//         'Dart',
//         Chapter(
//           title: 'Handling Errors dan Exceptions',
//           content:
//               'Deskripsi bab 5: Pada bab ini, kita akan mempelajari cara menangani kesalahan dan pengecualian dalam program Dart. Dart menyediakan mekanisme try-catch untuk menangkap kesalahan yang terjadi selama eksekusi program, dan kita juga akan mempelajari cara menggunakan finally block untuk mengeksekusi kode setelah menangani pengecualian.',
//           videoUrl: 'https://link_video.com/dart/5',
//           views: '80 Views',
//           rating: '4.7',
//         ));
  }

  // Mendapatkan daftar kursus
  Future<List<Course>> getCourses() async {
    var snapshot = await _db.collection('courses').get();
    return snapshot.docs.map((doc) => Course.fromMap(doc.data())).toList();
  }

  // // Mendapatkan daftar bab untuk kursus
  // Future<List<Chapter>> getChapters(String courseName) async {
  //   var snapshot = await _db
  //       .collection('courses')
  //       .doc(courseName)
  //       .collection('chapters')
  //       .get();
  //   return snapshot.docs.map((doc) => Chapter.fromMap(doc.data())).toList();
  // }

  // CRUD UNTUK EVENTS

  /// Menambahkan event baru ke koleksi Firebase Firestore.
  Future<void> addEvent(String name, DateTime date, String time) async {
    try {
      // Validasi input
      if (name.isEmpty || time.isEmpty) {
        throw Exception("Event name or time cannot be empty.");
      }

      // Tambahkan event dengan ID otomatis
      await eventCollection.add({
        'name': name,
        'date': Timestamp.fromDate(date), // Simpan sebagai timestamp
        'time': time, // Simpan waktu dalam format string
      });
    } catch (e) {
      throw Exception('Failed to add event. Error: $e');
    }
  }

  /// Mengambil semua event dari Firestore dan mengonversinya menjadi Map<DateTime, List<String>>.
  Future<Map<DateTime, List<String>>> getEventsAsMap() async {
    try {
      var snapshot =
          await eventCollection.orderBy('date').orderBy('time').get();

      Map<DateTime, List<String>> eventMap = {};

      for (var doc in snapshot.docs) {
        DateTime? eventDate = (doc['date'] as Timestamp?)?.toDate();
        String? eventName = doc['name'];
        String? eventTime = doc['time'];

        if (eventDate == null || eventName == null || eventTime == null) {
          continue;
        }

        DateTime formattedDate = DateTime(
          eventDate.year,
          eventDate.month,
          eventDate.day,
        );

        if (!eventMap.containsKey(formattedDate)) {
          eventMap[formattedDate] = [];
        }
        eventMap[formattedDate]?.add('$eventName at $eventTime');
      }

      return eventMap;
    } catch (e) {
      throw Exception('Error fetching events: $e');
    }
  }
}

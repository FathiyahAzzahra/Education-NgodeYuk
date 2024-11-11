// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chapter_model.dart';
import '../models/course_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Menambahkan kursus baru
  Future<void> addCourse(String courseName, String students) async {
    await _db.collection('courses').doc(courseName).set({
      'name': courseName,
      'students': students,
    });
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
    await addChapter(
        'Java',
        Chapter(
          title: 'Pengenalan Java',
          content:
              'Deskripsi bab 1: Java adalah bahasa pemrograman yang populer dan digunakan secara luas untuk membangun berbagai jenis aplikasi, termasuk aplikasi desktop, web, dan mobile. '
              'Bahasa ini dikenal dengan konsepnya yang sederhana dan kuat, serta didukung oleh ekosistem yang besar, termasuk berbagai framework dan pustaka yang mempermudah pengembangan perangkat lunak. '
              'Pada bab ini, kita akan membahas sejarah singkat Java, tujuan pengembangannya, dan beberapa konsep dasar yang digunakan dalam bahasa ini.',
          videoUrl: 'https://link_video.com/java/1',
          views: '125 Views', // Menambahkan views
          rating: '4.8', // Menambahkan rating
        ));

    await addChapter(
        'Java',
        Chapter(
          title: 'Dasar Java',
          content:
              'Deskripsi bab 2: Pada bab ini, kita akan mempelajari sintaks dasar Java, termasuk cara mendeklarasikan variabel, menulis fungsi, dan mengelola kontrol alur seperti pengkondisian dan perulangan. '
              'Java adalah bahasa berorientasi objek, yang berarti bahwa segala sesuatu dianggap sebagai objek. Kita juga akan membahas kelas dan objek, serta cara menggunakan mereka dalam aplikasi Java. '
              'Di akhir bab ini, Anda akan dapat membuat program Java sederhana dengan mengimplementasikan dasar-dasar yang telah diajarkan.',
          videoUrl: 'https://link_video.com/java/2',
          views: '100 Views', // Menambahkan views
          rating: '4.5', // Menambahkan rating
        ));

    await addChapter(
        'Java',
        Chapter(
          title: 'Tipe Data dan Variabel',
          content:
              'Deskripsi bab 3: Dalam Java, tipe data adalah cara untuk mendefinisikan jenis data yang akan disimpan dalam variabel. Tipe data dasar seperti int, double, char, dan boolean digunakan untuk mendeklarasikan variabel. '
              'Pada bab ini, kita akan mempelajari cara mendeklarasikan dan menggunakan berbagai tipe data, serta cara mengubah nilai variabel. '
              'Selain itu, kita juga akan membahas tentang konversi tipe data dan bagaimana cara bekerja dengan tipe data primitif dan referensi.',
          videoUrl: 'https://link_video.com/java/3',
          views: '110 Views', // Menambahkan views
          rating: '4.7', // Menambahkan rating
        ));

    await addChapter(
        'Java',
        Chapter(
          title: 'Kontrol Alur dan Fungsi',
          content:
              'Deskripsi bab 4: Java memiliki berbagai cara untuk mengontrol alur program, termasuk perulangan (loop) dan pengkondisian. Pada bab ini, kita akan mempelajari tentang if, else, switch, dan berbagai jenis perulangan seperti for dan while. '
              'Selain itu, kita juga akan membahas bagaimana cara menulis fungsi dalam Java, yang memungkinkan kita untuk mengorganisir kode dan membuatnya lebih mudah dipahami. '
              'Bab ini juga akan membahas parameter dan pengembalian nilai dalam fungsi.',
          videoUrl: 'https://link_video.com/java/4',
          views: '95 Views', // Menambahkan views
          rating: '4.6', // Menambahkan rating
        ));

    await addChapter(
        'Java',
        Chapter(
          title: 'Array dan Koleksi',
          content:
              'Deskripsi bab 5: Array adalah struktur data yang digunakan untuk menyimpan banyak elemen dari tipe data yang sama dalam satu variabel. Pada bab ini, kita akan mempelajari cara mendeklarasikan dan mengelola array di Java. '
              'Selain itu, kita juga akan mengeksplorasi koleksi lainnya seperti ArrayList dan HashMap, yang memungkinkan kita untuk menyimpan data dalam bentuk yang lebih fleksibel. '
              'Bab ini akan mengajarkan Anda cara memanipulasi data menggunakan array dan koleksi dengan efisien.',
          videoUrl: 'https://link_video.com/java/5',
          views: '120 Views', // Menambahkan views
          rating: '4.8', // Menambahkan rating
        ));

    await addChapter(
        'Java',
        Chapter(
          title: 'Pemrograman Berorientasi Objek (OOP)',
          content:
              'Deskripsi bab 6: Pemrograman berorientasi objek adalah paradigma utama dalam Java. Pada bab ini, kita akan mempelajari konsep-konsep seperti kelas, objek, pewarisan, dan enkapsulasi. '
              'Kita akan melihat bagaimana cara mendefinisikan kelas dan objek dalam Java, serta bagaimana cara menghubungkan mereka menggunakan pewarisan dan polimorfisme. '
              'Bab ini juga akan membahas pentingnya pengelolaan akses terhadap data dan metode dengan menggunakan modifier akses seperti public, private, dan protected.',
          videoUrl: 'https://link_video.com/java/6',
          views: '130 Views', // Menambahkan views
          rating: '4.9', // Menambahkan rating
        ));

    await addChapter(
        'Java',
        Chapter(
          title: 'Exception Handling',
          content:
              'Deskripsi bab 7: Exception handling adalah salah satu fitur penting dalam Java yang memungkinkan kita untuk menangani kesalahan dalam program dengan cara yang lebih elegan. '
              'Pada bab ini, kita akan mempelajari cara menggunakan try, catch, dan finally untuk menangani exception yang mungkin terjadi selama eksekusi program. '
              'Selain itu, kita juga akan melihat bagaimana cara membuat exception kustom untuk memenuhi kebutuhan aplikasi kita.',
          videoUrl: 'https://link_video.com/java/7',
          views: '140 Views', // Menambahkan views
          rating: '4.7', // Menambahkan rating
        ));

    await addChapter(
        'Java',
        Chapter(
          title: 'Multithreading',
          content:
              'Deskripsi bab 8: Multithreading memungkinkan program untuk menjalankan beberapa tugas secara bersamaan, meningkatkan efisiensi dan kinerja aplikasi. '
              'Pada bab ini, kita akan mempelajari cara membuat dan mengelola thread dalam Java, serta bagaimana cara berkomunikasi antara thread menggunakan konsep seperti synchronized dan wait-notify. '
              'Bab ini juga akan membahas tantangan dan cara-cara untuk menghindari masalah seperti deadlock.',
          videoUrl: 'https://link_video.com/java/8',
          views: '160 Views', // Menambahkan views
          rating: '4.8', // Menambahkan rating
        ));

    await addChapter(
        'Java',
        Chapter(
          title: 'File IO dan Serialization',
          content:
              'Deskripsi bab 9: Dalam pengembangan aplikasi, kita sering perlu untuk membaca dan menulis data dari atau ke file. Pada bab ini, kita akan membahas cara bekerja dengan file menggunakan kelas-kelas di package java.io. '
              'Kita juga akan membahas tentang serialization, yang memungkinkan kita untuk menyimpan objek dalam bentuk byte stream dan memulihkannya di kemudian hari. '
              'Bab ini akan memberikan pemahaman tentang bagaimana cara mengelola file dan data dalam aplikasi Java.',
          videoUrl: 'https://link_video.com/java/9',
          views: '175 Views', // Menambahkan views
          rating: '4.9', // Menambahkan rating
        ));

    await addChapter(
        'Java',
        Chapter(
          title: 'Database dan JDBC',
          content:
              'Deskripsi bab 10: Java Database Connectivity (JDBC) adalah API yang memungkinkan Java untuk berkomunikasi dengan database. Pada bab ini, kita akan mempelajari cara menghubungkan aplikasi Java dengan database menggunakan JDBC. '
              'Kita akan belajar cara melakukan operasi dasar seperti SELECT, INSERT, UPDATE, dan DELETE di database menggunakan SQL. '
              'Bab ini juga akan membahas tentang pengelolaan koneksi database dan cara menangani transaksi di Java.',
          videoUrl: 'https://link_video.com/java/10',
          views: '200 Views', // Menambahkan views
          rating: '4.9', // Menambahkan rating
        ));

    // Tambahkan hingga Chapter 10 untuk Java

    // Menambahkan bab untuk Python
    await addChapter(
        'Python',
        Chapter(
          title: 'Pengenalan Python',
          content:
              'Deskripsi bab 1: Python adalah bahasa pemrograman yang sangat populer, dikenal karena sintaksnya yang sederhana dan mudah dipahami. Bahasa ini sering digunakan untuk pengembangan web, '
              'analisis data, kecerdasan buatan, dan banyak lagi. Python memungkinkan pengembang untuk fokus pada solusi masalah daripada mengelola rincian teknis lainnya. '
              'Pada bab ini, kita akan mengeksplorasi dasar-dasar Python, sejarahnya, serta kelebihan dan kekurangannya.',
          videoUrl: 'https://link_video.com/python/1',
          views: '200 Views', // Menambahkan views
          rating: '4.9', // Menambahkan rating
        ));

    await addChapter(
        'Python',
        Chapter(
          title: 'Dasar Python',
          content:
              'Deskripsi bab 2: Pada bab ini, kita akan membahas konsep-konsep dasar pemrograman di Python, seperti variabel, tipe data, kontrol alur, dan penggunaan fungsi. '
              'Python mendukung pemrograman berorientasi objek, sehingga kita juga akan memperkenalkan kelas dan objek, serta cara menggunakannya. '
              'Selain itu, kita akan mempelajari cara bekerja dengan koleksi data seperti list, tuple, set, dan dictionary.',
          videoUrl: 'https://link_video.com/python/2',
          views: '180 Views', // Menambahkan views
          rating: '4.7', // Menambahkan rating
        ));

    await addChapter(
        'Python',
        Chapter(
          title: 'Kontrol Alur dan Fungsi',
          content:
              'Deskripsi bab 3: Pada bab ini, kita akan mempelajari kontrol alur di Python, termasuk percabangan (if, elif, else) dan perulangan (for, while). '
              'Selain itu, kita akan membahas bagaimana mendeklarasikan dan menggunakan fungsi untuk memecah program menjadi bagian-bagian yang lebih kecil dan dapat digunakan kembali. '
              'Fungsi sangat penting dalam pemrograman Python, karena membantu meningkatkan keterbacaan dan pengelolaan kode.',
          videoUrl: 'https://link_video.com/python/3',
          views: '170 Views',
          rating: '4.8',
        ));

    await addChapter(
        'Python',
        Chapter(
          title: 'Pemrograman Berorientasi Objek (OOP)',
          content:
              'Deskripsi bab 4: Pada bab ini, kita akan mempelajari konsep pemrograman berorientasi objek (OOP) di Python. OOP adalah paradigma pemrograman yang memungkinkan kita untuk membuat objek-objek yang menyimpan data dan fungsi bersama. '
              'Kita akan belajar tentang kelas, objek, pewarisan, dan polimorfisme. '
              'Di akhir bab ini, Anda akan dapat memahami bagaimana membuat dan menggunakan kelas untuk membangun aplikasi Python yang lebih terstruktur dan dapat dipelihara.',
          videoUrl: 'https://link_video.com/python/4',
          views: '160 Views',
          rating: '4.8',
        ));

    await addChapter(
        'Python',
        Chapter(
          title: 'Modul dan Paket',
          content:
              'Deskripsi bab 5: Python memiliki kemampuan untuk mengorganisir kode menjadi modul dan paket yang lebih terstruktur. Pada bab ini, kita akan belajar cara membuat dan menggunakan modul di Python, serta bagaimana mengimpor modul eksternal untuk memperluas fungsionalitas program kita. '
              'Modul dan paket memungkinkan kita untuk membuat aplikasi Python yang lebih modular dan mudah dipelihara.',
          videoUrl: 'https://link_video.com/python/5',
          views: '150 Views',
          rating: '4.7',
        ));

    await addChapter(
        'Python',
        Chapter(
          title: 'File IO',
          content:
              'Deskripsi bab 6: Bab ini akan membahas tentang cara berinteraksi dengan file menggunakan Python. Kita akan mempelajari bagaimana membuka, membaca, menulis, dan menutup file teks. '
              'Kita juga akan membahas cara menangani file CSV dan JSON, yang sangat berguna dalam pengolahan data. '
              'Bab ini akan memberikan pemahaman tentang bagaimana aplikasi Python dapat bekerja dengan file untuk menyimpan dan memproses data.',
          videoUrl: 'https://link_video.com/python/6',
          views: '140 Views',
          rating: '4.6',
        ));

    await addChapter(
        'Python',
        Chapter(
          title: 'Exception Handling',
          content:
              'Deskripsi bab 7: Pada bab ini, kita akan mempelajari cara menangani kesalahan atau pengecualian dalam Python. '
              'Python menyediakan mekanisme try-except untuk menangkap dan menangani kesalahan yang terjadi selama eksekusi program. '
              'Kita akan belajar bagaimana menangani kesalahan dengan cara yang elegan agar program tetap berjalan meskipun terjadi kesalahan.',
          videoUrl: 'https://link_video.com/python/7',
          views: '130 Views',
          rating: '4.7',
        ));

    await addChapter(
        'Python',
        Chapter(
          title: 'Koneksi Database dengan Python',
          content:
              'Deskripsi bab 8: Pada bab ini, kita akan mempelajari cara menghubungkan aplikasi Python dengan database, baik itu SQLite, MySQL, atau PostgreSQL. '
              'Kita akan belajar cara membuat koneksi, mengeksekusi query SQL, dan menangani hasilnya. '
              'Bab ini penting bagi pengembang yang ingin menyimpan dan mengelola data dalam aplikasi Python.',
          videoUrl: 'https://link_video.com/python/8',
          views: '120 Views',
          rating: '4.6',
        ));

    await addChapter(
        'Python',
        Chapter(
          title: 'Web Scraping dengan Python',
          content:
              'Deskripsi bab 9: Pada bab ini, kita akan mempelajari teknik web scraping menggunakan Python. Web scraping adalah teknik untuk mengambil data dari situs web secara otomatis. '
              'Kita akan menggunakan pustaka Python seperti BeautifulSoup dan Requests untuk mengambil dan mengolah data dari halaman web. '
              'Bab ini sangat berguna bagi mereka yang ingin mengumpulkan data dari situs web untuk analisis lebih lanjut.',
          videoUrl: 'https://link_video.com/python/9',
          views: '110 Views',
          rating: '4.8',
        ));

    await addChapter(
        'Python',
        Chapter(
          title: 'Pengembangan Web dengan Flask',
          content:
              'Deskripsi bab 10: Pada bab ini, kita akan mempelajari dasar-dasar pengembangan aplikasi web menggunakan Flask, salah satu framework Python yang populer. '
              'Kita akan belajar cara membuat aplikasi web sederhana dengan Flask, menangani rute, form, dan koneksi ke database. '
              'Bab ini akan memberi Anda keterampilan dasar untuk mulai mengembangkan aplikasi web dengan Python menggunakan Flask.',
          videoUrl: 'https://link_video.com/python/10',
          views: '100 Views',
          rating: '4.9',
        ));

// Menambahkan bab untuk C++
    await addChapter(
        'C++',
        Chapter(
          title: 'Pengenalan C++',
          content:
              'Deskripsi bab 1: C++ adalah bahasa pemrograman yang dikembangkan oleh Bjarne Stroustrup pada awal 1980-an. Bahasa ini sangat populer dalam pengembangan aplikasi sistem, game, '
              'dan perangkat lunak lainnya yang memerlukan kontrol tingkat rendah dan efisiensi tinggi. Di bab ini, kita akan membahas konsep dasar C++, seperti sintaks, struktur program, dan alur kontrol. '
              'Kita juga akan mempelajari perbedaan antara C++ dengan bahasa pemrograman lain seperti C dan Java.',
          videoUrl: 'https://link_video.com/c++/1',
          views: '150 Views', // Menambahkan views
          rating: '4.6', // Menambahkan rating
        ));

    await addChapter(
        'C++',
        Chapter(
          title: 'Dasar C++',
          content:
              'Deskripsi bab 2: C++ adalah bahasa yang berbasis objek, dan pada bab ini, kita akan membahas dasar-dasar pemrograman berorientasi objek dalam C++. '
              'Kita akan mempelajari cara mendeklarasikan dan menggunakan class, objek, serta pewarisan dan polimorfisme. Selain itu, kita juga akan membahas pengelolaan memori menggunakan pointer di C++, '
              'yang menjadi salah satu kekuatan utama bahasa ini.',
          videoUrl: 'https://link_video.com/c++/2',
          views: '130 Views', // Menambahkan views
          rating: '4.5', // Menambahkan rating
        ));

    await addChapter(
        'C++',
        Chapter(
          title: 'Pemrograman Berorientasi Objek',
          content:
              'Deskripsi bab 3: Pada bab ini, kita akan memperdalam pemrograman berorientasi objek (OOP) di C++. Kita akan belajar tentang enkapsulasi, pewarisan, dan polimorfisme dalam konteks C++. '
              'Kita juga akan mempelajari tentang konstruktor dan destruktor, serta operator overloading yang memungkinkan kita untuk mendefinisikan perilaku operator untuk kelas-kelas kustom.',
          videoUrl: 'https://link_video.com/c++/3',
          views: '120 Views',
          rating: '4.7',
        ));

    await addChapter(
        'C++',
        Chapter(
          title: 'Pengelolaan Memori dengan Pointer',
          content:
              'Deskripsi bab 4: C++ memungkinkan pengelolaan memori secara langsung menggunakan pointer, yang memberi kita kontrol lebih besar atas memori aplikasi. '
              'Pada bab ini, kita akan mempelajari bagaimana mendeklarasikan dan menggunakan pointer, serta memahami konsep penting seperti alokasi dinamis dan deallocasi memori. '
              'Kita juga akan membahas masalah umum terkait pointer, seperti pointer null dan pointer ganda.',
          videoUrl: 'https://link_video.com/c++/4',
          views: '115 Views',
          rating: '4.6',
        ));

    await addChapter(
        'C++',
        Chapter(
          title: 'Fungsi dan Template',
          content:
              'Deskripsi bab 5: Fungsi adalah bagian penting dari setiap bahasa pemrograman, dan C++ tidak terkecuali. Pada bab ini, kita akan belajar bagaimana mendeklarasikan dan menggunakan fungsi dalam C++. '
              'Selain itu, kita akan membahas tentang template di C++, yang memungkinkan kita untuk membuat fungsi dan kelas generik yang dapat bekerja dengan berbagai tipe data.',
          videoUrl: 'https://link_video.com/c++/5',
          views: '110 Views',
          rating: '4.8',
        ));

    await addChapter(
        'C++',
        Chapter(
          title: 'STL (Standard Template Library)',
          content:
              'Deskripsi bab 6: C++ menyediakan pustaka standar yang sangat kuat yang disebut Standard Template Library (STL). Pada bab ini, kita akan mempelajari bagaimana menggunakan struktur data seperti vector, list, set, dan map dari STL. '
              'Kita juga akan membahas algoritma-algoritma penting yang ada di STL untuk melakukan operasi seperti pencarian, pengurutan, dan modifikasi data.',
          videoUrl: 'https://link_video.com/c++/6',
          views: '105 Views',
          rating: '4.7',
        ));

    await addChapter(
        'C++',
        Chapter(
          title: 'File IO di C++',
          content:
              'Deskripsi bab 7: Pada bab ini, kita akan belajar bagaimana membaca dan menulis data ke file di C++. Kita akan membahas penggunaan file teks dan file biner. '
              'Kita juga akan memperkenalkan konsep stream untuk mempermudah proses I/O di C++, serta bagaimana menangani kesalahan yang terjadi saat bekerja dengan file.',
          videoUrl: 'https://link_video.com/c++/7',
          views: '100 Views',
          rating: '4.6',
        ));

    await addChapter(
        'C++',
        Chapter(
          title: 'Multithreading di C++',
          content:
              'Deskripsi bab 8: C++ mendukung pemrograman multithreading yang memungkinkan aplikasi untuk menjalankan beberapa proses secara bersamaan. '
              'Pada bab ini, kita akan mempelajari bagaimana membuat thread di C++, mengelola thread menggunakan mutexes, serta menangani masalah sinkronisasi untuk menghindari kondisi balapan.',
          videoUrl: 'https://link_video.com/c++/8',
          views: '95 Views',
          rating: '4.8',
        ));

    await addChapter(
        'C++',
        Chapter(
          title: 'Koneksi Database dengan C++',
          content:
              'Deskripsi bab 9: Di bab ini, kita akan membahas bagaimana menghubungkan aplikasi C++ ke database, seperti MySQL atau SQLite. '
              'Kita akan mempelajari cara menulis query SQL dalam aplikasi C++, serta bagaimana mengelola data yang diambil dari database. '
              'Koneksi ke database penting untuk aplikasi yang memerlukan penyimpanan dan pengambilan data secara dinamis.',
          videoUrl: 'https://link_video.com/c++/9',
          views: '90 Views',
          rating: '4.7',
        ));

    await addChapter(
        'C++',
        Chapter(
          title: 'Pengembangan Aplikasi GUI dengan C++',
          content:
              'Deskripsi bab 10: Pada bab ini, kita akan mempelajari cara membuat aplikasi GUI (Graphical User Interface) dengan menggunakan framework C++ seperti Qt atau GTK. '
              'Kita akan belajar bagaimana mendesain antarmuka pengguna dengan elemen-elemen seperti tombol, label, dan form input. '
              'Bab ini akan memberi Anda keterampilan untuk membuat aplikasi desktop dengan antarmuka pengguna grafis menggunakan C++.',
          videoUrl: 'https://link_video.com/c++/10',
          views: '85 Views',
          rating: '4.9',
        ));

// Menambahkan bab untuk Dart
    await addChapter(
        'Dart',
        Chapter(
          title: 'Pengenalan Dart',
          content:
              'Deskripsi bab 1: Dart adalah bahasa pemrograman yang dikembangkan oleh Google untuk membangun aplikasi web, mobile, dan server. Dart dirancang untuk menyederhanakan pengembangan aplikasi, dan sering digunakan bersama framework Flutter. '
              'Dart dapat digunakan untuk membuat aplikasi lintas platform dengan antarmuka pengguna yang kaya dan performa tinggi. Sebagai bahasa berorientasi objek, Dart memiliki fitur-fitur seperti class, fungsi, dan pustaka standar yang mendukung pengembangan aplikasi yang efisien.',
          videoUrl: 'https://link_video.com/dart/1',
          views: '100 Views', // Menambahkan views
          rating: '4.7', // Menambahkan rating
        ));

    await addChapter(
        'Dart',
        Chapter(
          title: 'Dasar Dart',
          content:
              'Deskripsi bab 2: Dart memiliki struktur yang mirip dengan bahasa pemrograman lain seperti Java dan C#. Program Dart dimulai dengan fungsi utama, yaitu main(). Fungsi ini merupakan titik awal eksekusi program. '
              'Dart mendukung tipe data dasar seperti int, double, String, dan bool. Program Dart juga dapat menggunakan kontrol alur seperti perulangan (for, while) dan pengkondisian (if, else).',
          videoUrl: 'https://link_video.com/dart/2',
          views: '95 Views', // Menambahkan views
          rating: '4.4', // Menambahkan rating
        ));

    await addChapter(
        'Dart',
        Chapter(
          title: 'Pemrograman Berorientasi Objek di Dart',
          content:
              'Deskripsi bab 3: Dart mendukung pemrograman berorientasi objek (OOP) dengan konsep dasar seperti class, objek, pewarisan, dan enkapsulasi. Pada bab ini, kita akan mempelajari cara mendeklarasikan class dan objek, serta cara menggunakan konstruktor, getter, dan setter. '
              'Kita juga akan membahas konsep pewarisan dan cara menurunkan class serta cara menggunakan metode overriding di Dart.',
          videoUrl: 'https://link_video.com/dart/3',
          views: '90 Views',
          rating: '4.6',
        ));

    await addChapter(
        'Dart',
        Chapter(
          title: 'Fungsi dan Closure di Dart',
          content:
              'Deskripsi bab 4: Fungsi merupakan bagian penting dalam Dart. Pada bab ini, kita akan mempelajari cara mendeklarasikan dan menggunakan fungsi. Kita juga akan membahas closure, yaitu kemampuan fungsi untuk "mengingat" lingkungan di sekitarnya meskipun sudah dieksekusi di luar lingkungannya.',
          videoUrl: 'https://link_video.com/dart/4',
          views: '85 Views',
          rating: '4.5',
        ));

    await addChapter(
        'Dart',
        Chapter(
          title: 'Handling Errors dan Exceptions',
          content:
              'Deskripsi bab 5: Pada bab ini, kita akan mempelajari cara menangani kesalahan dan pengecualian dalam program Dart. Dart menyediakan mekanisme try-catch untuk menangkap kesalahan yang terjadi selama eksekusi program, dan kita juga akan mempelajari cara menggunakan finally block untuk mengeksekusi kode setelah menangani pengecualian.',
          videoUrl: 'https://link_video.com/dart/5',
          views: '80 Views',
          rating: '4.7',
        ));

    await addChapter(
        'Dart',
        Chapter(
          title: 'Asynchronous Programming di Dart',
          content:
              'Deskripsi bab 6: Dart mendukung pemrograman asinkron menggunakan Future dan Stream untuk menangani operasi I/O yang tidak memblokir thread utama. Di bab ini, kita akan mempelajari cara menggunakan async, await, dan Future untuk menangani operasi asinkron seperti pembacaan file atau request jaringan.',
          videoUrl: 'https://link_video.com/dart/6',
          views: '75 Views',
          rating: '4.8',
        ));

    await addChapter(
        'Dart',
        Chapter(
          title: 'Menggunakan Koleksi di Dart',
          content:
              'Deskripsi bab 7: Dart menyediakan koleksi data seperti List, Set, dan Map untuk menyimpan dan memanipulasi data. Pada bab ini, kita akan mempelajari cara menggunakan koleksi untuk menyimpan data dan melakukan operasi seperti penambahan, penghapusan, dan pencarian elemen. Kita juga akan membahas koleksi generik yang memungkinkan kita menggunakan tipe data yang lebih fleksibel.',
          videoUrl: 'https://link_video.com/dart/7',
          views: '70 Views',
          rating: '4.6',
        ));

    await addChapter(
        'Dart',
        Chapter(
          title: 'Menggunakan Library dan Paket di Dart',
          content:
              'Deskripsi bab 8: Dart memiliki pustaka standar yang kaya dan juga mendukung penggunaan paket dari pub.dev. Pada bab ini, kita akan mempelajari cara menggunakan pustaka standar untuk berbagai tugas seperti manipulasi string, tanggal, dan operasi file. Kita juga akan belajar cara mengelola dan menggunakan paket eksternal yang dapat membantu mempercepat pengembangan aplikasi.',
          videoUrl: 'https://link_video.com/dart/8',
          views: '65 Views',
          rating: '4.7',
        ));

    await addChapter(
        'Dart',
        Chapter(
          title: 'Pemrograman Web dengan Dart',
          content:
              'Deskripsi bab 9: Dart juga dapat digunakan untuk membangun aplikasi web. Pada bab ini, kita akan mempelajari cara menggunakan Dart untuk membangun aplikasi web berbasis HTML, CSS, dan JavaScript. Kita akan belajar cara membuat aplikasi single-page dan mengelola interaksi pengguna menggunakan Dart.',
          videoUrl: 'https://link_video.com/dart/9',
          views: '60 Views',
          rating: '4.5',
        ));

    await addChapter(
        'Dart',
        Chapter(
          title: 'Membangun Aplikasi Flutter dengan Dart',
          content:
              'Deskripsi bab 10: Dart digunakan sebagai bahasa utama untuk pengembangan aplikasi Flutter. Pada bab ini, kita akan mempelajari cara membangun aplikasi mobile menggunakan Flutter dan Dart. Kita akan belajar tentang widget, layout, dan manajemen status di Flutter untuk membangun aplikasi lintas platform yang responsif dan menarik.',
          videoUrl: 'https://link_video.com/dart/10',
          views: '55 Views',
          rating: '4.8',
        ));
  }

  // Mendapatkan daftar kursus
  Future<List<Course>> getCourses() async {
    var snapshot = await _db.collection('courses').get();
    return snapshot.docs.map((doc) => Course.fromMap(doc.data())).toList();
  }

  // Mendapatkan daftar bab untuk kursus
  Future<List<Chapter>> getChapters(String courseName) async {
    var snapshot = await _db
        .collection('courses')
        .doc(courseName)
        .collection('chapters')
        .get();
    return snapshot.docs.map((doc) => Chapter.fromMap(doc.data())).toList();
  }
}

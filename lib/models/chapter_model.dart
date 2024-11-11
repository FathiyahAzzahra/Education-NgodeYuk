class Chapter {
  final String title;
  final String content;
  final String videoUrl;
  final String views; // Menambahkan views
  final String rating; // Menambahkan rating

  Chapter({
    required this.title,
    required this.content,
    required this.videoUrl,
    required this.views,
    required this.rating,
  });

  // Factory method untuk membuat objek Chapter dari Map
  factory Chapter.fromMap(Map<String, dynamic> map) {
    return Chapter(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      videoUrl: map['video_url'] ?? '',
      views: map['views'] ?? '0 Views', // Default jika tidak ada
      rating: map['rating'] ?? '0', // Default jika tidak ada
    );
  }

  // Method untuk mengubah objek Chapter menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'video_url': videoUrl,
      'views': views,
      'rating': rating,
    };
  }
}

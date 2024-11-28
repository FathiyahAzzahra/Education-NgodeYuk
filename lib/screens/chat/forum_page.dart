import 'package:flutter/material.dart';

class ForumPage extends StatefulWidget {
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final TextEditingController _postController = TextEditingController();
  List<Map<String, dynamic>> _posts = [];

  void _addPost() {
    String content = _postController.text.trim();
    if (content.isEmpty) return;

    setState(() {
      _posts.add({
        'content': content,
        'likes': 0,
        'comments': [],
      });
    });

    _postController.clear();
  }

  void _addComment(int index, String comment) {
    if (comment.trim().isEmpty) return;

    setState(() {
      _posts[index]['comments'].add(comment);
    });
  }

  void _toggleLike(int index) {
    setState(() {
      _posts[index]['likes'] += 1;
    });
  }

  void _deletePost(int index) {
    setState(() {
      _posts.removeAt(index);
    });
  }

  // Fungsi untuk mengedit post
  void _editPost(int index) {
    // Set kontroler teks dengan konten post yang akan diedit
    _postController.text = _posts[index]['content'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Post'),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _postController,
              decoration: InputDecoration(
                hintText: 'Edit your post...',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines:
                  null, // Agar TextField dapat berkembang sesuai panjang teks
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Menyimpan perubahan yang telah diubah
                setState(() {
                  _posts[index]['content'] = _postController.text.trim();
                });
                Navigator.pop(context); // Tutup dialog
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                // Menutup dialog tanpa menyimpan
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forum'),
        backgroundColor: Color(0xFF383A56),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              controller: _postController,
              decoration: InputDecoration(
                hintText: 'Write a post...',
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              style: TextStyle(color: Colors.black),
              onSubmitted: (value) => _addPost(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['content'],
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.thumb_up,
                                  color: Color(0xFF383A56)),
                              onPressed: () => _toggleLike(index),
                            ),
                            Text('${post['likes']} Likes',
                                style: TextStyle(color: Colors.black)),
                            Spacer(),
                            IconButton(
                              icon:
                                  Icon(Icons.comment, color: Color(0xFF383A56)),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    final commentController =
                                        TextEditingController();
                                    return AlertDialog(
                                      title: Text('Add Comment',
                                          style:
                                              TextStyle(color: Colors.black)),
                                      content: TextField(
                                        controller: commentController,
                                        decoration: InputDecoration(
                                          hintText: 'Write a comment...',
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                        ),
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            _addComment(
                                                index, commentController.text);
                                            Navigator.pop(context);
                                          },
                                          child: Text('Submit',
                                              style: TextStyle(
                                                  color: Color(0xFF383A56))),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.edit, color: Color(0xFF383A56)),
                              onPressed: () => _editPost(index),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deletePost(index),
                            ),
                          ],
                        ),
                        if (post['comments'].isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: post['comments']
                                  .map<Widget>(
                                    (comment) => Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text('- $comment',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Color(0xFF2F3032),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPost,
        backgroundColor: Color(0xFF383A56),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

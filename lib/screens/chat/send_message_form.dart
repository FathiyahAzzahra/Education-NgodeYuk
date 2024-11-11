import 'package:flutter/material.dart';

class SendMessageForm extends StatefulWidget {
  final Function(String) sendMessage;

  SendMessageForm(this.sendMessage);

  @override
  _SendMessageFormState createState() => _SendMessageFormState();
}

class _SendMessageFormState extends State<SendMessageForm> {
  final _controller = TextEditingController();
  var _enteredMessage = '';

  void _submitMessage() {
    if (_enteredMessage.trim().isEmpty) return;
    widget.sendMessage(_enteredMessage);
    _controller.clear();
    setState(() {
      _enteredMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ketik pesan...',
                filled: true,
                fillColor: Color(0xFFEDE68A), // Warna #EDE68A
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;
                });
              },
              onSubmitted: (_) => _submitMessage(),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send,
                color: Color(0xFF383A56)), // Warna ikon #383A56
            onPressed: _enteredMessage.trim().isEmpty ? null : _submitMessage,
          ),
        ],
      ),
    );
  }
}

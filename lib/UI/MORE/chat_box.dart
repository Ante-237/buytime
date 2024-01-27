import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey, // You can set the profile image here
              child: Icon(Icons.person, color: Colors.blue,), // You can use an icon instead
            ),
            SizedBox(width: 10),
            Text('Current Client'),
            Divider(thickness: 10, color: Colors.blue,)// Replace with the user's name
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              child: ListView(
                children: [
                  _buildMessage(true, 'On route'),
                  _buildMessage(false, 'How Many Minutes?'),
                  _buildMessage(true, '5 min max?'),
                  _buildMessage(false, 'All Good'),
                  // Add more messages as needed
                ],
              ),
            ),
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildMessage(bool isMe, String message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          message,
          style: TextStyle(fontSize: 16, color: isMe ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: Icon(Icons.send, color: Colors.white),
                  onPressed: () {
                    // Handle send message action
                  },
                ),
              ),
            ],
            ),
        );
    }
}
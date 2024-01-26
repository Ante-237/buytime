import 'package:flutter/material.dart';


class VerificationStatusPage extends StatefulWidget {
  @override
  _VerificationStatusPageState createState() => _VerificationStatusPageState();
}

class _VerificationStatusPageState extends State<VerificationStatusPage> {
  final TextEditingController _supportMessageController = TextEditingController();
  bool isUserVerified = false; // This should be set based on actual user verification status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Status'),
        backgroundColor: Colors.lightBlue.shade50,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildVerificationStatusSection(),
            SizedBox(height: 30),
            _buildSupportSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildVerificationStatusSection() {
    return Text(
      isUserVerified ? 'Verified' : 'Your verification is in progress and typically takes 24 to 48 hours.',
      style: TextStyle(fontSize: 18, color: Colors.black),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildSupportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Need Support?',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        TextField(
          controller: _supportMessageController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Type your message here',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            // Implement the logic to handle support message submission
          },
          child: Text('Submit'),
          style: ElevatedButton.styleFrom(),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Login / Signup', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            // Add your login and signup fields and buttons here
            // Include a Google Sign-In button
          ],
        ),
      ),
    );
  }
}
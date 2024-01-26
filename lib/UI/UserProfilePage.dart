import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {

  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Replace with actual user data
    String userName = 'John Doe';
    String userState = 'Active';

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.account_circle, size: 100),
            Text('Name: $userName'),
            Text('State: $userState'),
            // Add more profile details here
          ],
        ),
      ),
    );
  }
}
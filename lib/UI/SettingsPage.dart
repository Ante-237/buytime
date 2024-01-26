import 'package:flutter/material.dart';
import 'package:buytime/UI/MORE/verification.dart';

class SettingsPage extends StatelessWidget {

  void openVerificationPage(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  VerificationStatusPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile Settings'),
            onTap: () {
              // Navigate to Profile Settings
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Navigate to About Page
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              // Perform Logout
            },
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Verification'),
            onTap: () {
              // Navigate to Verification Page
              openVerificationPage(context);
            },
          ),
        ],
      ),
    );
  }
}
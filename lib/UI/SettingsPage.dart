import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:buytime/UI/MORE/verification.dart';
import 'package:buytime/UI/MORE/about.dart';

class SettingsPage extends StatefulWidget {

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void openVerificationPage(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  VerificationStatusPage()),
    );
  }

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> getBooleanValue() async {
    try {
      DocumentSnapshot snapshot = await firestore.collection('your_collection').doc('your_document_id').get();
      if (snapshot.exists) {
        return snapshot['booleanFieldName'] ?? false; // Replace 'booleanFieldName' with your field name
      }
      return false; // Default value if document or field does not exist
    } catch (e) {
      print(e);
      return false; // Return default value in case of error
    }
  }

  void openAboutPage(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  AboutPage()),
    );
  }

  // store state of verification
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
              openAboutPage(context);
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
            leading: Icon(Icons.verified_user, color: Colors.blue,),
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
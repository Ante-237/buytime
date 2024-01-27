

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProfilePage extends StatefulWidget {

// update the users name and email with the right info.
  // link settings tap a a panel.
  // link create gigs to creating gigs.
  // link reverse gigs to where reverse gigs happen
  // gig history to empty sheet showing list of past gigs
  // updates amounts made based on fire store values.

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  String? email;
  String? name;
  String? profileImageUrl;




  void GetUserInformation(){
    user = auth.currentUser;
    email = user?.email;
    name = extractNameFromEmail(email!);
    profileImageUrl = user?.photoURL;
  }

  String extractNameFromEmail(String email) {
    return email.split('@')[0].replaceAll('.', ' ');
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUserInformation();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Details Section
          ListTile(
            leading: Icon(Icons.account_circle, color: Colors.blue, size: 60,),
            title: Text("$name"),
            subtitle: Text("$email"),
          ),
          const Divider(),

          // Settings Section
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {
              // Navigate to settings page
              // Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
          Divider(),

          // Gig Actions Section
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Create a Gig'),
            onTap: () {
              // Implement action for creating a gig
            },
          ),
          ListTile(
            leading: Icon(Icons.swap_horiz),
            title: Text('Create Reverse Gigs'),
            onTap: () {
              // Implement action for viewing reverse gigs
            },
          ),
          Divider(),

          // Gig History Section
          ListTile(
            leading: Icon(Icons.history),
            title: Text('Gig History'),
            onTap: () {
              // Implement action for viewing gig history
            },
          ),
          Divider(),

          // Amounts Section
           ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Amount Made from Gigs: \$500'),
          ),
           ListTile(
            leading: Icon(Icons.money_off),
            title: Text('Amount Spent on Gigs: \$100'),
          ),
           ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Amount Made from Reverse Gigs: \$200'),
          ),
         Divider(),

          // Chat Button
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Chat'),
            onTap: () {
              // Implement action for opening chat
            },
          ),
        ],
      ),
    );
  }
}
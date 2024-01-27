import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {


  // update the users name and email with the right info.
  // link settings tap a a panel.
  // link create gigs to creating gigs.
  // link reverse gigs to where reverse gigs happen
  // gig history to empty sheet showing list of past gigs
  // updates amounts made based on fire store values.



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
          const ListTile(
            leading: Icon(Icons.account_circle, color: Colors.blue,),
            title: Text('John Doe'),
            subtitle: Text('john.doe@example.com'),
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
          const ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Amount Made from Gigs: \$500'),
          ),
         const  ListTile(
            leading: Icon(Icons.money_off),
            title: Text('Amount Spent on Gigs: \$100'),
          ),
          const ListTile(
            leading: Icon(Icons.attach_money),
            title: Text('Amount Made from Reverse Gigs: \$200'),
          ),
         const Divider(),

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
import 'package:buytime/UI/UserProfilePage.dart';
import 'package:flutter/material.dart';



class GigHistory extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ActivityListPage(),
    );
  }
}

class ActivityListPage extends StatelessWidget {
  final List<Map<String, dynamic>> activities = [
    {"name": "Transporting Wood", "cost": 50},
    {"name": "Cooking Class", "cost": 30},
    {"name": "Painting Workshop", "cost": 40},
    {"name": "City Tour", "cost": 25},
    // Add more activities here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Gig History'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  UserProfilePage()),
            ); // This line will navigate back to the previous screen
          },
        ),
      ),
      body: ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                activities[index]["name"],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Cost: \$${activities[index]["cost"]}"),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          );
        },
      ),
    );
  }
}

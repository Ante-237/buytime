import 'package:flutter/material.dart';



class CreateGigs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CardViewPage(),
    );
  }
}


class CardViewPage extends StatelessWidget {


  void onCardTap(String cardTitle){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildCard('Create a Direct Gig', Icons.add, () => onCardTap("Direct Gig")),
            SizedBox(height: 50), // Spacing between cards
            buildCard('Create a Reverse Gig', Icons.add, () => onCardTap("Reverse Gig")),
          ],
        ),
      ),
    );
  }

  Widget buildCard(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Container(
          height: 230, // Adjust the height as needed
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, size: 70, color: Colors.blue),
              SizedBox(height: 10), // Spacing between icon and text
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 100),
            Image.asset('assets/app_load.png', width: 200, height: 100,), // Logo
            SizedBox(height: 20),

            SizedBox(height: 10),
            const Text(
              'BuyTime has been at the forefront of innovation, '
                  'providing quality services and products to our customers. '
                  'With a commitment to excellence and a passion for growth, '
                  'we continue to lead the industry with our unique solutions. Employment for all',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            // Add more text or widgets as needed
          ],
        ),
      ),
    );
  }
}

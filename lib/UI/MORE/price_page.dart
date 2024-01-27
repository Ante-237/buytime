import 'package:buytime/UI/MORE/Gig_Description.dart';
import 'package:buytime/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PricePage extends StatelessWidget {
  final TextEditingController priceController = TextEditingController();

  final Uri _url = Uri.parse('https://65b3e6c18e52623b1c0eef44--silver-vacherin-09b5b6.netlify.appThank');

  Future<void> _launchURL() async {
    if (!await canLaunchUrl(_url)) {
      throw 'Could not launch $_url';
    }
    await launchUrl(_url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Price', style: TextStyle(fontSize:  20),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCurvedTextField(),
            SizedBox(height: 20),
            _buildSubmitButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCurvedTextField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextField(
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Price', border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
            // save the content first
          // launch the next application
          _launchURL();
          Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionPage()));
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(16.0),
          primary: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text('Next', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),),
        );
  }
}
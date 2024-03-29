import 'package:flutter/material.dart';
import 'package:buytime/main.dart'; // Replace with the actual next page
import 'package:buytime/UI/MORE/categorySelection_Page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IdentityVerificationPage extends StatefulWidget {
  @override
  _IdentityVerificationPageState createState() => _IdentityVerificationPageState();
}

class _IdentityVerificationPageState extends State<IdentityVerificationPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void storeData(String value1, String value2) async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('Verification_Details');

    // Create a document with an autogenerated ID, or specify your own ID
    DocumentReference docRef = collectionRef.doc();

    try {
      await docRef.set({
        'id_card': value1,
        'mobile_number': value2,
      });
    } catch (e) {
      print("Error storing data: $e");
    }
  }


  void _verifyIdentity() {
    if (_formKey.currentState!.validate()) {
      // Perform verification logic
      storeData(_idController.text, _mobileController.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => GigCategoryPage()), // Navigate to next page on success
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text('Identity Verification'),
       backgroundColor: Colors.white10,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(image: AssetImage("assets/app_load.png"), width: 200, height: 100),
              SizedBox(height: 100,),
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: 'ID Card Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.credit_card),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your ID card number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(
                  labelText: 'Country Code + Mobile Number',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your mobile number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: Text('Verify Identity'),
                onPressed: _verifyIdentity,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

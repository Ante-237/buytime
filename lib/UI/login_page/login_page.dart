import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:buytime/UI/login_page/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:buytime/UI/login_page/identity_verification_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  void _sendNameToFirestore() async {
     String name = _emailController.text;
    if (name.isNotEmpty) {
      await _firestore.collection('names').add({
        'name': "Testing00_ante",
      });
      print('Name added to Firestore');
    }
  }


  void OpenIdentificationPage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IdentityVerificationPage()),
    );
  }


  void _showErrorSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    );
  }

    void _signInWithEmailAndPassword() async {

    try {
      final UserCredential user = await _auth.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text,);
      OpenIdentificationPage();
    } catch (e) {
        _showErrorSnackbar(context, "Login Failed. Try again");
    }
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Image(image: AssetImage("assets/app_load.png"), width: 200, height: 100),
            const SizedBox(height: 100),
            TextFormField(
              controller: _emailController,
              decoration:const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(gapPadding: 10,),

              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Sign In'),
              onPressed: () {
                _sendNameToFirestore();
                _signInWithEmailAndPassword();
              },
            ),
            TextButton(
              child: const Text('Don\'t have an account? Sign up'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
            ),
            TextButton(
              child:const Text('Sign in with Google'),
              onPressed: () {
                // Implement Google Sign-In logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
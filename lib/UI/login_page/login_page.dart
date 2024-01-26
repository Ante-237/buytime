import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:buytime/UI/login_page/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:buytime/UI/login_page/identity_verification_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _sendNameToFirestore() async {
     String name = _emailController.text;
    if (name.isNotEmpty) {
      await _firestore.collection('names').add({
        'name': "Testing00_ante",
      });
      print('Name added to Firestore');
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in process
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken,);
      OpenIdentificationPage();
      // Sign in to Firebase with the Google user credentials
      await _auth.signInWithCredential(credential);

    } catch (e) {
      print(e); // Handle error here
    }
  }


  Future<void> signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      await _auth.signInWithEmailAndPassword(email: email ,password: password);
      OpenIdentificationPage();
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'Invalid email format.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password.';
          break;
        case 'email-already-in-use':
          errorMessage = "The account already exists for that email.";
        case 'weak-password':
          errorMessage = " The password provided is too weak.";
        case 'user-not-found':
          errorMessage = 'User not found.';
          break;
        case 'user-disabled':
          errorMessage = 'User disabled.';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many requests. Try again later.';
          break;
        default:
          errorMessage = 'An unknown error occurred.';
      }
      _showErrorDialog(errorMessage);

    } catch (e) {
      _showErrorDialog("An error occured.");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }




  void OpenIdentificationPage(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => IdentityVerificationPage()),
    );
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
                //_sendNameToFirestore();
                 // _signInWithEmailAndPassword(context);
                signIn();
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
                _signInWithGoogle();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
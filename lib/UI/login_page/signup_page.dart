import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:buytime/UI/login_page/identity_verification_page.dart';
 // Import authentication service

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


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

  // registring an account
  void _registerAccount() async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text,);
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
      _showErrorDialog("An Error Occured");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // This line will navigate back to the previous screen
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image(image: AssetImage("assets/app_load.png"), width: 200, height: 100),
            SizedBox(height: 80),
            SizedBox(height: 8),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 8),
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
              child: const Text('Sign Up'),
              onPressed: () {
                _registerAccount();
              },
            ),
          ],
        ),
      ),
    );
  }
}

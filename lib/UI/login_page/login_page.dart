import 'package:flutter/material.dart';
import 'package:buytime/UI/login_page/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:buytime/UI/login_page/identity_verification_page.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});



  void OpenIdentificationPage(BuildContext context){
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
            Image(image: AssetImage("assets/app_load.png"), width: 200, height: 100),
            SizedBox(height: 100),
            TextFormField(
              decoration:const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(gapPadding: 10,),

              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            TextFormField(
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
                OpenIdentificationPage(context);
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
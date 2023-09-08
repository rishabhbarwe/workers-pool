import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'email_verification_page.dart';
import 'style.dart'; // Import the style.dart file

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Send email verification
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }

      // Navigate to the email verification page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                EmailVerificationPage()), // Navigate to email verification page
      );
    } catch (e) {
      // Handle signup errors here.
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Register/Sign Up',
            style: TextStyle(
              fontSize: 24, // Adjust the font size as needed
              fontWeight: FontWeight.bold, // Use bold font
              color: Colors.deepPurple, // Text color
            ),
            textAlign: TextAlign.center, // Center the text
          ),
          SizedBox(height: 20),
          TextField(
            controller: _emailController,
            decoration: AppStyles.textFieldDecoration.copyWith(
              labelText: 'Email',
            ),
            cursorColor: Colors.deepPurple,
          ),
          TextField(
            controller: _passwordController,
            decoration: AppStyles.textFieldDecoration.copyWith(
              labelText: 'Password',
            ),
            obscureText: true,
            cursorColor: Colors.deepPurple,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _signup,
            style: AppStyles.primaryButtonStyle, // Apply button style
            child: Text('Sign Up'),
          ),
          TextButton(
            onPressed: () {
              // Implement navigation to the login page here.
            },
            child: Text('.'),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'email_verification_page.dart';
import 'style.dart'; // Import the style.dart file

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  // ignore: unused_field
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String? _selectedRole;

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
      // Save user details to Firestore

      await FirebaseFirestore.instance
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({
        'email': _emailController.text,
        'phoneNumber': _phoneNumberController.text,
        'role': _selectedRole,
      });

      // Navigate to the email verification page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => EmailVerificationPage(),
        ),
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
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Register/Sign Up',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  labelText: 'Email',
                ),
                cursorColor: Colors.deepPurple,
              ),
              SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  labelText: 'Password',
                ),
                obscureText: true,
                cursorColor: Colors.deepPurple,
              ),
              SizedBox(height: 8),
              TextField(
                controller: _phoneNumberController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  labelText: 'Phone Number',
                ),
                cursorColor: Colors.deepPurple,
              ),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
                items: [
                  DropdownMenuItem(
                    value: 'worker',
                    child: Text('Worker'),
                  ),
                  DropdownMenuItem(
                    value: 'employer',
                    child: Text('Employer'),
                  ),
                ],
                decoration: AppStyles.textFieldDecoration.copyWith(
                  labelText: 'Role (Worker or Employer)',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signup,
                style: AppStyles.primaryButtonStyle,
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
        ],
      ),
    );
  }
}

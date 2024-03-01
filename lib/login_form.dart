import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mark_5/signup_form.dart';
import 'worker/wk_home_page.dart';
import 'employer/ep_home_page.dart';
import 'style.dart'; // Import the style.dart file

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedRole;

  Future<void> _login() async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Check if login was successful
      if (userCredential.user != null) {
        // Redirect based on the selected role
        if (_selectedRole == 'worker') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => WorkerHomePage()),
          );
        } else if (_selectedRole == 'employer') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => EmployerHomePage()),
          );
        } else {
          // Show a warning if no role is selected
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please select a role.'),
            ),
          );
        }
      } else {
        // Show a warning for invalid email or password
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password.'),
          ),
        );
      }
    } catch (e) {
      // Handle other login errors here
      print(e.toString());
    }
  }

  void _navigateToSignupPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => SignupForm()),
    );
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
            'Log in',
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
          SizedBox(height: 8),
          TextField(
            controller: _passwordController,
            decoration: AppStyles.textFieldDecoration.copyWith(
              labelText: 'Password',
            ),
            cursorColor: Colors.deepPurple,
            obscureText: true,
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
            onPressed: _login,
            style: AppStyles.primaryButtonStyle, // Apply button style
            child: Text('Log in'),
          ),
          TextButton(
            onPressed: _navigateToSignupPage, // Navigate to signup page
            child: Text('.'),
          ),
        ],
      ),
    );
  }
}

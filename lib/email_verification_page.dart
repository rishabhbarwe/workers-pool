import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page.dart';
import 'style.dart'; // Import the style.dart file

class EmailVerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'mark-5',
          style: AppStyles.appBarTitle, // Apply app bar title style
        ),
        backgroundColor: AppStyles.appBarColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'An email has been sent to verify your email address.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Apply specific styles here if needed
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // Check if the user has verified their email
                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null && !user.emailVerified) {
                    // Reload the user to get the latest email verification status
                    await user.reload();
                    user = FirebaseAuth.instance.currentUser;
                  }

                  if (user != null && user.emailVerified) {
                    // Email is verified, navigate to the home page
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  } else {
                    // Email is not verified, show a message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Email not yet verified.'),
                      ),
                    );
                  }
                },
                style: AppStyles.primaryButtonStyle, // Apply button style
                child: Text('Check Verification'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

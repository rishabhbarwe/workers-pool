import 'package:flutter/material.dart';
import 'package:mark_5/style.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppStyles.appBarTitle, // Use the defined style
        ),
        backgroundColor: AppStyles.appBarColor, // Use the defined color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              // Add user profile image here
              radius: 60,
              backgroundImage: AssetImage(
                  'assets/profile_image.png'), // Replace with the actual image path
            ),
            SizedBox(height: 20),
            Text(
              'John Doe', // Replace with user's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'UI/UX Designer', // Replace with user's job title
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            // Add more user information and actions here
          ],
        ),
      ),
    );
  }
}

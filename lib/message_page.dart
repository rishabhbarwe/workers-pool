import 'package:flutter/material.dart';
import 'package:mark_5/style.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: AppStyles.appBarTitle, // Use the defined style
        ),
        backgroundColor: AppStyles.appBarColor, // Use the defined color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Messages',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black, // Add specific styles here if needed
              ),
            ),
            // Add your message content here.
          ],
        ),
      ),
    );
  }
}

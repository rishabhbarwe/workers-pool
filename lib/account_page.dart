import 'package:flutter/material.dart';

import 'style.dart'; // Import your style.dart file
import 'user_details_page.dart'; // Import your UserDetailsPage

class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  String userName = 'John Doe';
  String userEmail = 'johndoe@example.com';
  String userPhotoURL = 'assets/user.png';

  void navigateToUserDetailsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserDetailsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: AppStyles.appBarTitle,
        ),
        backgroundColor: AppStyles.appBarColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Photo and Email Section
            ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(userPhotoURL),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     // Navigate to UserDetailsPage when tapping on the name
                  //     navigateToUserDetailsPage();
                  //   },
                  //   child: Text(
                  //     'Name:',
                  //     style: AppStyles.textFieldLabel,
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to UserDetailsPage when tapping on the email
                      navigateToUserDetailsPage();
                    },
                    child: Text(
                      userName, // Display user's name
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     // Navigate to UserDetailsPage when tapping on the email
                  //     navigateToUserDetailsPage();
                  //   },
                  //   child: Text(
                  //     'Email:',
                  //     style: AppStyles.textFieldLabel,
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to UserDetailsPage when tapping on the email
                      navigateToUserDetailsPage();
                    },
                    child: Text(
                      userEmail,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Options',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () {
                // Handle navigation to the help page
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                // Handle navigation to the about us page
              },
            ),
            ListTile(
              leading: Icon(Icons.question_answer),
              title: Text('FAQs'),
              onTap: () {
                // Handle navigation to the FAQs page
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                // Handle logout here
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Post Job',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: AppStyles.appBarColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) {
          // Handle navigation for the bottom navigation bar items
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AccountPage(),
  ));
}

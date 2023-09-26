import 'package:flutter/material.dart';

import 'style.dart'; // Import the style.dart file

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // Add fields for user detail
  String userName = 'Karan Rai';
  String userEmail = 'karanhyrt244@gmail.com';

  // Create a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Details Section
              ListTile(
                leading: CircleAvatar(
                  // Display the user's profile image here
                  //backgroundImage: AssetImage('assets/profile_image.jpg'),
                  radius: 30,
                ),
                title: Text(
                  userName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(userEmail),
              ),
              SizedBox(height: 20),
              Text(
                ' Options',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // Navigate to the settings page
                },
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () {
                  // Handle logout here
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Help and Support'),
                onTap: () {
                  // Navigate to the help and support page
                },
              ),
            ],
          ),
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
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Post Job',
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
  runApp(MaterialApp(home: AccountPage()));
}

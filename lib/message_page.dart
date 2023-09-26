import 'package:flutter/material.dart';
import 'package:mark_5/postjob_page.dart';
import 'package:mark_5/style.dart';

import 'account_page.dart';
import 'home_page.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  int _selectedIndex = 1; // Set the initial selected index to 1 (Messages)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: AppStyles.appBarTitle, // Use the defined style
        ),
        backgroundColor: AppStyles.appBarColor, // Use the defined color
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            title: Text(
              notification.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(notification.message),
            trailing: Icon(Icons.notifications),
            onTap: () {
              // Handle notification tap
            },
            contentPadding: EdgeInsets.all(16),
            tileColor: Colors.white,
            minVerticalPadding: 0,
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true, // Show labels for selected items
        showUnselectedLabels: true, // Show labels for unselected items
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.work,
              color: _selectedIndex == 0
                  ? AppStyles.appBarColor
                  : Colors.grey, // Change color based on selected index
            ),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.message,
              color: _selectedIndex == 1
                  ? AppStyles.appBarColor
                  : Colors.grey, // Change color based on selected index
            ),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.post_add,
              color: _selectedIndex == 2
                  ? AppStyles.appBarColor
                  : Colors.grey, // Change color based on selected index
            ),
            label: 'Post Job',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _selectedIndex == 3
                  ? AppStyles.appBarColor
                  : Colors.grey, // Change color based on selected index
            ),
            label: 'Profile',
          ),
        ],
        selectedItemColor: AppStyles.appBarColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Update selected index on tap
          });

          // Navigate to the corresponding page
          if (index == 0) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (index == 1) {
            // You are already on the Messages page, so no need to navigate.
          } else if (index == 2) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => PostJobPage()),
            );
          } else if (index == 3) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AccountPage()),
            );
          }
        },
      ),
    );
  }
}

class Notification {
  final String title;
  final String message;

  Notification(this.title, this.message);
}

// Sample notification data, replace with your actual data
final List<Notification> notifications = [
  Notification('New Job Alert', 'A new job opportunity is available.'),
  Notification(
      'Application Update', 'Please update your app to the latest version.'),
  Notification('Welcome', 'Welcome to our app!'),
];

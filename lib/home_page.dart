import 'package:flutter/material.dart';
import 'package:mark_5/profile_page.dart';
import 'message_page.dart';
import 'style.dart'; // Import the style.dart file

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'mark-5',
          style: AppStyles.appBarTitle, // Use the defined style
        ),
        backgroundColor: AppStyles.appBarColor, // Use the defined color
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            margin: EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Jobs',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterTag(tag: 'Home'),
                FilterTag(tag: 'Construction'),
                FilterTag(tag: 'Outdoor'),
                FilterTag(tag: 'Shop'),
                FilterTag(tag: 'Childcare'),
                FilterTag(tag: 'Security'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: jobList.length,
              itemBuilder: (context, index) {
                // Replace jobList with your actual list of job data
                final job = jobList[index];
                return Card(
                  // Wrap the ListTile in a Card widget
                  elevation: 2, // Adjust the elevation as needed
                  margin: EdgeInsets.symmetric(
                      vertical: 8, horizontal: 16), // Margin between each Card
                  shape: RoundedRectangleBorder(
                    // Round the corners of the Card
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      // Add a border around the Card
                      color: Colors.grey, // Customize the border color
                      width: 1, // Customize the border width
                    ),
                  ),
                  child: ListTile(
                    title: Text(job.title),
                    subtitle: Text(job.company),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      // Implement job detail page navigation
                    },
                    contentPadding: EdgeInsets.all(
                        16), // Adjust the ListTile content padding
                    tileColor: Colors.white, // Background color of the ListTile
                    minVerticalPadding: 0, // Remove default vertical padding
                    dense: true, // Reduce the height of the ListTile
                    shape: RoundedRectangleBorder(
                      // Round the corners of the ListTile
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
        ],
        selectedItemColor: AppStyles.appBarColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: (index) {
          if (index == 1) {
            // Navigate to the MessagePage when the message icon is tapped
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => MessagePage()),
            );
          }
          if (index == 2) {
            // Navigate to the ProfilePage when the profile icon is tapped
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
      ),
    );
  }
}

class FilterTag extends StatelessWidget {
  final String tag;

  FilterTag({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(tag),
    );
  }
}

class Job {
  final String title;
  final String company;

  Job(this.title, this.company);
}

// Sample job data, replace with your actual data
final List<Job> jobList = [
  Job('Software Developer', 'ABC Inc.'),
  Job('UI/UX Designer', 'XYZ Corp.'),
  Job('Data Analyst', 'Tech Solutions'),
  Job('Data Analyst', 'Tech Solutions'),
  Job('Data Analyst', 'Tech Solutions'),
  Job('Data Analyst', 'Tech Solutions'),
  Job('Data Analyst', 'Tech Solutions'),
];

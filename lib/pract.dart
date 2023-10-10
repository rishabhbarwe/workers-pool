// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:mark_5/user_details_page.dart';

// import 'style.dart'; // Import the style.dart file

// class AccountPage extends StatefulWidget {
//   @override
//   _AccountPageState createState() => _AccountPageState();
// }

// class _AccountPageState extends State<AccountPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   String userName = ''; // Initialize user details
//   String userEmail = '';
//   String userProfileImageURL =
//       'asset/user.png'; // URL for the user's profile image

//   @override
//   void initState() {
//     super.initState();
//     // Fetch user details when the page loads
//     fetchUserDetails();
//   }

//   Future<void> fetchUserDetails() async {
//     User? user = _auth.currentUser;
//     if (user != null) {
//       // User is signed in, fetch user details from Firestore
//       DocumentSnapshot userDoc =
//           await _firestore.collection('users').doc(user.uid).get();
//       setState(() {
//         userName = userDoc['userName'] ?? ''; // Get userName from Firestore
//         userEmail = user.email ?? ''; // Get userEmail from Firebase Auth
//         userProfileImageURL =
//             userDoc['profileImageURL'] ?? ''; // Get profile image URL
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'My Account',
//           style: AppStyles.appBarTitle,
//         ),
//         backgroundColor: AppStyles.appBarColor,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // User Details Section
//             ListTile(
//               leading: CircleAvatar(
//                 backgroundImage:
//                     NetworkImage(userProfileImageURL), // Load image from URL
//                 radius: 30,
//               ),
//               title: Text(
//                 userName,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle: Text(userEmail),
//               onTap: () {
//                 // Navigate to UserDetailsPage when tapped
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => UserDetailsPage()),
//                 );
//               },
//             ),
//             SizedBox(height: 20),
//             Text(
//               ' Options',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.settings),
//               title: Text('Settings'),
//               onTap: () {
//                 // Navigate to the settings page
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.logout),
//               title: Text('Logout'),
//               onTap: () {
//                 // Handle logout here
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.help),
//               title: Text('Help and Support'),
//               onTap: () {
//                 // Navigate to the help and support page
//               },
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.work),
//             label: 'Jobs',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             label: 'Messages',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.post_add),
//             label: 'Post Job',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//         selectedItemColor: AppStyles.appBarColor,
//         unselectedItemColor: Colors.grey,
//         backgroundColor: Colors.white,
//         onTap: (index) {
//           // Handle navigation for the bottom navigation bar items
//         },
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(home: AccountPage()));
// }

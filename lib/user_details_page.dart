import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'style.dart'; // Import your style.dart file

class UserDetailsPage extends StatefulWidget {
  UserDetailsPage({Key? key}) : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String? selectedGender;
  TextEditingController ageController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch the user's details from Firestore when the page loads
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      // Get the current user's ID from FirebaseAuth
      final User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Fetch user details from Firestore
        DocumentSnapshot userDoc =
            await _firestore.collection('users').doc(currentUser.uid).get();

        // Populate the text fields with the retrieved data
        setState(() {
          nameController.text = userDoc['name'] ?? '';
          emailController.text = userDoc['email'] ?? '';
          phoneNumberController.text = userDoc['phoneNumber'] ?? '';
          selectedGender = userDoc['gender'];
          ageController.text = userDoc['age'] ?? '';
          educationController.text = userDoc['education'] ?? '';
          bioController.text = userDoc['bio'] ?? '';
        });
      }
    } catch (e) {
      // Handle errors and show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch user details: $e')),
      );
    }
  }

  void saveChanges() async {
    try {
      // Get the current user's ID from FirebaseAuth
      final User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        // Update the user's details in Firestore
        await _firestore.collection('users').doc(currentUser.uid).set({
          'name': nameController.text,
          'email': emailController.text,
          'phoneNumber': phoneNumberController.text,
          'gender': selectedGender ?? '',
          'age': ageController.text,
          'education': educationController.text,
          'bio': bioController.text,
        });
        Navigator.pop(context,
            {'name': nameController.text, 'email': emailController.text});
        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Changes saved successfully')),
        );
      }
    } catch (e) {
      // Handle errors and show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save changes: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit User Details',
          style: AppStyles.appBarTitle,
        ),
        backgroundColor: AppStyles.appBarColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Name',
                style: AppStyles.textFieldLabel,
              ),
              TextFormField(
                controller: nameController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  hintText: 'Enter your name',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Email',
                style: AppStyles.textFieldLabel,
              ),
              TextFormField(
                controller: emailController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Phone Number',
                style: AppStyles.textFieldLabel,
              ),
              TextFormField(
                controller: phoneNumberController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  hintText: 'Enter your phone number',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Gender',
                style: AppStyles.textFieldLabel,
              ),
              DropdownButtonFormField<String>(
                value: selectedGender,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  hintText: 'Select gender',
                ),
                items: ['Male', 'Female']
                    .map((gender) => DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGender = value;
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Age',
                style: AppStyles.textFieldLabel,
              ),
              TextFormField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  hintText: 'Enter your age',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Education',
                style: AppStyles.textFieldLabel,
              ),
              TextFormField(
                controller: educationController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  hintText: 'Enter your education',
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Bio',
                style: AppStyles.textFieldLabel,
              ),
              TextFormField(
                controller: bioController,
                maxLines: 4,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  hintText: 'Enter your bio',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Call the function to save changes when the button is pressed
                  saveChanges();
                },
                style: AppStyles.primaryButtonStyle,
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
      // ... Rest of your UserDetailsPage code ...
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserDetailsPage(),
  ));
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'style.dart'; // Import the style.dart file

class PostJobPage extends StatelessWidget {
  final TextEditingController jobTitleController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController jobDescriptionController =
      TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController qualificationController = TextEditingController();
  final TextEditingController languageController = TextEditingController();
  final TextEditingController jobTimingController = TextEditingController();
  final TextEditingController jobAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post a Job',
          style: AppStyles.appBarTitle,
        ),
        backgroundColor: AppStyles.appBarColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: jobTitleController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  labelText: 'Job Title',
                ),
                cursorColor: Colors.deepPurple,
              ),
              TextField(
                controller: companyNameController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  labelText: 'Company Name',
                ),
                cursorColor: Colors.deepPurple,
              ),
              TextField(
                controller: locationController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  labelText: 'Location',
                ),
                cursorColor: Colors.deepPurple,
              ),
              TextField(
                controller: jobDescriptionController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  labelText: 'Job Description',
                ),
                cursorColor: Colors.deepPurple,
                maxLines: 3,
              ),
              TextField(
                controller: experienceController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  labelText: 'Experience',
                ),
                cursorColor: Colors.deepPurple,
              ),
              TextField(
                controller: qualificationController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  labelText: 'Qualification',
                ),
                cursorColor: Colors.deepPurple,
              ),
              TextField(
                controller: languageController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  labelText: 'Language',
                ),
                cursorColor: Colors.deepPurple,
              ),
              TextField(
                controller: jobTimingController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  labelText: 'Job Timing',
                ),
                cursorColor: Colors.deepPurple,
              ),
              TextField(
                controller: jobAddressController,
                decoration: AppStyles.textFieldDecoration.copyWith(
                  labelText: 'Job Address',
                ),
                cursorColor: Colors.deepPurple,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final jobPosting = JobPosting(
                      jobTitle: jobTitleController.text,
                      companyName: companyNameController.text,
                      location: locationController.text,
                      jobDescription: jobDescriptionController.text,
                      experience: experienceController.text,
                      qualification: qualificationController.text,
                      language: languageController.text,
                      jobTiming: jobTimingController.text,
                      jobAddress: jobAddressController.text,
                    );

                    await FirebaseFirestore.instance
                        .collection('jobPostings')
                        .add(jobPosting.toJson());

                    // Clear all text controllers after posting the job
                    jobTitleController.clear();
                    companyNameController.clear();
                    locationController.clear();
                    jobDescriptionController.clear();
                    experienceController.clear();
                    qualificationController.clear();
                    languageController.clear();
                    jobTimingController.clear();
                    jobAddressController.clear();
                  } catch (error) {
                    print('Error posting job: $error');
                  }
                },
                style: AppStyles.primaryButtonStyle,
                child: Text('Post Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobPosting {
  final String jobTitle;
  final String companyName;
  final String location;
  final String jobDescription;
  final String experience;
  final String qualification;
  final String language;
  final String jobTiming;
  final String jobAddress;

  JobPosting({
    required this.jobTitle,
    required this.companyName,
    required this.location,
    required this.jobDescription,
    required this.experience,
    required this.qualification,
    required this.language,
    required this.jobTiming,
    required this.jobAddress,
  });

  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'companyName': companyName,
      'location': location,
      'jobDescription': jobDescription,
      'experience': experience,
      'qualification': qualification,
      'language': language,
      'jobTiming': jobTiming,
      'jobAddress': jobAddress,
    };
  }
}


// start below 


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'style.dart'; // Import the style.dart file

// class PostJobPage extends StatelessWidget {
//   final TextEditingController jobTitleController = TextEditingController();
//   final TextEditingController companyNameController = TextEditingController();
//   final TextEditingController locationController = TextEditingController();
//   final TextEditingController jobDescriptionController =
//       TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Post a Job',
//           style: AppStyles.appBarTitle,
//         ),
//         backgroundColor: AppStyles.appBarColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: jobTitleController,
//               decoration: AppStyles.textFieldDecoration.copyWith(
//                 labelText: 'Job Title',
//               ),
//               cursorColor: Colors.deepPurple,
//             ),
//             TextField(
//               controller: companyNameController,
//               decoration: AppStyles.textFieldDecoration.copyWith(
//                 labelText: 'Company Name',
//               ),
//               cursorColor: Colors.deepPurple,
//             ),
//             TextField(
//               controller: locationController,
//               decoration: AppStyles.textFieldDecoration.copyWith(
//                 labelText: 'Location',
//               ),
//               cursorColor: Colors.deepPurple,
//             ),
//             TextField(
//               controller: jobDescriptionController,
//               decoration: AppStyles.textFieldDecoration.copyWith(
//                 labelText: 'Job Description',
//               ),
//               cursorColor: Colors.deepPurple,
//               maxLines: 3,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   final jobPosting = JobPosting(
//                     jobTitle: jobTitleController.text,
//                     companyName: companyNameController.text,
//                     location: locationController.text,
//                     jobDescription: jobDescriptionController.text,
//                   );

//                   await FirebaseFirestore.instance
//                       .collection('jobPostings')
//                       .add(jobPosting.toJson());

//                   jobTitleController.clear();
//                   companyNameController.clear();
//                   locationController.clear();
//                   jobDescriptionController.clear();
//                 } catch (error) {
//                   print('Error posting job: $error');
//                 }
//               },
//               style: AppStyles.primaryButtonStyle,
//               child: Text('Post Job'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class JobPosting {
//   final String jobTitle;
//   final String companyName;
//   final String location;
//   final String jobDescription;

//   JobPosting({
//     required this.jobTitle,
//     required this.companyName,
//     required this.location,
//     required this.jobDescription,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'jobTitle': jobTitle,
//       'companyName': companyName,
//       'location': location,
//       'jobDescription': jobDescription,
//     };
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:mark_5/style.dart';

// class JobDetailsPage extends StatelessWidget {
//   final String jobTitle;
//   final String companyName;
//   final String location;
//   final String jobDescription;
//   final String experience;
//   final String qualification;
//   final String language;
//   final String jobTiming;
//   final String jobAddress;

//   JobDetailsPage({
//     required this.jobTitle,
//     required this.companyName,
//     required this.location,
//     required this.jobDescription,
//     required this.experience,
//     required this.qualification,
//     required this.language,
//     required this.jobTiming,
//     required this.jobAddress,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Job Details',
//           style: AppStyles.appBarTitle, // Use the defined style
//         ),
//         backgroundColor: AppStyles.appBarColor, // Use the defined color
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               jobTitle,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 8),
//             Text(
//               'Company: $companyName',
//               style: AppStyles.textFieldLabel, // Use the defined label style
//             ),
//             Text(
//               'Location: $location',
//               style: AppStyles.textFieldLabel, // Use the defined label style
//             ),
//             Text(
//               'Experience: $experience',
//               style: AppStyles.textFieldLabel, // Use the defined label style
//             ),
//             Text(
//               'Qualification: $qualification',
//               style: AppStyles.textFieldLabel, // Use the defined label style
//             ),
//             Text(
//               'Language: $language',
//               style: AppStyles.textFieldLabel, // Use the defined label style
//             ),
//             Text(
//               'Job Timing: $jobTiming',
//               style: AppStyles.textFieldLabel, // Use the defined label style
//             ),
//             Text(
//               'Job Address: $jobAddress',
//               style: AppStyles.textFieldLabel, // Use the defined label style
//             ),
//             SizedBox(height: 16),
//             Text(
//               'Job Description',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               jobDescription,
//               style: AppStyles.textFieldLabel, // Use the defined label style
//             ),
//           ],
//         ),
//       ),
//       // Add "Apply" and "Contact" buttons at the bottom
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.all(16),
//         child: Row(
//           children: [
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Handle "Apply" button action
//                 },
//                 child: Text('Apply'),
//               ),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Handle "Contact" button action
//                 },
//                 child: Text('Contact'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

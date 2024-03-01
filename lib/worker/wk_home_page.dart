import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../style.dart';
import 'wk_account_page.dart';
import 'wk_job_details_page.dart';
import 'wk_job_history.dart';
import 'wk_message_page.dart';

class WorkerHomePage extends StatefulWidget {
  @override
  _WorkerHomePageState createState() => _WorkerHomePageState();
}

class _WorkerHomePageState extends State<WorkerHomePage> {
  int _selectedIndex = 0; // Initially selected index is 0 (WJobs)

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });
      switch (_selectedIndex) {
        case 0:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => WorkerHomePage()),
          );
          break;
        case 1:
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => WorkerMessagePage()),
          );
          break;
        case 2:
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => WorkerJobHistoryPage()),
          );
          break;
        case 3:
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => WorkerAccountPage()),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Work1 Daily',
          style: AppStyles.appBarTitle,
        ),
        backgroundColor: AppStyles.appBarColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
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
                      hintText:
                          'Search Jobs', // Add the search icon (\u{1F50D})
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Add horizontal scroll
            child: Padding(
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
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('jobPostings')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Display a loading indicator while fetching data
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Text(
                      'No job postings available.'); // Display a message if no data is available
                }
                // Display job postings using a ListView.builder or any other widget
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final jobData = snapshot.data!.docs[index].data()
                        as Map<String, dynamic>;
                    final job = JobPosting.fromJson(jobData);

                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        title: Text(job.jobTitle),
                        subtitle: Text(job.companyName),
                        trailing: Icon(Icons.arrow_forward),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => WorkerJobDetailsPage(
                                createrId: job.createrId,
                                jobId: job.jobId, // Pass jobId here
                                jobTitle: job.jobTitle,
                                companyName: job.companyName,
                                jobType: job.jobType,
                                location: job.location,
                                jobDescription: job.jobDescription,
                                experience: job.experience,
                                qualification: job.qualification,
                                language: job.language,
                                jobTiming: job.jobTiming,
                                jobAddress: job.jobAddress,
                              ),
                            ),
                          );
                        },
                        contentPadding: EdgeInsets.all(16),
                        tileColor: Colors.white,
                        minVerticalPadding: 0,
                        dense: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'WJobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'WMessages',
            //  backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'WJob History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'WProfile',
          ),
        ],
        selectedItemColor: _getSelectedColor(_selectedIndex),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }

  Color _getSelectedColor(int index) {
    if (index == 0) {
      return Colors.deepPurple; // Color for WJobs
    } else if (index == 1) {
      return Colors.deepPurple; // Color for WMessages
    } else if (index == 2) {
      return Colors.deepPurple; // Color for WJob History
    } else if (index == 3) {
      return Colors.deepPurple; // Color for WProfile
    }
    return AppStyles.appBarColor; // Default color for WJobs
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

class JobPosting {
  final String createrId;
  final String jobId; // Add jobId field
  final String jobTitle;
  final String companyName;
  final String jobType;
  final String location; // Add location field
  final String jobDescription;
  final String experience; // Add experience field
  final String qualification; // Add qualification field
  final String language; // Add language field
  final String jobTiming; // Add jobTiming field
  final String jobAddress; // Add jobAddress field

  JobPosting({
    required this.createrId,
    required this.jobId, // Include jobId in the constructor
    required this.jobTitle,
    required this.companyName,
    required this.jobType,
    required this.location,
    required this.jobDescription,
    required this.experience,
    required this.qualification,
    required this.language,
    required this.jobTiming,
    required this.jobAddress,
  });

  factory JobPosting.fromJson(Map<String, dynamic> json) {
    final jobId = json['jobId'];
// Retrieve jobId from JSON
    final createrId = json['createrId'];
    final jobTitle = json['jobTitle'];
    final companyName = json['companyName'];
    final jobDescription = json['jobDescription'];

    if (createrId == null ||
        jobId == null ||
        jobTitle == null ||
        companyName == null ||
        jobDescription == null) {
      throw ArgumentError("Required fields missing in JSON data");
    }

    return JobPosting(
      createrId: createrId,
      jobId: jobId,
      jobTitle: jobTitle,
      companyName: companyName,
      jobType: json['jobType'] ?? '',
      location: json['location'] ?? '',
      jobDescription: jobDescription,
      experience: json['experience'] ?? '',
      qualification: json['qualification'] ?? '',
      language: json['language'] ?? '',
      jobTiming: json['jobTiming'] ?? '',
      jobAddress: json['jobAddress'] ?? '',
    );
  }
}

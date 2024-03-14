import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../style.dart';
import 'wk_account_page.dart';
import 'wk_home_page.dart';
import 'wk_job_history.dart';

class WorkerMessagePage extends StatefulWidget {
  @override
  _WorkerMessagePageState createState() => _WorkerMessagePageState();
}

class _WorkerMessagePageState extends State<WorkerMessagePage> {
  late List<DocumentSnapshot> requests = [];

  @override
  void initState() {
    super.initState();
    // Fetch requests sent to the current user
    fetchRequests();
  }

  Future<void> fetchRequests() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('requests')
            .where('senderId', isEqualTo: currentUser.uid)
            .get();
        setState(() {
          requests = snapshot.docs;
        });
      }
    } catch (e) {
      print('Error fetching requests: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Worker Messages',
          style: AppStyles.appBarTitle,
        ),
        backgroundColor: AppStyles.appBarColor,
      ),
      // ignore: unnecessary_null_comparison
      body: requests == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : requests.isEmpty
              ? Center(
                  child: Text('No requests found'),
                )
              : ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot request = requests[index];
                    String status = request['status'] ?? 'PENDING';
                    return Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: ListTile(
                          title: status == 'PENDING'
                              ? Text(
                                  'The other user has not responded to this request.',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    color: Colors.grey,
                                  ),
                                )
                              : Text(
                                  'Request status: $status',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: status == 'ACCEPTED'
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                          tileColor:
                              status == 'PENDING' ? Colors.yellow[100] : null,
                          contentPadding: EdgeInsets.all(12),
                        ),
                      ),
                    );
                  },
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
        selectedItemColor: AppStyles.appBarColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            // Navigate to the WorkerHomePage when the job icon is tapped
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => WorkerHomePage()),
            );
          }
          if (index == 2) {
            // Navigate to the WorkerJobHistoryPage when the job history icon is tapped
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WorkerJobHistoryPage()),
            );
          }
          if (index == 3) {
            // Navigate to the WorkerAccountPage when the profile icon is tapped
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WorkerAccountPage()),
            );
          }
        },
      ),
    );
  }
}

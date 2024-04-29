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

  void deleteRequest(String requestId) async {
    try {
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(requestId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Request deleted')),
      );
      // Fetch updated requests
      fetchRequests();
    } catch (e) {
      print('Error deleting request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete request')),
      );
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
                    String companyName =
                        request['companyName'] ?? 'Company Name';
                    String jobTitle = request['jobTitle'] ?? 'Job Title';

                    return Dismissible(
                      key: Key(request.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        deleteRequest(request.id);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                          child: ListTile(
                            title: status == 'PENDING'
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        'Company Name: $companyName',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Job Title: $jobTitle',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Request status: $status',
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 8),
                                      Text(
                                        'Company Name: $companyName',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Job Title: $jobTitle',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Request status: $status',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: status == 'ACCEPTED'
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                            tileColor:
                                status == 'PENDING' ? Colors.yellow[100] : null,
                            contentPadding: EdgeInsets.all(12),
                          ),
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
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Requests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Job History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
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

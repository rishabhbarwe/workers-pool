import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../style.dart';

class EmployerMessagePage extends StatefulWidget {
  @override
  _EmployerMessagePageState createState() => _EmployerMessagePageState();
}

class _EmployerMessagePageState extends State<EmployerMessagePage> {
  late List<DocumentSnapshot> requests;

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
            .where('receiverId', isEqualTo: currentUser.uid)
            .get();
        setState(() {
          requests = snapshot.docs;
        });
      }
    } catch (e) {
      print('Error fetching requests: $e');
    }
  }

  void acceptRequest(String requestId) async {
    try {
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(requestId)
          .update({'status': 'ACCEPTED'}); // Update the request status
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request accepted')),
      );
      // Fetch updated requests
      fetchRequests();
    } catch (e) {
      print('Error accepting request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to accept request')),
      );
    }
  }

  void rejectRequest(String requestId) async {
    try {
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(requestId)
          .update({'status': 'REJECTED'}); // Update the request status
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Request rejected')),
      );
      // Fetch updated requests
      fetchRequests();
    } catch (e) {
      print('Error rejecting request: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to reject request')),
      );
    }
  }

  Future<String> fetchSenderName(String senderId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(senderId)
          .get();
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      String senderName = userData[
          'name']; // Assuming 'name' is the field storing the sender's name
      return senderName;
    } catch (e) {
      print('Error fetching sender name: $e');
      return 'Unknown Sender';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Message Page',
          style: AppStyles.appBarTitle,
        ),
        backgroundColor: AppStyles.appBarColor,
      ),
      // ignore: unnecessary_null_comparison
      body: requests != null
          ? ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                DocumentSnapshot request = requests[index];
                String requestId = request.id;
                return FutureBuilder(
                  future: fetchSenderName(requests[index]['senderId']),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      String senderName = snapshot.data.toString();
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                        child: ListTile(
                          title: Text(
                            'Request from: $senderName',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                onPressed: () => acceptRequest(requestId),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                ),
                                child: Text(
                                  'Accept',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () => rejectRequest(requestId),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  padding: EdgeInsets.symmetric(horizontal: 16),
                                ),
                                child: Text(
                                  'Reject',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vitap_leaveapp/firebaseServices/auth.dart';
import 'package:vitap_leaveapp/firebaseServices/database.dart';

class AdminHome extends StatefulWidget {
  // const AdminHome({super.key});


  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  final AuthService _auth = AuthService();

final CollectionReference _leaveRequests =
  FirebaseFirestore.instance.collection('allRequests');

  final CollectionReference _myRequests =
  FirebaseFirestore.instance.collection('requests');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text('Approve Requests'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.brown[900],
            ),
            icon: const Icon(Icons.person),
            label: const Text('logout')),
        ],
      ),
      body: StreamBuilder(
        stream: _leaveRequests.snapshots(),
        builder: ((context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot = 
                streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ListTile(
                    title: Text('Approval Status : ${documentSnapshot["approvalStatus"]}'),
                    subtitle: Text('reason : ${documentSnapshot["reason"].toString()}'),
                  ),
                  Text('duration : ${"${documentSnapshot["duration"]} ${documentSnapshot["duration"] == 1 ? 'day' : 'days'}"}'),
                  Align(
                  alignment: Alignment.bottomRight,
                    
                    child: FloatingActionButton.small(
                      onPressed: () async {
                        final user = await FirebaseAuth.instance.currentUser;
                        var doc_id = streamSnapshot.data!.docs[index].id;
                        print(doc_id);
                        await DatabaseService(uid: user!.uid)
                        .approveAllRequest(doc_id);
                        await DatabaseService(uid: user.uid)
                        .approveRequest(documentSnapshot['docId'], doc_id);
                      },
                      backgroundColor: Colors.green[300],
                      child: const Icon(Icons.check),
                      ),
                    ),
                    ],
                  )
                  
                );
              }
              );
          }
          else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        } ),
      ),
    );
  }
}
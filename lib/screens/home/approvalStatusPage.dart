import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vitap_leaveapp/firebaseServices/auth.dart';
import 'package:vitap_leaveapp/firebaseServices/database.dart';


class ApprovalPage extends StatefulWidget {
  // const ApprovalPage({super.key});

    final Function? toggleView;
  ApprovalPage({this.toggleView});


  @override
  State<ApprovalPage> createState() => _ApprovalPageState();
}

class _ApprovalPageState extends State<ApprovalPage> {

  // final user = FirebaseAuth.instance.currentUser;
  // if (user != null) {
    
  // }
  final CollectionReference _leaveRequests =
  FirebaseFirestore.instance.collection('requests')
  .doc(FirebaseAuth.instance.currentUser!.uid).collection('my requests');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text('Leave Request'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              widget.toggleView!();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.brown[900],
            ),
            icon: const Icon(Icons.arrow_back),
            label: const Text('back')),
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
                    title: Text('Approval Status : ${documentSnapshot["approvalStatus"].toString()}'),
                    subtitle: Text('Duration : ${documentSnapshot["duration"].toString()} days'),
                  ),
                  Align(
                  alignment: Alignment.bottomRight,
                    
                    child: FloatingActionButton.small(
                      onPressed: () async {
                        DatabaseService().deleteUserRequests(documentSnapshot.id);
                      },
                      child: const Icon(Icons.delete),
                      backgroundColor: Colors.brown[300],
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
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
                  Column(
                    children: [
                      Text('Start Date: ${(documentSnapshot["startDate"] as Timestamp).toDate().toString().substring(0, (documentSnapshot["startDate"] as Timestamp).toDate().toString().indexOf(' '))}'),
                      Text('End Date: ${(documentSnapshot["endDate"] as Timestamp).toDate().toString().substring(0, (documentSnapshot["endDate"] as Timestamp).toDate().toString().indexOf(' '))}'),

                    ],
                  ),
                  Align(
                  alignment: Alignment.bottomRight,
                    
                    child: FloatingActionButton.small(
                      onPressed: () async {
                        await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                          await myTransaction.delete(streamSnapshot.data!.docs[index].reference);
                          });
                      },
                      backgroundColor: Colors.brown[300],
                      child: const Icon(Icons.delete),
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
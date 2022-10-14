import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vitap_leaveapp/firebaseServices/auth.dart';
import 'package:vitap_leaveapp/firebaseServices/database.dart';
import 'package:vitap_leaveapp/models/user.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
//  Home({super.key});

final Function? toggleView;
  Home({this.toggleView});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  final reasonController = TextEditingController();

  DateTime dateToday = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day) ;
  DateTime startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+1);


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
            onPressed: () async {
              await _auth.signOut();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.brown[900],
            ),
            icon: const Icon(Icons.person),
            label: const Text('Logout')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
           TextField(
            controller: reasonController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              // hintText: 'Reason',
              labelText: 'Reason*',
              
              ),
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 7,
          ),

              const SizedBox(height: 10.0),
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 119, 87, 207),
              elevation: 0.0,
            ),
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: dateToday,
                firstDate: dateToday,
                lastDate: DateTime(DateTime.now().year+4),
                );
              if (newDate == null) {
                setState(() {
                startDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
              });
              }
              else {
                setState(() {
                startDate = newDate;
              });
              }
                            
            }, child: Text('Start Date : ${startDate.day}/${startDate.month}/${startDate.year}',
            style: const TextStyle(
              color: Colors.white70,
            ),)),
            const SizedBox(height: 10.0),
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 119, 87, 207),
              elevation: 0.0,
            ),
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: endDate,
                firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+1),
                lastDate: DateTime(DateTime.now().year+4),
                );
              if (newDate == null) {
                setState(() {
                endDate = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+1);
              });
              }
              else {
                setState(() {
                endDate = newDate;
              });
              }
                            
            }, child: Text('end Date : ${endDate.day}/${endDate.month}/${endDate.year}',
            style: const TextStyle(
              color: Colors.white70,
            ),)),
            const SizedBox(height: 10.0),

            Text.rich(
            TextSpan(
              style: const TextStyle(color: Colors.brown, fontFamily: 'Montserrat'), //apply style to all
              children: [
              const TextSpan(text: 'Number of leave days: ', style: TextStyle(fontSize: 14)),
              TextSpan(text: '${endDate.difference(startDate).inDays}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ]
              )
            ),

            const SizedBox(height: 60.0),

             TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 119, 87, 207),
              ),
              onPressed: () async {
                final user = await FirebaseAuth.instance.currentUser;
                if (user != null) {
                  await DatabaseService(uid: user.uid)
                  .sendRequest(user.uid, startDate, endDate, endDate.difference(startDate).inDays, reasonController.text.trim(), DateTime.now());
                }
              },
              child: const Text('Submit Request',
              style: TextStyle(
                color: Colors.white70,
              ),)),

              TextButton(
              style: TextButton.styleFrom(
                
              ),
              onPressed: () => widget.toggleView!(),
              child: const Text('Approval Status', style: 
              TextStyle(
                color: Color.fromARGB(255, 119, 87, 207),
                decoration: TextDecoration.underline,
                
              ),)),

          
        ],
      ),
      ),
    );
  }
}
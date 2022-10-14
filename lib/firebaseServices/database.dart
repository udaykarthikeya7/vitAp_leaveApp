import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({ this.uid });
  
  final CollectionReference myRequests = FirebaseFirestore.instance.collection('requests');

  Future updateUserData(String email)
  async {
    return await myRequests.doc(uid).set({
      'email': email,
      'uid': uid,
    });
  }

  Future sendRequest(String uid, DateTime start, DateTime end, int duration, String reason, DateTime reqTime)
  async {
    return await myRequests.doc(uid).collection('my requests').doc().set(
      {
        'startDate': start,
        'endDate': end,
        'reason': reason,
        'duration': duration,
        'requestedTime': reqTime,
        'approvalStatus': 'pending',
      }
    );
  }

  Future<void> deleteUserRequests(String id) async {
  return await myRequests
    .doc(uid)
    .collection('my requests')
    .doc(id)
    .delete()
    .then((value) => print("Request Deleted"))
    .catchError((error) => print("Failed to delete request: $error"));
}

Future<void> approveRequest(String id) {
  return myRequests
    .doc(uid)
    .collection('my requests')
    .doc(id)
    .update({'approvalStatus':'approved'})
    .then((value) => print("Request Approved"))
    .catchError((error) => print("Failed to approve request: $error"));
}

}
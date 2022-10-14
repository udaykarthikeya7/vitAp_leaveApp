import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String? uid;
  DatabaseService({ this.uid });

  String docRefId = 'somevalue';
  
  final CollectionReference myRequests = FirebaseFirestore.instance.collection('requests');
  final CollectionReference AllRequests = FirebaseFirestore.instance.collection('allRequests');

  Future updateUserData(String email)
  async {
    return await myRequests.doc(uid).set({
      'email': email,
      'uid': uid,
    });
  }

  Future sendRequest(String? email, String uid, DateTime start, DateTime end, int duration, String reason, DateTime reqTime)
  async {
    final docRef = await myRequests.doc(uid).collection('my requests').doc();
    docRefId = docRef.id;

    return await myRequests.doc(uid).collection('my requests').doc(docRef.id).set(
      {
        'startDate': start,
        'endDate': end,
        'reason': reason,
        'duration': duration,
        'requestedTime': reqTime,
        'approvalStatus': 'pending',
        'userID': uid,
        'docId': docRef.id,
        'email': email,
      }
    );
    
  }

  Future sendAllRequest(String? email, String uid, DateTime start, DateTime end, int duration, String reason, DateTime reqTime)
  async {

    return await AllRequests.doc(uid).set(
      {
        'startDate': start,
        'endDate': end,
        'reason': reason,
        'duration': duration,
        'requestedTime': reqTime,
        'approvalStatus': 'pending',
        'docId': docRefId,
        'email': email,
      }
    );
    
  }


Future<void> approveRequest(String id, String userId) async {
  print(userId);
  print(id);
  return await myRequests
    .doc(userId)
    .collection('my requests')
    .doc(id)
    .update({'approvalStatus':'approved'})
    .then((value) => print("Request Approved"))
    .catchError((error) => print("Failed to approve request: $error"));
}

Future<void> approveAllRequest(String id) async {
  return await AllRequests
    .doc(id)
    .update({'approvalStatus':'approved'})
    .then((value) => print("Request Approved"))
    .catchError((error) => print("Failed to approve request: $error"));
}

}
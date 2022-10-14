import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vitap_leaveapp/firebaseServices/database.dart';
import 'package:vitap_leaveapp/models/user.dart';


class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change obj based on FirebaseUser

  FBUser? _userFromFirebaseUser(User? user) {
    return user != null ? FBUser(uid: user.uid) : null;
  }

  // auth change user stream

  Stream<FBUser?> get user  {
    return _auth.userChanges()
    .map(_userFromFirebaseUser);
  }


  // Future signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     User? user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // sign in using email and password
  Future signInUseEmail(
    String email,
    String password,
  ) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
        );
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateUserData(email);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password (by admin only)


  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}

// FirebaseUser has been changed to User

// AuthResult has been changed to UserCredential

// GoogleAuthProvider.getCredential() has been changed to GoogleAuthProvider.credential()

// onAuthStateChanged which notifies about changes to the user's sign-in state was replaced with authStateChanges()

// currentUser() which is a method to retrieve the currently logged in user, was replaced with the property currentUser and it no longer returns a Future<FirebaseUser>
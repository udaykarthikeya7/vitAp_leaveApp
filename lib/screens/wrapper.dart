import 'package:flutter/material.dart';
import 'package:vitap_leaveapp/firebaseServices/auth.dart';
import 'package:vitap_leaveapp/models/user.dart';
import 'package:vitap_leaveapp/screens/authenticate/authenticate.dart';
// import 'package:vitap_leaveapp/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:vitap_leaveapp/screens/home/adminHome.dart';
import 'package:vitap_leaveapp/screens/home/home.dart';
import 'package:vitap_leaveapp/screens/home/mainWrapper.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FBUser?>(context);
    if (user != null) {
      print(user.uid);
    }

    // return either the home or auth widget
    if (user == null) {
      return Authenticate();
    } else if (user != null && user.uid != 'LZYp0KaZ28ge7YGkgAOiFHec4GM2') {
      return MainWrapper();
    }
    else {
      return AdminHome();
    }
    // return StreamBuilder<FBUser?>(
    //   stream: AuthService().user,
    //   builder: (context, AsyncSnapshot<FBUser?> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.active) {
    //       final FBUser? user = snapshot.data;
    //       return user == null ? const Authenticate() : const Home(); 
    //     }
    //     else {
    //       return const Scaffold(
    //         body: Center(child: CircularProgressIndicator(),),
    //       );
    //     }
    //   });
  }
}
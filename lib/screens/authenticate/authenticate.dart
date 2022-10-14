import 'package:flutter/material.dart';
import 'package:vitap_leaveapp/screens/authenticate/admin_sign_in.dart';
import 'package:vitap_leaveapp/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool adminLogin = false;

  void toggleView() {
    setState(() {
      adminLogin = !adminLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (adminLogin) {
      return SignIn(toggleView: toggleView);
    }
    else {
      return AdminSignIn(toggleView: toggleView);
    }
  }
}
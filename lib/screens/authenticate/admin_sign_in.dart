import 'package:flutter/material.dart';
import 'package:vitap_leaveapp/firebaseServices/auth.dart';
import 'package:vitap_leaveapp/screens/home/adminHome.dart';

class AdminSignIn extends StatefulWidget {
//  const AdminSignIn({super.key});

  final Function? toggleView;
  AdminSignIn({this.toggleView});

  @override
  State<AdminSignIn> createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {

  String errorState = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Admin Sign in'),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              widget.toggleView!();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.brown[900],
            ),
            icon: const Icon(Icons.person),
            label: const Text('student Login')),
        ],
      ),
      body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         const SizedBox(height: 30.0),
         Text(errorState, style: const TextStyle(
          color: Colors.red,
         ),),
         const SizedBox(height: 2.0,),
          TextField(
            controller: emailController,
            cursorColor: const Color.fromARGB(255, 120, 102, 252),
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 4.0),
          TextField(
            controller: passwordController,
            cursorColor: const Color.fromARGB(255, 120, 102, 252),
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: () async {
            dynamic result = await _auth.signInUseEmail(
              emailController.text.trim(),
              passwordController.text.trim()
              );
            if (result == null) {
              print('error signing in');
              setState(() {
                errorState = 'invalid username or password';
              });
            } else {
              print('signed in');
              print(result.uid);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 120, 102, 252),
          ),
          child: const Text('Sign In using email and Password.'),
          ),
          const SizedBox(height: 2.0,),
          const Text('psst. your Admin login credentials are :'),
          const SizedBox(height: 2.0,),
          const Text('Email : admin@vitap.ac.in'),
          const SizedBox(height: 2.0,),
          const Text('Password : adminpassword'),
        ],
      ),
    ),
    );
  }
}
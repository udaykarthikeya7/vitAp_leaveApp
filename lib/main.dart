import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vitap_leaveapp/firebaseServices/auth.dart';
import 'package:vitap_leaveapp/models/user.dart';
// import 'package:vitap_leaveapp/screens/authenticate/authenticate.dart';
import 'package:vitap_leaveapp/screens/wrapper.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FBUser?>.value(
        value: AuthService().user,
        initialData: null,
        child: MaterialApp(
        home: const Wrapper(),
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        ),
        );
        

  }
}

// import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:vitap_leaveapp/screens/home/approvalStatusPage.dart';
import 'package:vitap_leaveapp/screens/home/home.dart';
// import 'package:vitap_leaveapp/screens/home/home.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {

  bool approvalPageState = false;

  void toggleView() {
    setState(() {
      approvalPageState = !approvalPageState;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!approvalPageState) {
      return Home(toggleView: toggleView);

    }
    else {
      return ApprovalPage(toggleView: toggleView);
    }
  }
}
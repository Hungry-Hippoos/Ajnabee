import 'package:memechat/helper/authenticate.dart';
import 'package:memechat/helper/helperfunctions.dart';
import 'package:memechat/views/chatrooms.dart';
import 'package:flutter/material.dart';
import 'screens/quizwelcome.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Discuss!',
      debugShowCheckedModeBanner: false,
      home: Container(
        child: Center(
          child: Authenticate(),
        ),
      ),
    );
  }
}

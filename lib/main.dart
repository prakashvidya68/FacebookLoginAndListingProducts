import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:typemyletter/Screens/welcome_screen.dart';

import './Screens/profile_edit_screen.dart';
import './Widgets/facebook_auth.dart';

void main() {
  runApp(Assignment());
}

class Assignment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TML',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        accentColor: Colors.black,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
    // When navigating to the "/" route, build the FirstScreen widget.
    // When navigating to the "/second" route, build the SecondScreen widget.
    WelcomeScreen.routeName: (context) => WelcomeScreen(),
  },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<FirebaseUser> _listner;

  FirebaseUser _currentUser;

  @override
  void initState() {
    checkCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    _listner.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _currentUser == null
        ? SignIn()
        : ProfileEditScreen(user: _currentUser);
  }

  void checkCurrentUser() async {
    _currentUser = await _auth.currentUser();
    _currentUser?.getIdToken(refresh: true);
    _listner = _auth.onAuthStateChanged.listen((FirebaseUser user) {
      setState(() {
        _currentUser = user;
      });
    });
  }
}
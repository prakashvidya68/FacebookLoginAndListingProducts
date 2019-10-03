import 'package:flutter/material.dart';

import 'package:firebase_ui/flutter_firebase_ui.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SignInScreen(
        title: "PhotoFlip",
        header: Column(children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Text(
            "Stack UP",
            style: TextStyle(
              color: Colors.white,
              fontSize: 75 ,
              fontFamily: 'DancingScript',
              fontWeight: FontWeight.w500,
              ),
              
          ),
          SizedBox(height: 10,),
          Text(
            "Stacking is fun...",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 18 ,
              fontFamily: 'DancingScript',
              fontWeight: FontWeight.w500,),
          ),
          SizedBox(
            height: 350,
          )
        ]),
        showBar: true,
        bottomPadding: 5,
        avoidBottomInset: true,
        color: Colors.black,
        providers: [
          ProvidersTypes.facebook,
        ],
        // twitterConsumerKey: "",
        // twitterConsumerSecret: "",
        horizontalPadding: 12,
      );
  }
}
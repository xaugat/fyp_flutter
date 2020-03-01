
import 'package:alumniapp/loginpage.dart';
import 'package:alumniapp/notificationPage.dart';
import 'package:alumniapp/userprofile.dart';
import 'package:alumniapp/welcomepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


void main() {
  runApp(Main());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue[900], // navigation bar color
    statusBarColor: Colors.blue[900], // status bar color
  ));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alumni App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:alumniapp/main.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState(){
    super.initState();
    setupNotification();
  }

  void setupNotification() async{
    _firebaseMessaging.getToken().then((token){
      print(token);

    });
    _firebaseMessaging.configure(
      onMessage: (Map<String,dynamic>message) async{
        print("Message: $message");
      },
      onResume: (Map<String,dynamic>message) async{
        print("Message: $message");
      },
      onLaunch: (Map<String,dynamic>message) async{
        print("Message: $message");
      },
    );

  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
         child: RaisedButton(onPressed: (){}, child: Text('ok'),), 
        ),
      ),
      
    );
  }
}
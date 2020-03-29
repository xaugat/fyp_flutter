import 'package:alumniapp/message.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:alumniapp/main.dart';



class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  final TextEditingController titleController = TextEditingController(text:'Title');
  final TextEditingController bodyController = TextEditingController(text:'Body123');
  @override
  void initState(){
    super.initState();

    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.configure(
      onMessage: (Map < String, dynamic>message) async{
        print("onMessage: $message");

        final notification = message['notification'];
        setState(() {
          messages.add(Message(title: notification['title'],body: notification['body']));
        });
      },
      onLaunch: (Map<String,dynamic>message)async{
        print("onLaunch: $message");

        setState(() {
          messages.add(Message(title: '$message',body: 'OnLaunch:',));
        });

        final notification = message['data'];
        setState(() {
          messages.add(Message(
            title: 'onLaunch: ${notification['title']}',
            body: 'onLaunch: ${notification['body']}'));
        });
      },
       onResume: (Map<String,dynamic>message)async{
        print("onResume: $message");
      }
    );

    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound:true, badge:true,alert:true)
    );
  }


  // void initState(){
  //   super.initState();
  //   setupNotification();
  // }

  // void setupNotification() async{
  //   _firebaseMessaging.getToken().then((token){
  //     print(token);

  //   });
  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String,dynamic>message) async{
  //       print("Message: $message");
  //     },
  //     onResume: (Map<String,dynamic>message) async{
  //       print("Message: $message");
  //     },
  //     onLaunch: (Map<String,dynamic>message) async{
  //       print("Message: $message");
  //     },
  //   );

  // }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue[900],
      title:Text('Event Notifications'),
    ),
      body: ListView(
        children: [
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(labelText:'Title'),
          ),
          TextFormField(
            controller: bodyController,
            decoration: InputDecoration(labelText:'Body'),
          ),
          RaisedButton(onPressed: sendNotification,
                    child:Text("Send Event notification to all")
                    ),
          
          
                  ]..addAll( messages.map(buildMessage).toList(),)
                )
              
            );
           
            
            Widget buildMessage(Message message) => ListTile(
             title: Text(message.title),
             subtitle: Text(message.body), 
            );
          
            void sendNotification() {
  }
}
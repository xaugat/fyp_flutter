import 'package:alumniapp/createEvent.dart';
import 'package:alumniapp/eventdetail.dart';
import 'package:alumniapp/message.dart';
import 'package:alumniapp/messaging.dart';
import 'package:flutter/material.dart';




class NotificationPage extends StatefulWidget {
  

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  _NotificationPageState();

  var eventCreate = EventCreatesState();
  
  
 
  
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue[900],
      title:Text('Event Notifications'),
    ),
      body: ListView(
        children: <Widget>[
          Card(
          child: ListTile(
            title: Text(''),
            subtitle: Text(''),
          ),
          )
        ],

      )
              
            );

                  
           
}
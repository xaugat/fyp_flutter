import 'dart:convert';
import 'dart:io';
import 'package:alumniapp/homepage.dart';
import 'package:alumniapp/message.dart';
import 'package:alumniapp/messaging.dart';
import 'package:alumniapp/notificationPage.dart';
import 'package:alumniapp/notificationPage.dart';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'api.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class EventCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EventCreates();
  }
}

class EventCreates extends StatefulWidget {

  
  
  @override
  EventCreatesState createState() => EventCreatesState();
}

class EventCreatesState extends State<EventCreates> {

  
  bool _isLoading = false;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController eventVenueController = TextEditingController();
  TextEditingController eventTimeController = TextEditingController();

  final form_key = GlobalKey<FormState>();
  final format = DateFormat("yyyy-MM-dd");
  final formats = DateFormat("HH:mm");

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print("onMessage: $message");

      final notification = message['notification'];
      setState(() {
        messages.add(
            Message(title: notification['title'], body: notification['body']));
      });
    }, onLaunch: (Map<String, dynamic> message) async {
      print("onLaunch: $message");

      setState(() {
        messages.add(Message(
          title: '$message',
          body: 'OnLaunch:',
        ));
      });

      final notification = message['data'];
      setState(() {
        messages.add(Message(
            title: 'onLaunch: ${notification['title']}',
            body: 'onLaunch: ${notification['body']}'));
      });
    }, onResume: (Map<String, dynamic> message) async {
      print("onResume: $message");
    });

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Create a new Event'),
      ),
      body: Container(
          child: Column(children: <Widget>[
        Container(
            child: Form(
          key: form_key,
          autovalidate: true,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                children: <Widget>[
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: eventNameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.event),
                    labelText: "Event Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              // SizedBox(
              //   height: 20,
              // ),
              // TextFormField(
              //   validator: (value) {
              //           if (value.isEmpty) {
              //             return 'Please enter Event Date';
              //           } else {
              //             return null;
              //           }
              //         },
              //   controller: eventDateController,
              //   keyboardType: TextInputType.text,
              //   decoration: InputDecoration(
              //       prefixIcon: Icon(Icons.date_range),
              //       labelText: "Event Date",
              //       border: OutlineInputBorder(
              //           borderRadius: BorderRadius.circular(10.0))),
              // ),
              SizedBox(
                height: 20,
              ),
              DateTimeField(
                controller: eventDateController,
                format: format,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range),
                    labelText: "Event Date",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: eventVenueController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_on),
                    labelText: "Event Venue",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              SizedBox(
                height: 20,
              ),

              DateTimeField(
                format: formats,
                controller: eventTimeController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.timer),
                    labelText: "Event Time",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
                onShowPicker: (context, currentValue) async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.convert(time);
                },
              ),

              SizedBox(
                height: 20,
              ),
              Container(
                height: 45,
                width: 400,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30.0)),
                child: RaisedButton(
                  color: Colors.blue[900],
                  onPressed: () {
                    createEvnt();
                    sendNotification();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => NotificationPage(),
                    //     ));
                  },
                  textColor: Colors.white,
                  child: Text(
                    _isLoading ? 'Creating event..' : "Create",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ]..addAll(
                    messages.map(buildMessage).toList(),
                  )),
          ),
        ))
      ])),
    );
  }

  void createEvnt() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'event_name': eventNameController.text,
      'event_date': eventDateController.text,
      'event_venue': eventVenueController.text,
      'event_time': eventTimeController.text,
    };

    print(data);

    var res = await CallApi().post(data, 'event');

    var body = jsonDecode(res.body);
    print(body);
    setState(() {
      _isLoading = false;
    });
  }

  Widget buildMessage(Message message) => ListTile(
   
        title: Text(message.title),
        subtitle: Text(message.body),
      );

  Future<void> sendNotification() async {
    final response = await Messaging.sendToAll(
      title: eventNameController.text,
      body: eventDateController.text,
      
    );
    print(messages);

    if (response.statusCode != 200) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content:
            Text('[${response.statusCode}] Error message: ${response.body}'),
      ));
    }
  }
}

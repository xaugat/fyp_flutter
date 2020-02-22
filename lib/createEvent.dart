import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:flutter/material.dart';

import 'api.dart';

class EventCreate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EventCreates();
  }
}

class EventCreates extends StatefulWidget {
  @override
  _EventCreatesState createState() => _EventCreatesState();
}

class _EventCreatesState extends State<EventCreates> {
  bool _isLoading = false;
  
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDateController = TextEditingController();
  TextEditingController eventVenueController = TextEditingController();
  TextEditingController eventTimeController = TextEditingController();

  final form_key = GlobalKey<FormState>();

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
                 validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Event Name';
                          } else {
                            return null;
                          }
                        },
                  
                  controller: eventNameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.event),
                      labelText: "Event Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Event Date';
                          } else {
                            return null;
                          }
                        },
                  controller: eventDateController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.date_range),
                      labelText: "Event Date",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Event Venue';
                          } else {
                            return null;
                          }
                        },
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
                 TextFormField(
                   validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Event Time';
                          } else {
                            return null;
                          }
                        },
                  controller: eventTimeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.timer),
                      labelText: "Event Time",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
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
                    },
                    textColor: Colors.white,
                    child: Text(_isLoading ? 'Creating event..' : "Create",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,),
                    ),
                  ),
                )
              ],
            ),
          ),
        ))
      ])),
    );
  }

  void createEvnt() async{
    setState(() {
      _isLoading = true;
    });

    var data = {
      'event_name': eventNameController.text,
      'event_date': eventDateController.text,
      'event_venue': eventVenueController.text,
      'event_time' : eventTimeController.text,
      
    };

    print(data);

    var res = await CallApi().post(data, 'event');

    var body = jsonDecode(res.body);
    print(body);
      setState(() {
      _isLoading = false;
    });
  

  
  
  }
}

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:alumniapp/alumnilist.dart';

class Userprofile extends StatelessWidget {
  String getname;
  String getmail;
  String getroleid;
  Userprofile(this.getname, this.getmail, this.getroleid);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new UserProfile(this.getname, this.getmail, this.getroleid),
    );
  }
}

class UserProfile extends StatefulWidget {
  String getname;
  String getmail;
  String getroleid;

  UserProfile(this.getname, this.getmail, this.getroleid);

  @override
  State createState() =>
      new UserProfileState(this.getname, this.getmail, this.getroleid);
}

class UserProfileState extends State<UserProfile> {
  String getname;
  String getmail;
  String getroleid;
  UserProfileState(this.getname, this.getmail, this.getroleid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(getname),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          child: Image(
                            width: 400,
                            image: AssetImage('images/cover.png'),
                          ),
                        ),

                        // sizeheight(200),

                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 3.0, // soften the shadow
                                // spreadRadius: 1.0, //extend the shadow
                              )
                            ],
                          ),
                          height: 150,
                          width: 150,
                          margin: EdgeInsets.only(top: 60, left: 130),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Image.asset('images/alumnilogo.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      child: ListTile(
                        title: Center(
                            child: Text(
                          "$getname",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                      ),
                    ),
                    Container(
                        child: Center(
                      child: Column(children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.supervised_user_circle),
                          title: Text("$getroleid"),
                        ),
                        ListTile(
                          leading: Icon(Icons.mail),
                          title: Text("$getmail"),
                        ),
                      ]),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Text('All Achievements of $getname'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

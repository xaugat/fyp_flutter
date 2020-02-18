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
  String getAddress;
  String getJob;
  String getAchievemets;
  

  Userprofile(this.getname, this.getmail, this.getroleid, this.getAddress,  this.getJob, this.getAchievemets,);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new UserProfile(this.getname, this.getmail, this.getroleid,this.getAddress, this.getJob, this.getAchievemets,),
    );
  }
}

class UserProfile extends StatefulWidget {
  String getname;
  String getmail;
  String getroleid;
  String getAddress;
  String getJob;
  String getAchievemets;
  

  UserProfile(this.getname, this.getmail, this.getroleid ,this.getAddress, this.getJob, this.getAchievemets,);

  @override
  State createState() =>
      new UserProfileState(this.getname, this.getmail, this.getroleid, this.getAddress, this.getJob, this.getAchievemets,);
}

class UserProfileState extends State<UserProfile> {
  String getname;
  String getmail;
  String getroleid;
  String getAddress;
  String getJob;
  String getAchievemets;
  
  UserProfileState(this.getname, this.getmail, this.getroleid ,this.getAddress, this.getJob, this.getAchievemets,);

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
                        ListTile(
                          leading: Icon(Icons.location_on),
                          title: Text("$getAddress"),
                        ),
                        ListTile(
                          leading: Icon(Icons.work),
                          title: Text("$getJob"),
                        ),
                        
                      ]),
                    )),
                    SizedBox(
                      height: 80,
                    ),
                    Center(child: Text('All Achievements of $getname', style: TextStyle(fontWeight:FontWeight.bold),)),
                    ListTile(
                          leading: Icon(Icons.view_list),
                          title: Text("$getAchievemets"),
                        ),
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

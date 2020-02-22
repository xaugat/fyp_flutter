import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:alumniapp/alumnilist.dart';
import 'package:url_launcher/url_launcher.dart';

class Userprofile extends StatelessWidget {
  String getname;
  String getmail;
  String getroleid;
  String getAddress;
  String getPhone;
  String getJob;
  String getAchievemets;
  

  Userprofile(this.getname, this.getmail, this.getroleid, this.getAddress, this.getPhone, this.getJob, this.getAchievemets,);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new UserProfile(this.getname, this.getmail, this.getroleid,this.getAddress, this.getPhone, this.getJob, this.getAchievemets,),
    );
  }
}

class UserProfile extends StatefulWidget {
  String getname;
  String getmail;
  String getroleid;
  String getAddress;
  String getPhone;
  String getJob;
  String getAchievemets;
  

  UserProfile(this.getname, this.getmail, this.getroleid ,this.getAddress, this.getPhone, this.getJob, this.getAchievemets,);

  @override
  State createState() =>
      new UserProfileState(this.getname, this.getmail, this.getroleid, this.getAddress, this.getPhone, this.getJob, this.getAchievemets,);
}

class UserProfileState extends State<UserProfile> {
  String getname;
  String getmail;
  String getroleid;
  String getAddress;
  String getPhone;
  String getJob;
  String getAchievemets;
  // final String phone = 'tel:+9779860401034'; 

  
  
  UserProfileState(this.getname, this.getmail, this.getroleid ,this.getAddress, this.getPhone, this.getJob, this.getAchievemets,);
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
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
                      height: 15,
                    ),
                    Container(
                      child: ListTile(
                        title: Center(
                            child: Column(
                              children: <Widget>[
                                Text(
                          "$getname",
                          style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:<Widget>[
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 3.0, // soften the shadow
                                // spreadRadius: 1.0, //extend the shadow
                              )
                            ],
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.message),
                                color: Colors.white,
                                iconSize: 40, 
                                onPressed: (){}),
                            ),
                              SizedBox(height:30, width: 20,),
                              Container(
                                
                                decoration: BoxDecoration(
                               boxShadow: [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 3.0, // soften the shadow
                                // spreadRadius: 1.0, //extend the shadow
                              )
                            ],
                                 color: Colors.blue[900],
                                 borderRadius: BorderRadius.circular(100),
                                ),
                                child: IconButton(
                                icon: Icon(Icons.call),
                                color: Colors.white,
                                iconSize: 40, 
                                onPressed: (){
                                  _callPhone('tel:+977$getPhone');
                                }),
                              ), 

                          ]
                        )
                              ],
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
  _callPhone(phone) async {
  if (await canLaunch(phone)) {
    await launch(phone);
  } else {
    throw 'Could not Call Phone';
  }
}
 
}

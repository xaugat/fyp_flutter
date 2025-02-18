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
      debugShowCheckedModeBanner: false,
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
            icon: Icon(Icons.link),
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
                        Card(
                                                  child: Container(
                            child: Image(
                              width: 400,
                              image: AssetImage('images/cover.png'),
                            ),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Center(
                        child: Column(children: <Widget>[
                          Card(
                             
                                child: ListTile(
                                leading: Icon(Icons.supervised_user_circle,color: Colors.indigo,),
                                title: Text('Role'),
                                subtitle: Text("$getroleid"),
                            ),
                              
                          ),
                          Card(
                                                      child: ListTile(
                              leading: Icon(Icons.mail, color: Colors.blueGrey,),
                              title: Text('Email'),
                              subtitle: Text("$getmail"),
                            ),
                          ),
                          Card(
                                                      child: ListTile(
                              leading: Icon(Icons.location_on, color: Colors.red,),
                              title: Text('Address'),
                              subtitle: Text("$getAddress"),
                            ),
                          ),
                          Card(
                                                      child: ListTile(
                              leading: Icon(Icons.work, color: Colors.brown,),
                              title: Text('Job'),
                              subtitle: Text("$getJob"),
                            ),
                          ),
                          
                        ]),
                      )),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                   Text('About $getname', style: TextStyle(fontWeight:FontWeight.bold),),
                   SizedBox(height:10),
                    Card(
                                          child: ListTile(
                            leading: Icon(Icons.star, color: Colors.indigo,),
                            title: Text('Achievements'),
                            
                            subtitle: Text("$getAchievemets"),
                          ),
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

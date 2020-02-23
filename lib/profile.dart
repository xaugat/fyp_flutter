import 'package:alumniapp/createEvent.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:alumniapp/homepage.dart';

class Myprofile extends StatelessWidget {
  @override

  // Userprofile(this.name);

  String accessToken;
  Myprofile(this.accessToken);
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new MyProfile(this.accessToken),
    );
  }
}

class MyProfile extends StatefulWidget {
  //String name;
  String accessToken;
  MyProfile(this.accessToken);

  @override
  State createState() => new MyProfileState(this.accessToken);
}

class MyProfileState extends State<MyProfile> {
  // String name;
  // UserProfileState();
  String accessToken;
  MyProfileState(this.accessToken);
  TextEditingController adminController = TextEditingController();

  final myController = TextEditingController();
  List<String> item = List();
  String temp;

  bool _isLoading = false;

  static var username;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Map data;

  Future getData() async {
    try {
      Map<String, String> headers = {
        "Authorization": "Bearer $accessToken"
      }; /** sending access token to api */
      print("header is $headers");

      http.Response response = await http.get(
        "http://192.168.0.116:8000/api/auth/user",
        headers: headers,
      );
      data = json.decode(response.body);

      print(data);
      return data;
    } catch (e) {
      print('error');
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    var _onPressed;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: const Text("Profile page"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
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
                      height: 20,
                    ),
                    FutureBuilder(
                      future: getData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        print(snapshot.data);
                        if (snapshot.data == null) {
                          return Container(
                              child: Center(
                            child: Text("Loading...."),
                          ));
                        } else {
                          return Container(
                            child: Column(children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right:100,left: 100),
                                child: Container(
                                  child: ListTile(
                                    subtitle: Container(
                                      child: RaisedButton(
                                        onPressed: () {
                                          if (data['role']['name'] == 'admin') {
                                            _onPressed = Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EventCreate(),
                                                ));
                                          } else {
                                            return _onPressed;
                                          }
                                        },
                                        child: Text('Add Events'),
                                      ),
                                    ),
                                    title: Center(
                                        child: Text(
                                      data['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    )),
                                  ),
                                ),
                              ),
                              ListTile(
                                leading: Icon(Icons.mail),
                                title: Text(data['email']),
                              ),
                              ListTile(
                                leading: Icon(Icons.supervised_user_circle),
                                title: Text(data['role']['name'].toString()),
                              ),
                              ListTile(
                                leading: Icon(Icons.location_on),
                                title: Text(data['Address']),
                              ),
                              ListTile(
                                leading: Icon(Icons.work),
                                title: Text(data['Job']),
                              ),
                              ListTile(
                                leading: Icon(Icons.phone),
                                title: Text(data['Phone']),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Your All Achievements:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                leading: Icon(Icons.line_style),
                                title: Text(data['Achievements']),
                              ),
                            ]),
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 330,
                      child: TextField(
                        onChanged: (str) {
                          temp = str;
                        },
                        maxLength: 50,
                        controller: myController,
                        decoration: InputDecoration(
                          hintText: 'Add more Achievements...',
                          prefixIcon: Icon(
                            Icons.local_activity,
                            size: 30,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                item.add(temp);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 300,
                      padding: EdgeInsets.only(
                        top: 5,
                      ),
                      child: Center(
                        child: Card(
                          child: ListView(
                            shrinkWrap: true,
                            children:
                                item.map((element) => Text(element)).toList(),
                          ),
                        ),
                      ),
                    )
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

import 'dart:async';
import 'package:alumniapp/alumnilist.dart';
import 'package:alumniapp/profile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Homepage extends StatelessWidget {
  String accessToken;
  Homepage(this.accessToken);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home page',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(this.accessToken),
    );
  }
}

class HomePage extends StatefulWidget {
  String accessToken;
  HomePage(this.accessToken);
  @override
  _HomePageState createState() => _HomePageState(this.accessToken);
}

class _HomePageState extends State<HomePage> {
  final String url = 'http://192.168.0.107:8000/api/events';
  List data;
  String accessToken;
  _HomePageState(this.accessToken);

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    print(response.body);

    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['data'];
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Text('Events'),
          actions: <Widget>[
              
           Icon(Icons.notifications_active),
           SizedBox(width: 30,)
            
          ]
        ),
        drawer: Drawer(
          child: ListView(children: <Widget>[
            
            UserAccountsDrawerHeader(
              
              
              accountName: Text("Hello!"),
              accountEmail: Text('Welcome to the Application'),
             
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/cover.jpg'),)
              ),
            ),
            ListTile(
              title: Text('View Profile'),
              leading: Icon(Icons.account_circle),
              onTap: (){
                Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyProfile(accessToken),
                    )
                   );

              }

            ),

            
                

            ListTile(
              title: Text('Search Alumni'),
              leading: Icon(Icons.search),
              onTap: (){
                 Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AlumniList(accessToken),
                    )
                   );
              },

            ),
             ListTile(
              title: Text('Visit College'),
              leading: Icon(Icons.school),

            ),
           
             ListTile(
              title: Text('Report Us'),
              leading: Icon(Icons.report),

            ),
             ListTile(
              title: Text('Rate us'),
              leading: Icon(Icons.rate_review),

            ),
             ListTile(
              title: Text('Logout'),
              leading: Icon(Icons.exit_to_app),

            ),
          ]),
        ),
        body: ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: new Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: EdgeInsets.only(left: 2, right: 6),
                        child: ListTile(
                          leading: Icon(Icons.event_available,size: 50,color: Colors.blue[900],),
                          title: Text(data[index]['event_name'],style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text(data[index]['event_date']),
                          trailing: Column(
                            children: <Widget>[
                              
                              Icon(Icons.location_on,color: Colors.red,),
                              Text(data[index]['event_venue']),
                              
                            ],
                          ),
                           

                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}

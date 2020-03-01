import 'package:alumniapp/profile.dart';
import 'package:alumniapp/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Alumnilist extends StatelessWidget {
  @override
  String accessToken;
  Alumnilist(this.accessToken);
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: AlumniList(accessToken),
      ),
    );
  }
}

class AlumniList extends StatefulWidget {
  String accessToken;
  AlumniList(this.accessToken);

  @override
  _AlumniListState createState() => _AlumniListState(this.accessToken);
}

class _AlumniListState extends State<AlumniList> {
  TextEditingController searchController = TextEditingController();
  String accessToken;
  _AlumniListState(this.accessToken);

  final String url = 'http://192.168.0.114:8000/api/auth/users';

  List userData;
  List unfilterData;

  Map data;

  Future<String> getJsonData() async {
    var response = await http.get(Uri.encodeFull(url), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $accessToken",
      "search": searchController.text
    });
    print(response.body);
    var data = jsonDecode(response.body);

    setState(() {
      userData = data;
    });
    print(userData);
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('List of Users'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(Icons.supervised_user_circle),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(left: 20.0, right: 20.0, bottom: 8.0, top: 8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: Offset(
                    1,
                    2,
                  ),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: <Widget>[
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    hintText: 'Search by name....',
                    contentPadding: EdgeInsets.only(left: 50.0),
                    border: InputBorder.none,
                     
                  ),
                  
                ),
               
                Padding(
                  padding: const EdgeInsets.only(left: 320),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 25,
                    ),
                    color: Colors.black,
                    onPressed: () {
                      getJsonData();
                    },
                  ),
                  
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: userData == null ? 0 : userData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: ListTile(
                              leading: Icon(
                                Icons.account_circle,
                                size: 50,
                                color: Colors.black,
                              ),
                              title: Text(
                                "${userData[index]["name"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("${userData[index]["email"]}"),
                                    Text(
                                      "${userData[index]["Job"]}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 2),
                                    ),
                                    Text(
                                      "${userData[index]["Address"]}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 2),
                                    ),
                                    Text(
                                      "${userData[index]["Phone"]}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 2),
                                    ),
                                    Text(
                                      "${userData[index]["Achievements"]}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 2),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Column(
                                children: <Widget>[
                                  Text("${userData[index]["role"]["name"]}"),
                                  Icon(
                                    Icons.verified_user,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Userprofile(
                                          userData[index]['name'],
                                          userData[index]['email'],
                                          userData[index]["role"]["name"],
                                          userData[index]['Address'],
                                          userData[index]['Phone'],
                                          userData[index]['Job'],
                                          userData[index]['Achievements'])),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

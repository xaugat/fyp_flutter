import 'package:alumniapp/profile.dart';
import 'package:alumniapp/userprofile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlumniList extends StatefulWidget {
  String accessToken;
  AlumniList(this.accessToken);

  @override
  _AlumniListState createState() => _AlumniListState(this.accessToken);
}

class _AlumniListState extends State<AlumniList> {
  String accessToken;
  _AlumniListState(this.accessToken);

   final String url = 'http://100.64.202.138:8000/api/auth/users';
  
  List userData;
  List unfilterData;

  Map data;

  

  Future <String>getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json", "Authorization": "Bearer $accessToken"});
    print(response.body);
    var data = jsonDecode(response.body);

    setState(() {
      // var convertDataToJson = json.decode(response.body);
      userData = unfilterData = data;
    });
    print(userData);
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

 searchData(str){
   var strExist = str.length > 0? true:false;
   if(strExist){
     var filterData=[];
     for(var i = 0; i < unfilterData.length; i++){
       String name = unfilterData[i]['name'].toUpperCase();
       if(name.contains(str.toUpperCase())){
         filterData.add(unfilterData[i]);
       }
     }
     setState(() {
       this.userData = filterData;
     });

   }else{
     setState(() {
       this.userData = this.unfilterData;
       
     });
    
   }

 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List of Alumni'),
      ),
      body: 
      Column(
         children: <Widget>[
           Container(
             margin: EdgeInsets.only(left: 12.0,right: 12.0, bottom: 8.0, top: 8.0),
             decoration: BoxDecoration(
               color: Colors.white70,
               boxShadow: <BoxShadow>[
                 BoxShadow(
                 offset: Offset(1, 3),
               ),
               ],
               borderRadius: BorderRadius.circular(24.0),

             ),
             
             child: TextField(
               decoration: InputDecoration(
                 hintText: 'Search alumni....',
                 contentPadding: EdgeInsets.only(left: 24.0),
                 border: InputBorder.none,
               ),
               onChanged: (String str){
                 this.searchData(str);

               },
               
             ),
           ),
           
           Expanded(
                    child: ListView.builder(
              itemCount: userData == null? 0 : userData.length,
              itemBuilder: (BuildContext context, int index){
                return Container(
                  child: Card(
                                child: Column(
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.person),
                          title: Text("${userData[index]["name"]}"),
                          subtitle: Text("${userData[index]["email"]}"),
                          trailing: Text("${userData[index]["roles_id"]}"),
                          onTap: (){
                               Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Userprofile(userData[index]['name'], userData[index]['email'], userData[index]['role_id']
                                      )),
                            );
                          },
                          

                        )
                      ],
                      
                    ),
                  ),
                );

              }
      ),
           ),
         ],
       ),

    );
  }
}

class User {
  final int index;
  final String name;
  final String email;
  final String roles_id;

  User(this.index, this.name, this.email, this.roles_id);
}
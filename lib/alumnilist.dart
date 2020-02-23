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
  String accessToken;
  _AlumniListState(this.accessToken);

   final String url = 'http://192.168.0.116:8000/api/auth/users';
  
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
      body: 
      Column(
         children: <Widget>[
           Container(
             margin: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 8.0, top: 8.0),
             decoration: BoxDecoration(
               color: Colors.white,
               boxShadow: <BoxShadow>[
                 BoxShadow(
                 offset: Offset(1, 2,),
               ),
               ],
               borderRadius: BorderRadius.circular(0.0),

             ),
             
             child: Padding(
               padding: const EdgeInsets.only(left: 20),
               child: TextField(
                 decoration: InputDecoration(  
                  icon: Icon(Icons.search,color: Colors.black,), 
                   hintText: 'Search users....',
                   contentPadding: EdgeInsets.only(left: 20.0),
                   
                   border: InputBorder.none,
                 ),
                 onChanged: (String str){
                   this.searchData(str);

                 },
                 
               ),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ListTile(
                            
                            leading: Icon(Icons.account_circle, size: 50,color: Colors.black
                            ,),
                            
                            title: Text("${userData[index]["name"]}", style: TextStyle(fontWeight:FontWeight.bold, fontSize: 18),),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top:5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("${userData[index]["email"]}"),
                                  Text("${userData[index]["Job"]}",style: TextStyle(color:Colors.white,fontSize: 2),),
                                  Text("${userData[index]["Address"]}",style: TextStyle(color:Colors.white, fontSize: 2),),
                                  Text("${userData[index]["Phone"]}",style: TextStyle(color:Colors.white, fontSize: 2),),
                                  Text("${userData[index]["Achievements"]}",style: TextStyle(color:Colors.white, fontSize: 2),),
                                ],
                              ),
                            ),
                            trailing: Column(
                              children: <Widget>[
                                Text("${userData[index]["role"]["name"]}"),
                                Icon(Icons.verified_user,color: Colors.blueAccent,),
                                
                               
                                
                              ],
                              
                            ),
                            onTap: (){
                                 Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Userprofile(userData[index]['name'], userData[index]['email'], userData[index]["role"]["name"], userData[index]['Address'], userData[index]['Phone'], userData[index]['Job'], userData[index]['Achievements']
                                        )),
                              );
                            },
                            

                          ),
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
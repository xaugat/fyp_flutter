
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Updateuser extends StatelessWidget {
  String token;
  
  int getid;
  int role;
  String name;
  String email;
    String phone;
     String address;
      String job;
  String achievements;
  Updateuser(this.token, this.getid,  this.role, this.name, this.email, this.phone, this.address,this.job, this.achievements,);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Updateusers(this.token, this.getid,  this.role, this.name,this.email, this.phone, this.address,this.job, this.achievements,)),
    );
  }
}

class Updateusers extends StatefulWidget {
  String token;
  
  int role;
  int getid;
  String name;
  String email;
    String phone;
     String address;
      String job;
  String achievements;
  Updateusers(this.token, this.getid,  this.role, this.name, this.email, this.phone, this.address,this.job,this.achievements,);
  @override
  _UpdateusersState createState() => _UpdateusersState(this.token, this.getid,  this.role, this.name, this.email, this.phone, this.address,this.job, this.achievements,);
}

class  _UpdateusersState extends State<Updateusers>{

 bool _isLoading = false;
  TextEditingController updateNameController = TextEditingController();
  TextEditingController updateEmailController = TextEditingController();
  TextEditingController updateRolesidController = TextEditingController();
  TextEditingController updatePhoneController = TextEditingController();
  TextEditingController updateAddressController = TextEditingController();
  TextEditingController updatePasswordController = TextEditingController();
  TextEditingController updateAchievementsController = TextEditingController();
  TextEditingController updateJobController = TextEditingController();
  String token;
  int getid;
  int role;
  String name;
   String email;
    String phone;
     String address;
      String job;
  
  String achievements;
  

  

  _UpdateusersState(this.token, this.getid,  this.role, this.name, this.email, this.phone, this.address,this.job, this.achievements,);

   final String _url = 'http://192.168.0.114:8000/api/auth/';
  

    put(data, apiUrl) async{
    var fullUrl = _url + apiUrl;
    return http.put(
      fullUrl, 
      body: jsonEncode(data),
      headers: _setHeaders()

    );
  }

  _setHeaders() => {
        'Content-Type': 'application/json',
    'Accept': 'application/json',
    "Authorization": "Bearer $token}",
  };

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Update your profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: <Widget>[
            TextFormField(
              controller: updateNameController..text = '$name',
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.supervised_user_circle),
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: updateEmailController..text = '$email',
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: "Email",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Event Time';
                          } else {
                            return null;
                          }
                        },
              controller: updatePasswordController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_open),
                  labelText: "Password",
                  hintText: 'Please Provide your password to update',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: updatePhoneController..text = '$phone',
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  labelText: "Phone",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: updateAddressController..text = '$address',
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.location_on),
                  labelText: "Address",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: updateAchievementsController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.grade),
                  labelText: "Achievements",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: updateJobController..text = '$job',
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.work),
                  labelText: "Job",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  handleupdate();
                },
                color: Colors.blue[900],
                child: Text(
                  _isLoading ? 'Updating Profile..' : "Update Now",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    
  }

  void handleupdate() async{
    setState(() {
      _isLoading = true;
    });

    var data = {
      'name': updateNameController.text,
      'email': updateEmailController.text,
      'password': updatePasswordController.text,
      'roles_id' : role,
      'phone' : updatePhoneController.text,
      'address' : updateAddressController.text,
      'Achievements' : achievements + updateAchievementsController.text,
      'Job' : updateJobController.text,
      
    };

    print(data);

    var res = await _UpdateusersState(this.token, this.getid,  this.role,this.name, this.email, this.phone, this.address,this.job, this.achievements,).put(data, 'userupdate/$getid');

    var body = jsonDecode(res.body);
    print(body);
    setState(() {
      _isLoading = false;
    });

  }


  
}



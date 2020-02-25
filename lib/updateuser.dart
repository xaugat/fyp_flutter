
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Updateuser extends StatelessWidget {
  String token;
  String achievements;
  int getid;
  String address;
  Updateuser(this.token, this.getid, this.achievements, this.address);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Updateusers(this.token, this.getid, this.achievements, this.address)),
    );
  }
}

class Updateusers extends StatefulWidget {
  String token;
  String achievements;
  String address;
  int getid;
  Updateusers(this.token, this.getid, this.achievements, this.address);
  @override
  _UpdateusersState createState() => _UpdateusersState(this.token, this.getid, this.achievements, this.address);
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
  String achievements;
  String address;
  int getid;
  

  

  _UpdateusersState(this.token, this.getid, this.achievements, this.address);

   final String _url = 'http://192.168.0.116:8000/api/auth/';
  

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
              controller: updateNameController,
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
              controller: updateEmailController,
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
              controller: updatePasswordController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_open),
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: updatePhoneController,
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
              controller: updateAddressController,
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
              controller: updateRolesidController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.verified_user),
                  labelText: "Role",
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
              controller: updateJobController,
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
      'roles_id' : updateRolesidController.text,
      'phone' : updatePhoneController.text,
      'address' : updateAddressController.text,
      'Achievements' : achievements + updateAchievementsController.text,
      'Job' : updateJobController.text,
      
    };

    print(data);

    var res = await _UpdateusersState(this.token, this.getid, this.achievements , this.address).put(data, 'userupdate/$getid');

    var body = jsonDecode(res.body);
    print(body);
    setState(() {
      _isLoading = false;
    });

  }


  
}



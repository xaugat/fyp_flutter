import 'dart:convert';

import 'package:alumniapp/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:alumniapp/main.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class Registrationpage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistrationpageState();
  }
}

class RegistrationpageState extends State<Registrationpage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController symbolController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfController = TextEditingController();
  TextEditingController roleController = TextEditingController();


  bool _isLoading = false;
 
 List<DropdownMenuItem<int>> listDrop = [];
 int selected = null;

 void loadData(){
   listDrop = [];
   listDrop.add(new DropdownMenuItem(
     child: new Text('Male'), value: 1,
     
   ),
   );
   listDrop.add(new DropdownMenuItem(
     child: new Text('Female'), value: 2,
     
   ));
 }

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Container(
                      child: Image(
                        height: 100,
                        width: 100,
                        image: AssetImage('images/alumnilogo.png'),
                        color: Colors.blue[900],
                      ),
                    ),
                    
                  )
                  ,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('Register for new user', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Full Name",
                      
                    ),
                    // validator: (String value) {
                    //   if (value.trim().isEmpty) {
                    //     return 'Name cannot be empty*';
                    //   }
                    // },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Email*",
                    ),
                    // validator: (String value) {
                    //   if (value.trim().isEmpty) {
                    //     return 'Email address cannot be empty';
                    //   }
                    // },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Phone*",
                    ),
                    // validator: (String value) {
                    //   if (value.trim().isEmpty) {
                    //     return 'Phone cannot be empty';
                    //   }
                    // },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "College Symbol No.*",
                    ),
                    // validator: (String value) {
                    //   if (value.trim().isEmpty) {
                    //     return 'Symbol No cannot be empty';
                    //   }
                    // },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordConfController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "password confirmation",
                    ),
                    // validator: (String value) {
                    //   if (value.trim().isEmpty) {
                    //     return 'Address cannot be empty';
                    //   }
                    // },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Password*",
                    ),
                    // validator: (String value) {
                    //   if (value.trim().isEmpty) {
                    //     return 'Education cannot be empty';
                    //   }
                    // },
                  ),
                   TextFormField(
                    controller: roleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "role*",
                    ),
                   ),
                  SizedBox(
                    height: 10,
                  ),
                  
                  Container(
                    height: 50,
                    width: 200,
                    child: DropdownButton(
                      value: selected,
                      items: listDrop ,
                      hint: Text('Select your gender'),
                      onChanged: (value){
                        selected = value;
                        setState(() {
                          
                        });
                      },
                    ),

                  ),
                  
                  
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        width: 430,
                        height: 50,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onPressed: () {
                            _handleSubmit();
                                                      },
                                                      color: Colors.blueAccent,
                                                      child: Text(
                                                       _isLoading ? 'Registering..' : "Submit",
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                            
                                              /*
                                       * For password textfield
                                       */
                                            ]),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            
                              void _handleSubmit() async{
                                setState(() {
                                  _isLoading = true;
                                });



                                var data = {
                                  'name' : nameController.text,
                                  'email' : emailController.text,
                                  'password' : passwordController.text, 
                                  'password_confirmation' : passwordConfController.text,
                                  'roles_id' : roleController.text, 
                                  

                                };

                                print(data);

                                var res = await CallApi().postData(data, 'signup');
                                
                                var body = jsonDecode(res.body);
                                print(body);

                                   setState(() {
                                  _isLoading = false;
                                });
                              }
}

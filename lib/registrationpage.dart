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
  TextEditingController achievementController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  bool _isLoading = false;

  List<DropdownMenuItem<int>> listDrop = [];
  int selected = null;

  final _formKey = GlobalKey<FormState>();

  void loadData() {
    listDrop = [];
    listDrop.add(
      new DropdownMenuItem(
        child: new Text('Male'),
        value: 1,
      ),
    );
    listDrop.add(new DropdownMenuItem(
      child: new Text('Female'),
      value: 2,
    ));
  }
 

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidate: true,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                            child: Text(
                          'Register for new user',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                      ),
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your Full name';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Full Name",
                          hintText: "Please enter your full name",
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
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your valid email';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Email",
                            hintText: "Please enter your valid email"),
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your phone number';
                          } else {
                            return null;
                          }
                        },
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        maxLengthEnforced: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Please enter your valid mobile number",
                          labelText: "Phone",
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your phone Symbol number';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "College Symbol No",
                          
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
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a new password';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Password",
                            hintText: "Please create a Password"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter same password';
                          } else {
                            return null;
                          }
                        },
                        controller: passwordConfController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Password confirmation",
                            hintText: "Password should match"),
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
                        controller: roleController,
                        maxLength: 1,
                        maxLengthEnforced: true,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your role';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "role",
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
                          items: listDrop,
                          hint: Text('Select your gender'),
                          onChanged: (value) {
                            selected = value;
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your achievements';
                          } else {
                            return null;
                          }
                        },
                        controller: achievementController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          labelText: "Enter your achievements",
                          hintText: 'Achievement',
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your address';
                          } else {
                            return null;
                          }
                        },
                        controller: addressController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Address",
                            hintText: "Enter your Recent Address"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your profession';
                          } else {
                            return null;
                          }
                        },
                        controller: jobController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            labelText: "Job",
                            hintText: "Enter your profession"),
                      ),
                      SizedBox(
                        height: 10,
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
          SizedBox(
                        height: 300,
                      ),
        ],
      ),
    );
  }

  void _handleSubmit() async {
    setState(() {
      _isLoading = true;
    });

    var data = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'password_confirmation': passwordConfController.text,
      'roles_id': roleController.text,
      'phone' : phoneController.text,
      'address' : addressController.text,
      'Achievements' : achievementController.text,
      'Job' : jobController.text,
    };

    print(data);

    var res = await CallApi().postData(data, 'signup');

    var body = jsonDecode(res.body);
    showDialog(context: context,
                    builder: (BuildContext context){
    return AlertDialog(
          title: Text('Message'),
          content: Text(res.body),
          actions: <Widget>[
            FlatButton(onPressed: (){
                  Navigator.pop(context);
                  Navigator.pop(context);
            }, child: Text('ok'))
          ],
        );
                    },
    );
    print(body);
    

    setState(() {
      _isLoading = false;
    });
  }
}

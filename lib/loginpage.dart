import 'package:alumniapp/homepage.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alumniapp/registrationpage.dart';

import 'api.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;

  ScaffoldState scaffoldState;

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {},
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  var sizebox = SizedBox(
    height: 10,
  );

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Login to Your Account'),
        backgroundColor: Colors.blue[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                alumnilogo(context),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                sizebox,
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
                sizebox,
                ButtonTheme(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  minWidth: MediaQuery.of(context).size.width - 10,
                  height: 45,
                  child: RaisedButton(
                    color: Colors.blue[900],
                    child: Text(
                      _isLoading ? 'Loging in..' : "Login",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });

                      signIn(emailController.text, passwordController.text);
                    },
                  ),
                ),
                MaterialButton(
                  splashColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(fontSize: 20.0),
                  ),
                  minWidth: MediaQuery.of(context).size.width,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Not registered Yet?"),
                          MaterialButton(
                            splashColor: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            minWidth: 5,
                            height: 5,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Choose Your role',style: TextStyle(fontWeight:FontWeight.bold),),
                                      content: Text('Register As'),
                                      actions: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              width: 400,
                                              child: RaisedButton(
                                                color: Colors.blue[900],
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Registrationpage(0)),
                                                  );
                                                },
                                                child: Text('Admin'),
                                              ),
                                            ),
                                            Container(
                                              width: 400,
                                              child: RaisedButton(
                                                color: Colors.blue[900],
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Registrationpage(1)),
                                                  );
                                                },
                                                child: Text('College'),
                                              ),
                                            ),
                                            Container(
                                              width: 400,
                                              child: RaisedButton(
                                                color: Colors.blue[900],
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Registrationpage(2)),
                                                  );
                                                },
                                                child: Text('Alumni'),
                                              ),
                                            ),
                                            Container(
                                              width: 400,
                                              child: RaisedButton(
                                                color: Colors.blue[900],
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Registrationpage(3)),
                                                  );
                                                },
                                                child: Text('Student'),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Text("Sign Up"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, password) async {
    setState(() {
      _isLoading = true;
    });
    Map data = {'email': email, 'password': password};
    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await CallApi().postData(data, 'login');
    if (response.statusCode == 200) {
      jsonData = json.decode(response.body);

      setState(() {
        sharedPreferences.setString("token", jsonData['access_token']);
        var accessToken = jsonData['access_token'];

        print(accessToken);

        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => HomePage(accessToken)),
            (Route<dynamic> route) => false);
      });
      setState(() {
        _isLoading = false;
      });
    } else {
      _showMsg(response.body);
      print(response.body);
    }
  }
}

String validateEmail(String value) {
  Pattern emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp emailRegExp = RegExp(emailPattern);

  if (!emailRegExp.hasMatch(value)) {
    return 'Please enter your valid Email';
  } else {
    return null;
  }
}

/*
 * 
 */
Widget alumnilogo(context) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Material(
              child: Image(
                image: AssetImage('images/alumnilogo.png'),
                color: Colors.blue[900],
              ),
            ),
          ),
        )
      ],
    ),
  );
}

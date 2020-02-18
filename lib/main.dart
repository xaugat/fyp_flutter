import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:alumniapp/post.dart';
import 'package:alumniapp/profile.dart';
import 'package:alumniapp/registrationpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:alumniapp/homepage.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'api.dart';

void main() {
  runApp(Main());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.blue[900], // navigation bar color
    statusBarColor: Colors.blue[900], // status bar color
  ));
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("hello");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: LoginPage(),
      ),
    );
  }
}

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

  _showMsg(msg){
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: (){},

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
    return Padding(
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
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Password';
                  } else {
                    return null;
                  }
                },
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
                    "Login",
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
                    // signIn("sauugat@gmail.com", "saugat121");
                    
                  },
                ),
              ),
              MaterialButton(
                splashColor: Colors.blue[900],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                onPressed: () {
                 
                },
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
                             Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Registrationpage()),
                  );
                            
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
    );
  }

  void signIn(String email, password) async{
    Map data = {
      'email' : email,
      'password' : password
    };
    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var response = await CallApi().postData(data, 'login');
    if(response.statusCode ==200){
      jsonData = json.decode(response.body);
      

      setState(() {
        sharedPreferences.setString("token", jsonData['access_token']);
        var accessToken = jsonData['access_token'];

  
        print(accessToken);
        
        
       

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => HomePage(accessToken)), (Route<dynamic> route) => false );

        
      });
    }
    else{
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

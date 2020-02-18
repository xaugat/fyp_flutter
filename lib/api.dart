import 'dart:convert';

import 'package:http/http.dart'as http;

class CallApi{

  final String _url = 'http://192.168.0.107:8000/api/auth/';

  postData(data, apiUrl) async{
    var fullUrl = _url + apiUrl;
    return http.post(
      fullUrl, 
      body: jsonEncode(data),
      headers: _setHeaders()

    );
  }

  getData(apiUrl)async{
    var fullUrl = _url + apiUrl;
    return await http.get(
      fullUrl,
      headers: _setHeaders()
      
    );
  }

  _setHeaders() => {
        'Content-Type': 'application/json',
    'Accept': 'application/json',
 


  };

}
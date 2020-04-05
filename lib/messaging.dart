import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
class Messaging{
  static final Client client = Client();

  static const String serverKey = 'AAAAY_beFgA:APA91bEI7DibGoJ1MRJhgcsXA_v0wffURD9bdSEiTDg6CCJtoLRc9z_bNtR3zNIJUUPmgooszOvBA__cVFfRhyKSFUaGvFIyjLwzGvN3i2EP9FDkhOEuAyKRE5Nn6-HZgnmB2CmoTss9';


  static Future<Response> sendToAll({
    @required String title,
    @required String body,

  })=>

  sendToTopic(title: title, body:body, topic: 'all');


  static Future<Response> sendToTopic({
    @required String title,
    @required String body,
    @required String topic
  })=>
  sendTo(title: title, body: body, fcmToken: '/topics/$topic');

  static Future<Response> sendTo({
    @required String title,
    @required String body,
    @required String fcmToken,
  })=>
  client.post('https://fcm.googleapis.com/fcm/send',

  body: json.encode({
    'notification': {'body': '$body', 'title': '$title'},
    'priority' : 'high',
    'data': {
      'click_action' : 'FLUTTER_NOTIFICATION_CLICK',
      'id' : '1',
      'status' : 'done',
    },
    'to' : '$fcmToken',
    
  }),
  headers: {
    'Content-Type' : 'application/json',
    'Authorization' : 'key= $serverKey'
  }

  );











}






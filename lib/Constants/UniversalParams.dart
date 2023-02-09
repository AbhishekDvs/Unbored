import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UniversalParams {
  static String universalURL = 'http://www.boredapi.com/api/';

  static var activity;
  static var type;
  static var participants;
  static var link;

  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static Future<void> GetSomeActivity() async {
    // ignore: unused_local_variable
    final response =
        await http.get(Uri.parse('${UniversalParams.universalURL}activity/'));
    const JsonDecoder decoder = JsonDecoder();
    final Map<String, dynamic> object = decoder.convert(response.body);
    print(object);
    activity = object['activity'];
    type = object['participants'];
    link = object['link'];
  }
}

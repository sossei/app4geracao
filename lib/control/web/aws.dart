import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

final awskey = {'X-API-Key': 'sXJNAnFt1DhfG8PeEANV1VRWcuzMsQMpuc1XLv40'};
final awsurl = 'https://imptg0lx1i.execute-api.sa-east-1.amazonaws.com/dev';
String getResponse(Response response) {
  debugPrint('${response.statusCode}');
  debugPrint('${response.body}');
  if (response.statusCode == 200) {
    String json = response.body;
    if (json.contains('errorMessage')) {
      Map mapError = jsonDecode(response.body);
      throw (mapError['errorMessage']);
    }
    return json;
  } else {
    throw (response.body);
  }
}

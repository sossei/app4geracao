import 'package:app4geracao/model/barbeiro.dart';
import 'dart:convert';

import 'package:app4geracao/control/web/aws.dart';

import 'package:http/http.dart' as http;

class SaveBarbeiroRepository {
  saveBarbeiro(Barbeiro barbeiro) async {
    String url = '$awsurl/barbeiro/save';
    String json = jsonEncode(barbeiro.toJson());
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    getResponse(response);
  }
}

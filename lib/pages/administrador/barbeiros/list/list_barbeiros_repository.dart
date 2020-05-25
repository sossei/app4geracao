import 'dart:convert';

import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/barbeiro.dart';
import 'package:http/http.dart' as http;

class ListBarbeiroRepository {
  listBarbeiros() async {
    String url = '$awsurl/barbeiro/list';
    var response = await http
        .post(url, headers: awskey, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    String body = getResponse(response);
    Iterable parsedListJson = jsonDecode(body);
    List<Barbeiro> itemsList =
        List<Barbeiro>.from(parsedListJson.map((i) => Barbeiro.fromJson(i)));
    return itemsList;
  }

  deleteBarbeiro(Barbeiro barbeiro) async {
    String url = '$awsurl/barbeiro/delete';
    String json = jsonEncode({'id': barbeiro.id});
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    getResponse(response);
  }
}

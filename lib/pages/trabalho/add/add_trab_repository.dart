import 'dart:convert';

import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/barbeiro.dart';
import 'package:app4geracao/model/servico.dart';
import 'package:http/http.dart' as http;

class AddTrabRepository {
  Future<List<Servico>> listServico() async {
    String url = '$awsurl/servico/list';
    var response = await http
        .post(url, headers: awskey, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    String body = getResponse(response);
    Iterable parsedListJson = jsonDecode(body);
    List<Servico> itemsList =
        List<Servico>.from(parsedListJson.map((i) => Servico.fromJson(i)));
    return itemsList;
  }

  Future<List<Barbeiro>> listBarbeiro() async {
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
}

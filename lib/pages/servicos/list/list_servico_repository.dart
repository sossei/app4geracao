import 'dart:convert';

import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/servico.dart';
import 'package:http/http.dart' as http;

class ListServicoRepository {
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

  deleteServico(Servico servico) async {
    String url = '$awsurl/servico/delete';
    String json = jsonEncode({'id': servico.id});
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    getResponse(response);
  }
}

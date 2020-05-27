import 'dart:convert';

import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/servico.dart';

import 'package:http/http.dart' as http;

class SaveServicoRepository {
  Future<Servico> saveServico(Servico servico) async {
    String url = '$awsurl/servico/save';
    String json = jsonEncode(servico.toJson());
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    String jsonResponse = getResponse(response);
    return Servico.fromJson(jsonDecode(jsonResponse));
  }
}

import 'dart:convert';

import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:http/http.dart' as http;

class CadastroRepository {
  cadastro(Usuario usuario) async {
    String url = '$awsurl/usuario/save';
    String json = jsonEncode(usuario.toJson());
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    getResponse(response);
  }

  editar(Usuario usuario) async {
    String url = '$awsurl/usuario/edit';
    String json = jsonEncode(usuario.toJson());
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    getResponse(response);
  }
}
import 'dart:convert';

import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:http/http.dart' as http;

class ListClienteRepository {
  listCliente() async {
    String url = '$awsurl/cliente/list';
    var response = await http
        .post(url, headers: awskey, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    String body = getResponse(response);
    Iterable parsedListJson = jsonDecode(body);
    List<Usuario> itemsList =
        List<Usuario>.from(parsedListJson.map((i) => Usuario.fromJson(i)));
    return itemsList;
  }
}

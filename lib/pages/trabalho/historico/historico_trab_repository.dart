import 'dart:convert';

import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:http/http.dart' as http;

class HistoricoTrabRepository {
  listTrabalhoByCliente() async {
    var usu = await UsuarioPref().getUsuario();
    String url = '$awsurl/trabalho/listbycliente';
    String json = jsonEncode({'usuario': usu.email});
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 15));
    String body = getResponse(response);
    Iterable parsedListJson = jsonDecode(body);
    return List<Trabalho>.from(parsedListJson.map((i) => Trabalho.fromJson(i)));
  }
}

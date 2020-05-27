import 'dart:convert';

import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:http/http.dart' as http;

class TrabalhoRepository {
  Future<Usuario> getUsuario() async {
    return await UsuarioPref().getUsuario();
  }

  salvar(Trabalho trab) async {
    String url = '$awsurl/trabalho/save';
    String json = jsonEncode(trab.toJsonWeb());
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 15));
    getResponse(response);
  }

  getCurrentTrabalho() async {
    Usuario usuario = await getUsuario();
    String url = '$awsurl/trabalho/getcurrent';
    String json = jsonEncode({'usuario': usuario.email});
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 15));
    String body = getResponse(response);
    if (body == null || body.isEmpty)
      return null;
    else {
      Trabalho trab = Trabalho.fromJson(jsonDecode(body));
      return trab.rating != null ? null : trab;
    }
  }
}

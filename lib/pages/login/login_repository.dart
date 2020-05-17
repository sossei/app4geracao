import 'dart:convert';

import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  Future<Usuario> login(String email, String senha) async {
    String url = '$awsurl/usuario/login';
    String json = jsonEncode({"email": email, "senha": senha});
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    String body = getResponse(response);
    return Usuario.fromJson(jsonDecode(body));
  }
}

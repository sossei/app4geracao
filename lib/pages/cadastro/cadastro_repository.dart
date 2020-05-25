import 'dart:convert';

import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class CadastroRepository {
  cadastro(Usuario usuario) async {
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    String url = '$awsurl/usuario/save';
    usuario.token = await _firebaseMessaging.getToken();
    String json = jsonEncode(usuario.toJson());
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    String jsonResponse = getResponse(response);
    usuario.senha = Usuario.fromJson(jsonDecode(jsonResponse)).senha;
    await UsuarioPref().saveUsuario(usuario);
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

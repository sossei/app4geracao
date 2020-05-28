import 'dart:convert';

import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class TrocarSenhaRepository {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  getUsuario() async {
    return await UsuarioPref().getUsuario();
  }

  editar(Usuario usuario) async {
    String url = '$awsurl/cliente/save';
    String json = jsonEncode(usuario.toJson());
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    getResponse(response);
  }

  Future<Usuario> login(String email, String senha) async {
    String url = '$awsurl/usuario/login';
    String token = await _firebaseMessaging.getToken();
    String json = jsonEncode({"email": email, "senha": senha, 'token': token});
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    String body = getResponse(response);
    Usuario user = Usuario.fromJson(jsonDecode(body));
    return user;
  }
}

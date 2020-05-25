import 'dart:convert';

import 'package:app4geracao/control/preferences/estabelecimento_pref.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/estabelecimento.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
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
    if (user.estabelecimento != null) {
      await getEstabelecimento(user.estabelecimento);
    }
    return user;
  }

  getEstabelecimento(String estabelecimetno) async {
    String url = '$awsurl/estabelecimento/get';
    String json = jsonEncode({"estabelecimento": estabelecimetno});
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 10));
    String body = getResponse(response);
    Estabelecimento esta = Estabelecimento.fromJson(jsonDecode(body));
    await EstabelecimentoPref().saveEstabelecimento(esta);
  }
}

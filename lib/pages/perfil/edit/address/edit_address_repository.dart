import 'dart:convert';

import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:http/http.dart' as http;

class EditAddressRepository {
  getUsuario() async {
    Usuario usuario = await UsuarioPref().getUsuario();
    if (usuario.endereco == null) usuario.endereco = Endereco();
    return usuario;
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

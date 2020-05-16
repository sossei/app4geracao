import 'dart:convert';

import 'package:app4geracao/model/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsuarioPref {
  final key = 'usario_key';
  saveUsuario(Usuario usuario) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(usuario.toJson());
    await prefs.setString(key, json);
  }

  Future<Usuario> getUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = prefs.getString(key);
    if (json == null) return null;
    return Usuario.fromJson(jsonDecode(json));
  }

  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, null);
  }
}

import 'dart:convert';

import 'package:app4geracao/model/estabelecimento.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EstabelecimentoPref {
  final key = 'estabelecimento_key';
  saveEstabelecimento(Estabelecimento estabelecimento) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = jsonEncode(estabelecimento.toJson());
    await prefs.setString(key, json);
  }

  Future<Estabelecimento> getEstabelecimento() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String json = prefs.getString(key);
    if (json == null) return null;
    return Estabelecimento.fromJson(jsonDecode(json));
  }

  clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, null);
  }
}

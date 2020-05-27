import 'dart:convert';

import 'package:app4geracao/control/preferences/estabelecimento_pref.dart';
import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/barbeiro.dart';
import 'package:app4geracao/model/estabelecimento.dart';
import 'package:app4geracao/model/servico.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:http/http.dart' as http;

class ListTrabalhoRepository {
  Future<Usuario> getUsuario() async {
    return await UsuarioPref().getUsuario();
  }

  Future<Estabelecimento> getEstabelecimento() async {
    return await EstabelecimentoPref().getEstabelecimento();
  }

  Future<List<Trabalho>> getListTrabalho(DateTime data) async {
    DateTime init = DateTime(data.year, data.month, data.day, 1);
    DateTime end = DateTime(data.year, data.month, data.day, 23);
    return await listTrabalho(init, end);
  }

  Future<List<Trabalho>> listTrabalho(
      DateTime initDate, DateTime endDate) async {
    int init = DateTime(initDate.year, initDate.month, initDate.day, 0)
        .millisecondsSinceEpoch;
    int end = DateTime(endDate.year, endDate.month, endDate.day, 24)
        .millisecondsSinceEpoch;
    String url = '$awsurl/trabalho/list';
    String json = jsonEncode({'init': init, 'end': end});
    var response = await http
        .post(url,
            headers: awskey, body: json, encoding: Encoding.getByName('utf-8'))
        .timeout(Duration(seconds: 15));
    String body = getResponse(response);
    Iterable parsedListJson = jsonDecode(body);
    return List<Trabalho>.from(parsedListJson.map((i) => Trabalho.fromJson(i)));
  }
}

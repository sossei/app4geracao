import 'dart:convert';

import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/model/trabalho.dart';

import 'package:http/http.dart' as http;

class CalendarMonthRepository {
  Future<Map<DateTime, List<Trabalho>>> listTrabalho(
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
    List<Trabalho> trabalhos =
        List<Trabalho>.from(parsedListJson.map((i) => Trabalho.fromJson(i)));
    return await _prepareData(trabalhos, initDate, endDate);
    // _animationController.forward();
  }

  Future<bool> get isAdmin async =>
      (await UsuarioPref().getUsuario()).estabelecimento != null;
  Future<Map<DateTime, List<Trabalho>>> _prepareData(
      trabalhos, initDate, endDate) async {
    Map<DateTime, List<Trabalho>> _events = {};
    Map<DateTime, List<Trabalho>> aux = {};
    trabalhos.forEach((trab) {
      DateTime date = DateTime(trab.date.year, trab.date.month, trab.date.day);
      if (aux.containsKey(date))
        aux[date].add(trab);
      else
        aux.putIfAbsent(date, () => [trab]);
    });
    // if (!(await isAdmin)) {
    //   for (int i = 1; i <= endDate.day; i++) {
    //     List<Trabalho> trabalhos = [];
    //     DateTime dateFilter = DateTime(initDate.year, initDate.month, i);

    //     if (aux.containsKey(dateFilter)) {
    //       trabalhos = aux[dateFilter];
    //     }
    //     _events.putIfAbsent(
    //         dateFilter, () => _createArray(dateFilter, trabalhos));
    //   }
    // } else
    _events.addAll(aux);
    return _events;
    // _selectedDay =
    //     DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);
    // _selectedEvents = _events[_selectedDay] ?? [];
    // setState(() {});
  }

  // _createArray(DateTime date, List<Trabalho> list) {
  //   int defaultSize = date.weekday == 6 ? 18 : 33;
  //   int sizePreenchido = 0;
  //   list.forEach((trab) {
  //     sizePreenchido += (trab.servico.tempo / 20).round();
  //   });
  //   List<Trabalho> result = [];
  //   for (int i = 0; i < defaultSize - sizePreenchido; i++) {
  //     result.add(Trabalho());
  //   }
  //   return result;
  // }
}

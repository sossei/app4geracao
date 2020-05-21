import 'package:intl/intl.dart';

class Servico {
  String id;
  String descricao;
  int valor;
  int tempo;
  String foto;

  Servico({this.id, this.descricao, this.valor, this.tempo, this.foto});
  String get tempoFormatted => tempo == null ? null : durationToString(tempo);
  String get valorFormatted {
    if (valor == null) return null;
    final formatter = new NumberFormat("###,###.##", "pt-br");
    return formatter.format(valor / 100);
  }

  Servico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'] ?? '';
    valor = json['valor'] ?? 0;
    tempo = json['tempo'] ?? 0;
    foto = json['foto'] ?? '';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descricao'] = this.descricao;
    data['valor'] = this.valor;
    data['tempo'] = this.tempo;
    data['foto'] = this.foto;
    return data;
  }
}

String durationToString(int minutes) {
  var d = Duration(minutes: minutes);
  List<String> parts = d.toString().split(':');
  return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
}

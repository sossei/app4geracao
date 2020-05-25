// {
//   "timestamp": 123456,
//   "cliente":{},
//   "barbeiro":{},
//   "servico":{},
//   "antes":"url",
//   "depois":"url",
//   "finalizado": true,
//   "rating":5,
//   "feedback":"Ótimo corte!"
// }
import 'package:intl/intl.dart';

import 'barbeiro.dart';
import 'servico.dart';
import 'usuario.dart';

class Trabalho {
  String id;
  int trabTimestamp;
  Usuario usuario;
  Barbeiro barbeiro;
  Servico servico;
  String antes;
  String depois;
  bool finalizado;
  int rating;
  String feedback;
  DateTime get date => DateTime.fromMillisecondsSinceEpoch(trabTimestamp);
  Trabalho(
      {this.id,
      this.trabTimestamp,
      this.usuario,
      this.barbeiro,
      this.servico,
      this.antes,
      this.depois,
      this.finalizado,
      this.rating,
      this.feedback});
  bool get isFinished =>
      DateTime.now().millisecondsSinceEpoch >
      trabTimestamp + (servico.tempo * 60 * 1000);
  String get timeFormatted => DateFormat('HH:mm')
      .format(DateTime.fromMillisecondsSinceEpoch(trabTimestamp));
  Trabalho.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    trabTimestamp = json['trabTimestamp'];
    usuario =
        json['usuario'] != null ? new Usuario.fromJson(json['usuario']) : null;
    barbeiro = json['barbeiro'] != null
        ? new Barbeiro.fromJson(json['barbeiro'])
        : null;
    servico =
        json['servico'] != null ? new Servico.fromJson(json['servico']) : null;
    antes = json['antes'];
    depois = json['depois'];
    finalizado = json['finalizado'] ?? false;
    rating = json['rating'];
    feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trabTimestamp'] = this.trabTimestamp;
    if (this.usuario != null) {
      data['usuario'] = this.usuario.toJson();
    }
    if (this.barbeiro != null) {
      data['barbeiro'] = this.barbeiro.toJson();
    }
    if (this.servico != null) {
      data['servico'] = this.servico.toJson();
    }
    data['antes'] = this.antes;
    data['depois'] = this.depois;
    data['finalizado'] = this.finalizado;
    data['rating'] = this.rating;
    data['feedback'] = this.feedback;
    return data;
  }

  Map<String, dynamic> toJsonWeb() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['trabTimestamp'] = this.trabTimestamp;
    data['usuario'] = usuario.email;
    data['servico'] = servico.id;
    data['barbeiro'] = barbeiro.id;
    data['antes'] = this.antes;
    data['depois'] = this.depois;
    data['finalizado'] = this.finalizado;
    data['rating'] = this.rating;
    data['feedback'] = this.feedback;
    return data;
  }
}

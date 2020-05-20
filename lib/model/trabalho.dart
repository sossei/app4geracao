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
  int timestamp;
  Usuario usuario;
  Barbeiro barbeiro;
  Servico servico;
  String antes;
  String depois;
  bool finalizado;
  int rating;
  String feedback;

  Trabalho(
      {this.timestamp,
      this.usuario,
      this.barbeiro,
      this.servico,
      this.antes,
      this.depois,
      this.finalizado,
      this.rating,
      this.feedback});
  String get timeFormatted => DateFormat('HH:mm')
      .format(DateTime.fromMillisecondsSinceEpoch(timestamp));
  Trabalho.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    usuario =
        json['usuario'] != null ? new Usuario.fromJson(json['usuario']) : null;
    barbeiro = json['barbeiro'] != null
        ? new Barbeiro.fromJson(json['barbeiro'])
        : null;
    servico =
        json['servico'] != null ? new Servico.fromJson(json['servico']) : null;
    antes = json['antes'];
    depois = json['depois'];
    finalizado = json['finalizado'];
    rating = json['rating'];
    feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timestamp'] = this.timestamp;
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
}

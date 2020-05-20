// {
//   "domingo": {
//     "periodo": [
//     ],
//     "trabalha": false
//   },
//   "endereco": "R. Washington Osório de Oliveira, 703 - Vila Pedreiro, Piraju - SP, 18800-000",
//   "fotos": [
//     "074e7dae-2539-490d-86b6-e448155a7aa8.jpg"
//   ],
//   "id": "befb8590-a318-44ba-b1b7-b7a0ab27cfdb",
//   "nome": "Barbearia 4ª geração",
//   "quarta": {
//     "periodo": [
//       "08:00",
//       "12:00",
//       "13:00",
//       "17:00"
//     ],
//     "trabalha": true
//   },
//   "quinta": {
//     "periodo": [
//       "08:00",
//       "12:00",
//       "13:00",
//       "17:00"
//     ],
//     "trabalha": true
//   },
//   "sabado": {
//     "periodo": [
//       "08:00",
//       "12:00"
//     ],
//     "trabalha": true
//   },
//   "segunda": {
//     "periodo": [
//       "08:00",
//       "12:00",
//       "13:00",
//       "17:00"
//     ],
//     "trabalha": true
//   },
//   "sexta": {
//     "periodo": [
//       "08:00",
//       "12:00",
//       "13:00",
//       "17:00"
//     ],
//     "trabalha": true
//   },
//   "telefone": "(14) 99801-5107",
//   "terca": {
//     "periodo": [
//       "08:00",
//       "12:00",
//       "13:00",
//       "17:00"
//     ],
//     "trabalha": true
//   },
//   "whatsapp": "(14) 99801-5107"
// }
class Estabelecimento {
  String id;
  String nome;
  String endereco;
  List<String> fotos;
  String telefone;
  String whatsapp;
  DiaTrabalho segunda;
  DiaTrabalho terca;
  DiaTrabalho quarta;
  DiaTrabalho quinta;
  DiaTrabalho sexta;
  DiaTrabalho sabado;
  DiaTrabalho domingo;

  Estabelecimento(
      {this.domingo,
      this.endereco,
      this.fotos,
      this.id,
      this.nome,
      this.quarta,
      this.quinta,
      this.sabado,
      this.segunda,
      this.sexta,
      this.telefone,
      this.terca,
      this.whatsapp});

  Estabelecimento.fromJson(Map<String, dynamic> json) {
    domingo = json['domingo'] != null
        ? new DiaTrabalho.fromJson(json['domingo'])
        : null;
    endereco = json['endereco'];
    fotos = json['fotos'].cast<String>();
    id = json['id'];
    nome = json['nome'];
    quarta = json['quarta'] != null
        ? new DiaTrabalho.fromJson(json['quarta'])
        : null;
    quinta = json['quinta'] != null
        ? new DiaTrabalho.fromJson(json['quinta'])
        : null;
    sabado = json['sabado'] != null
        ? new DiaTrabalho.fromJson(json['sabado'])
        : null;
    segunda = json['segunda'] != null
        ? new DiaTrabalho.fromJson(json['segunda'])
        : null;
    sexta =
        json['sexta'] != null ? new DiaTrabalho.fromJson(json['sexta']) : null;
    telefone = json['telefone'];
    terca =
        json['terca'] != null ? new DiaTrabalho.fromJson(json['terca']) : null;
    whatsapp = json['whatsapp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.domingo != null) {
      data['domingo'] = this.domingo.toJson();
    }
    data['endereco'] = this.endereco;
    data['fotos'] = this.fotos;
    data['id'] = this.id;
    data['nome'] = this.nome;
    if (this.quarta != null) {
      data['quarta'] = this.quarta.toJson();
    }
    if (this.quinta != null) {
      data['quinta'] = this.quinta.toJson();
    }
    if (this.sabado != null) {
      data['sabado'] = this.sabado.toJson();
    }
    if (this.segunda != null) {
      data['segunda'] = this.segunda.toJson();
    }
    if (this.sexta != null) {
      data['sexta'] = this.sexta.toJson();
    }
    data['telefone'] = this.telefone;
    if (this.terca != null) {
      data['terca'] = this.terca.toJson();
    }
    data['whatsapp'] = this.whatsapp;
    return data;
  }
}

class DiaTrabalho {
  List<String> periodo;
  bool trabalha;

  DiaTrabalho({this.periodo, this.trabalha});

  DiaTrabalho.fromJson(Map<String, dynamic> json) {
    periodo = json['periodo'].cast<String>();
    trabalha = json['trabalha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['periodo'] = this.periodo;
    data['trabalha'] = this.trabalha;
    return data;
  }
}

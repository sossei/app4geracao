import 'package:app4geracao/control/web/aws.dart';

class Barbeiro {
  String id;
  String nome;
  String foto;
  List<int> servicos = [];
  List<String> ultimostrabalhos = [];
  Trabalhado trabalho;
  String get urlFoto75 => awss3 + 't75_' + (foto == null ? '' : foto);
  String get urlFoto150 => awss3 + 't150_' + (foto == null ? '' : foto);
  String get urlFoto480 => awss3 + 't480_' + (foto == null ? '' : foto);
  Barbeiro(
      {this.id,
      this.nome,
      this.foto,
      this.servicos,
      this.ultimostrabalhos,
      this.trabalho});

  Barbeiro.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    foto = json['foto'];
    servicos = json['servicos'].cast<int>();
    ultimostrabalhos = json['ultimostrabalhos'].cast<String>();
    trabalho = json['trabalho'] != null
        ? new Trabalhado.fromJson(json['trabalho'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['foto'] = this.foto;
    data['servicos'] = this.servicos == null ? [] : this.servicos;
    data['ultimostrabalhos'] =
        this.ultimostrabalhos == null ? [] : this.ultimostrabalhos;
    if (this.trabalho != null) {
      data['trabalho'] = this.trabalho.toJson();
    }
    return data;
  }
}

class Trabalhado {
  List<String> segunda;
  List<String> terca;
  List<String> quarta;
  List<String> quinta;
  List<String> sexta;
  List<String> sabado;

  Trabalhado(
      {this.segunda,
      this.terca,
      this.quarta,
      this.quinta,
      this.sexta,
      this.sabado});

  Trabalhado.fromJson(Map<String, dynamic> json) {
    segunda = json['segunda'].cast<String>();
    terca = json['terca'].cast<String>();
    quarta = json['quarta'].cast<String>();
    quinta = json['quinta'].cast<String>();
    sexta = json['sexta'].cast<String>();
    sabado = json['sabado'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['segunda'] = this.segunda;
    data['terca'] = this.terca;
    data['quarta'] = this.quarta;
    data['quinta'] = this.quinta;
    data['sexta'] = this.sexta;
    data['sabado'] = this.sabado;
    return data;
  }
}

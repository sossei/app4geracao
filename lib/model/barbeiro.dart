// {
//   "nome": "Makal",
//   "foto": "url_foto",
//   "servicos": [1],
//   "ultimostrabalhos": ["url_foto1","url_foto2","url_foto3"],
//   "trabalho": {
//     "segunda":["08:00","12:00","13:00","17:00"],
//     "terca":["08:00","12:00","13:00","17:00"],
//     "quarta":["08:00","12:00","13:00","17:00"],
//     "quinta":["08:00","12:00","13:00","17:00"],
//     "sexta":["08:00","12:00","13:00","17:00"],
//     "sabado":["08:00","12:00"],
//   }
// }
class Barbeiro {
  String nome;
  String foto;
  List<int> servicos;
  List<String> ultimostrabalhos;
  Trabalhado trabalho;

  Barbeiro(
      {this.nome,
      this.foto,
      this.servicos,
      this.ultimostrabalhos,
      this.trabalho});

  Barbeiro.fromJson(Map<String, dynamic> json) {
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
    data['nome'] = this.nome;
    data['foto'] = this.foto;
    data['servicos'] = this.servicos;
    data['ultimostrabalhos'] = this.ultimostrabalhos;
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

class Servico {
  int id;
  String descricao;
  int valor;
  String tempo;
  String foto;

  Servico({this.id, this.descricao, this.valor, this.tempo, this.foto});

  Servico.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descricao = json['descricao'];
    valor = json['valor'];
    tempo = json['tempo'];
    foto = json['foto'];
  }
  String get valorFormatted => (valor / 100).toString();
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

// {
//     "email":"viny.sossei@gmail.com",
//     "nome":"Vinicius Sossei",
//     "sobrenome":"Sakugawa",
//     "senha":"abcd",
//     "endereco":{
//         "rua":"Av.Humberto Martignoni",
//         "numero":"545",
//         "cidade":"Piraju",
//         "estado":"SP"
//     },
//     "foto_perfil":"url_foto",
//     "notificardia":true,
//     "notificarhora":true,
// }
class Usuario {
  String email;
  String nome;
  String sobrenome;
  String senha;
  Endereco endereco;
  String fotoPerfil;
  bool notificardia;
  bool notificarhora;

  Usuario(
      {this.email,
      this.nome,
      this.sobrenome,
      this.senha,
      this.endereco,
      this.fotoPerfil,
      this.notificardia,
      this.notificarhora});

  Usuario.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    nome = json['nome'];
    sobrenome = json['sobrenome'];
    senha = json['senha'];
    endereco = json['endereco'] != null
        ? new Endereco.fromJson(json['endereco'])
        : null;
    fotoPerfil = json['foto_perfil'];
    notificardia = json['notificardia'];
    notificarhora = json['notificarhora'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['nome'] = this.nome;
    data['sobrenome'] = this.sobrenome;
    data['senha'] = this.senha;
    if (this.endereco != null) {
      data['endereco'] = this.endereco.toJson();
    }
    data['foto_perfil'] = this.fotoPerfil;
    data['notificardia'] = this.notificardia;
    data['notificarhora'] = this.notificarhora;
    return data;
  }
}

class Endereco {
  String rua;
  String numero;
  String cidade;
  String estado;

  Endereco({this.rua, this.numero, this.cidade, this.estado});

  Endereco.fromJson(Map<String, dynamic> json) {
    rua = json['rua'];
    numero = json['numero'];
    cidade = json['cidade'];
    estado = json['estado'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rua'] = this.rua;
    data['numero'] = this.numero;
    data['cidade'] = this.cidade;
    data['estado'] = this.estado;
    return data;
  }
}

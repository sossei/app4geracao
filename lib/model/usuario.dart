import 'package:app4geracao/control/web/aws.dart';

class Usuario {
  String dataNascimento;
  String email;
  Endereco endereco;
  String estabelecimento;
  String fotoPerfil;
  String nome;
  bool notificardia;
  bool notificarhora;
  String senha;
  String sobrenome;
  String telefone;
  String token;
  String get urlFoto75 =>
      awss3 + 't75_' + (fotoPerfil == null ? '' : fotoPerfil);
  String get urlFoto150 =>
      awss3 + 't150_' + (fotoPerfil == null ? '' : fotoPerfil);
  String get urlFoto480 =>
      awss3 + 't480_' + (fotoPerfil == null ? '' : fotoPerfil);
  Usuario(
      {this.dataNascimento,
      this.email,
      this.endereco,
      this.estabelecimento,
      this.fotoPerfil,
      this.nome,
      this.notificardia,
      this.notificarhora,
      this.senha,
      this.sobrenome,
      this.telefone,
      this.token});

  Usuario.fromJson(Map<String, dynamic> json) {
    dataNascimento = json['data_nascimento'];
    email = json['email'];
    endereco = json['endereco'] != null
        ? new Endereco.fromJson(json['endereco'])
        : null;
    estabelecimento = json['estabelecimento'];
    fotoPerfil = json['foto_perfil'];
    nome = json['nome'];
    notificardia = json['notificardia'];
    notificarhora = json['notificarhora'];
    senha = json['senha'];
    sobrenome = json['sobrenome'];
    telefone = json['telefone'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data_nascimento'] = this.dataNascimento;
    data['email'] = this.email;
    if (this.endereco != null) {
      data['endereco'] = this.endereco.toJson();
    }
    data['estabelecimento'] = this.estabelecimento;
    data['foto_perfil'] = this.fotoPerfil;
    data['nome'] = this.nome;
    data['notificardia'] = this.notificardia;
    data['notificarhora'] = this.notificarhora;
    data['senha'] = this.senha;
    data['sobrenome'] = this.sobrenome;
    data['telefone'] = this.telefone;
    data['token'] = this.token;
    return data;
  }
}

class Endereco {
  String cidade;
  String estado;
  String numero;
  String rua;

  Endereco({this.cidade, this.estado, this.numero, this.rua});

  Endereco.fromJson(Map<String, dynamic> json) {
    cidade = json['cidade'];
    estado = json['estado'];
    numero = json['numero'];
    rua = json['rua'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cidade'] = this.cidade;
    data['estado'] = this.estado;
    data['numero'] = this.numero;
    data['rua'] = this.rua;
    return data;
  }
}

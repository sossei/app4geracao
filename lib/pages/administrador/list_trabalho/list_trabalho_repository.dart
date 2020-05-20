import 'package:app4geracao/control/preferences/estabelecimento_pref.dart';
import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/model/barbeiro.dart';
import 'package:app4geracao/model/estabelecimento.dart';
import 'package:app4geracao/model/servico.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/model/usuario.dart';

class ListTrabalhoRepository {
  Future<Usuario> getUsuario() async {
    return await UsuarioPref().getUsuario();
  }

  Future<Estabelecimento> getEstabelecimento() async {
    return await EstabelecimentoPref().getEstabelecimento();
  }

  Future<List<Trabalho>> getListTrabalho(DateTime data) async {
    int timeStampStart = data.millisecondsSinceEpoch;
    int timeStampEnd = data.add(Duration(hours: 24)).millisecondsSinceEpoch;
    await Future.delayed(Duration(seconds: 2));
    return [];
    return [
      await _factryTeste(1590008400000),
      await _factryTeste(1589836811615)
    ];
  }

  _factryTeste(int timeStamp) async {
    Usuario usuario = await UsuarioPref().getUsuario();
    Servico servico = Servico();
    servico.descricao = 'Corte de cabelo';
    servico.foto = '8fccd756-f38a-4b14-8774-e52ea56cd7eb.jpg';
    servico.valor = 5000;
    servico.tempo = '1hr';
    Barbeiro barbeiro = Barbeiro();
    barbeiro.foto = '077f846f-e610-442a-9a51-b7be688bb948 ';
    barbeiro.nome = 'Rafael';
    return Trabalho(
        barbeiro: barbeiro,
        servico: servico,
        usuario: usuario,
        timestamp: timeStamp);
  }
}

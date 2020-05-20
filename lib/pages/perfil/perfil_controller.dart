import 'package:app4geracao/control/preferences/estabelecimento_pref.dart';
import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/model/estabelecimento.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:app4geracao/pages/perfil/perfil_repository.dart';
import 'package:mobx/mobx.dart';

part 'perfil_controller.g.dart';

class PerfilController = _PerfilControllerBase with _$PerfilController;

abstract class _PerfilControllerBase with Store {
  @observable
  Usuario usuario;

  @action
  setUsuario(Usuario pusuario) {
    usuario = pusuario;
  }

  @observable
  Estabelecimento estabelecimento;

  @action
  setEstabelecimento(Estabelecimento pestabelecimento) {
    estabelecimento = pestabelecimento;
  }

  fetchData() async {
    var usu = await UsuarioPref().getUsuario();
    PerfilRepository().getUsuario(usu.email).then((value) {
      UsuarioPref().saveUsuario(value);
      setUsuario(value);
    });
    if (usu.estabelecimento != null) {
      Estabelecimento esta = await EstabelecimentoPref().getEstabelecimento();
      setEstabelecimento(esta);
      PerfilRepository().getEstabelecimento(esta.id).then((_) async {
        Estabelecimento esta = await EstabelecimentoPref().getEstabelecimento();
        setEstabelecimento(esta);
      });
    }
    setUsuario(usu);
  }
}

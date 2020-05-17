import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:mobx/mobx.dart';
part 'intro_logado_controller.g.dart';

class IntroLogadoController = _IntroLogadoControllerBase
    with _$IntroLogadoController;

abstract class _IntroLogadoControllerBase with Store {
  @observable
  Usuario usuario;

  @action
  setUsuario(Usuario pusuario) {
    usuario = pusuario;
  }

  fetchData() async {
    var usu = await UsuarioPref().getUsuario();
    setUsuario(usu);
  }
}

import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:app4geracao/pages/login/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'login_controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  bool isRequesting = false;
  @observable
  String msgErro;

  @action
  setMsgErro(String msg) {
    msgErro = msg;
    isRequesting = false;
  }

  @action
  _setRequesting(bool pRequesting) {
    isRequesting = pRequesting;
  }

  final formKey = GlobalKey<FormState>();
  final formKeyResetSenha = GlobalKey<FormState>();
  String email, senha;
  LoginRepository _repository = LoginRepository();
  String emailResetSenha;
  Future<bool> login() async {
    setMsgErro(null);
    try {
      if (formKey.currentState.validate()) {
        setMsgErro(null);
        _setRequesting(true);

        Usuario usuario = await _repository.login(email, senha);
        await UsuarioPref().saveUsuario(usuario);
        return true;
      }
    } catch (e, s) {
      debugPrint('$e - $s');
      setMsgErro(e.toString());
    }
    _setRequesting(false);
    return false;
  }

  Future<bool> resetSenha() async {
    setMsgErro(null);
    try {
      if (formKeyResetSenha.currentState.validate()) {
        _setRequesting(true);
        LoginRepository().resetSenha(emailResetSenha).then((_) {
          _setRequesting(false);
        }).catchError((e, s) {
          debugPrint('$e - $s');
          setMsgErro(e.toString());
          _setRequesting(false);
        });
        return true;
      }
    } catch (e, s) {
      debugPrint('$e - $s');
      setMsgErro(e.toString());
    }
    _setRequesting(false);
    return false;
  }
}

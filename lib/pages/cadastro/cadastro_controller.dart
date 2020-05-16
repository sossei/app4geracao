import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'cadastro_repository.dart';
part 'cadastro_controller.g.dart';

class CadastroController = _CadastroControllerBase with _$CadastroController;

abstract class _CadastroControllerBase with Store {
  @observable
  String title = 'Cadastro';
  @observable
  bool isRequesting = false;
  @observable
  bool isEndereco = false;
  @observable
  String msgErro;

  @action
  setTitle(String pTitle) {
    this.title = pTitle;
  }

  @action
  setIsEndereco(bool isEndereco) {
    this.isEndereco = isEndereco;
    if (isEndereco) setTitle('Endereço');
  }

  @action
  setMsgErro(String msg) {
    msgErro = msg;
    isRequesting = false;
  }

  @action
  _setRequesting(bool pRequesting) {
    isRequesting = pRequesting;
  }

  final formCliente = GlobalKey<FormState>();
  final formEndereco = GlobalKey<FormState>();
  Usuario usuario = Usuario();
  Endereco endereco = Endereco();
  CadastroRepository _repository = CadastroRepository();
  Future<bool> cadastro() async {
    setMsgErro(null);
    try {
      if (formCliente.currentState.validate()) {
        _setRequesting(true);
        endereco = Endereco();
        usuario.endereco = endereco;
        await _repository.cadastro(usuario);
        await UsuarioPref().saveUsuario(usuario);
        _setRequesting(false);
        setIsEndereco(true);
        return true;
      }
    } catch (e, s) {
      debugPrint('$e - $s');
      setMsgErro(e.toString());
      setIsEndereco(false);
    }
    return false;
  }

  Future<bool> editar() async {
    setMsgErro(null);
    try {
      if (formCliente.currentState.validate()) {
        _setRequesting(true);
        usuario.endereco = endereco;
        await _repository.editar(usuario);
        await UsuarioPref().saveUsuario(usuario);
        return true;
      }
    } catch (e, s) {
      debugPrint('$e - $s');
      setMsgErro(e.toString());
    }
    return false;
  }
}

import 'dart:async';
import 'dart:io';

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
  bool isEndereco = false;
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

  @action
  setTitle(String pTitle) {
    this.title = pTitle;
  }

  @action
  setIsEndereco(bool isEndereco) {
    this.isEndereco = isEndereco;
    if (isEndereco) setTitle('Endereço');
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
        var usu = await UsuarioPref().getUsuario();
        if (usu != null && usu.estabelecimento != null) {
          await _repository.save(usuario);
        } else
          await _repository.cadastro(usuario);

        _setRequesting(false);
        setIsEndereco(true);
        return true;
      }
    } catch (e, s) {
      debugPrint('$e - $s');
      if (e is SocketException || e is TimeoutException) {
        setMsgErro('Sem conexão com a internet');
      } else {
        setMsgErro(e.toString());
        setIsEndereco(false);
      }
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

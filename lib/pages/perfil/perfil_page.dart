import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/control/preferences/user_pref.dart';
import 'package:app4geracao/control/web/aws.dart';
import 'package:app4geracao/pages/perfil/edit/address/edit_address_page.dart';
import 'package:app4geracao/pages/perfil/perfil_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'edit/edit_perfil_page.dart';
import 'trocar_senha/trocar_senha_page.dart';

class PerfilPage extends StatefulWidget {
  @override
  _PerfilPageState createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> with TickerProviderStateMixin {
  PerfilController _controller = PerfilController();
  AnimationController controller;
  Animation<double> animation;
  AnimationController controllerLabel;
  Animation<double> animationLAbel;
  @override
  void initState() {
    _controller.fetchData();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInCubic);
    controllerLabel = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    animationLAbel =
        CurvedAnimation(parent: controllerLabel, curve: Curves.easeIn);
    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controllerLabel.forward();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/images/background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          appBar: AppBar(title: Text('Perfil')),
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
              child: Container(
                width: double.infinity,
                child: FadeTransition(
                  opacity: animation,
                  child: Observer(
                    builder: (_) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          _controller.estabelecimento != null
                              ? _buildEstabelecimento()
                              : Container(),
                          Expanded(
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(16.0),
                              ),
                              elevation: 4,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 32),
                                child: _controller.usuario != null
                                    ? _buildFormCliente()
                                    : _buildRequesting(),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildRequesting() {
    return CircularProgressIndicator();
  }

  _buildFormCliente() {
    return Column(
      children: <Widget>[
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 32,
                ),
                FadeTransition(
                  opacity: animationLAbel,
                  child: Text(
                    'Bem vindo ${_controller.usuario.nome}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      child: ClipOval(
                        child: _controller.usuario.fotoPerfil != null
                            ? FadeInImage.assetNetwork(
                                placeholder: 'assets/images/perfil.jpg',
                                image: awss3 +
                                    't150_' +
                                    _controller.usuario.fotoPerfil,
                                fit: BoxFit.fitWidth,
                              )
                            : Image.asset('assets/images/perfil.jpg'),
                      ),
                    ),
                    Expanded(
                      child: FadeTransition(
                        opacity: animationLAbel,
                        child: ListTile(
                            title: Text(
                              'Email: ${_controller.usuario.email}',
                              textAlign: TextAlign.center,
                            ),
                            subtitle: Text(
                              'Contato: ${_controller.usuario.telefone}',
                              textAlign: TextAlign.center,
                            )),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
        Divider(),
        ListTile(
          title: Text('Editar informações'),
          leading: Icon(FontAwesome.user),
          onTap: () => push(context, EditPerfilpage()),
        ),
        Divider(),
        ListTile(
          title: Text('Endereço'),
          leading: Icon(FontAwesome.home),
          onTap: () => push(context, EditAddressPage()),
        ),
        Divider(),
        ListTile(
          title: Text('Trocar senha'),
          leading: Icon(FontAwesome.key),
          onTap: () => push(context, TrocarSenhaPage()),
        ),
        Divider(),
        ListTile(
          title: Text('Sair'),
          leading: Icon(FontAwesome.sign_out),
          onTap: () async {
            await FirebaseMessaging().deleteInstanceID();
            await UsuarioPref().clear();
            returnSplash(context);
          },
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  _buildEstabelecimento() {
    return Column(
      children: <Widget>[
        Text(
          'Estabelecimento',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(height: 8),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(16.0),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Container(
                  height: 80,
                  width: 80,
                  child: ClipOval(
                    child: _controller.usuario.fotoPerfil != null
                        ? FadeInImage.assetNetwork(
                            placeholder: 'assets/images/perfil.jpg',
                            image:
                                '${awss3}t75_${_controller.estabelecimento.fotos[0]}',
                            fit: BoxFit.fitWidth,
                          )
                        : Image.asset('assets/images/perfil.jpg'),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      _controller.estabelecimento.nome,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(_controller.estabelecimento.telefone),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

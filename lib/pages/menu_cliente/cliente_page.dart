import 'package:app4geracao/control/nav/nav.dart';

import 'package:app4geracao/pages/perfil/perfil_page.dart';
import 'package:app4geracao/pages/trabalho/atual/trabalho_page.dart';
import 'package:app4geracao/pages/trabalho/historico/historico_trab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ClientePage extends StatefulWidget {
  @override
  _ClientePageState createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/ic_launcher_android.png'),
        ),
        title: Text('Barber 4°'),
      ),
      body: _body(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTabIndex,
        onTap: _changeIndex,
        backgroundColor: Colors.white,
        elevation: 4,
        selectedItemColor: Theme.of(context).primaryColor,
        selectedLabelStyle: TextStyle(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.grey,
        unselectedLabelStyle: TextStyle(
          color: Colors.grey,
        ),
        items: [
          BottomNavigationBarItem(
              icon: Icon(FontAwesome.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(FontAwesome.calendar), title: Text("Histórico")),
          BottomNavigationBarItem(
              icon: Icon(FontAwesome.user), title: Text("Perfil")),
        ],
      ),
    );
  }

  _changeIndex(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  _body() {
    switch (_selectedTabIndex) {
      case 0:
        return TrabalhoPage();
        break;
      case 1:
        return HistoricoTrabPage();
        break;
      case 2:
        return PerfilPage();
        break;
      default:
        return Container();
    }
  }
}

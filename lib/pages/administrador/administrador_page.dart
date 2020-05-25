import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/pages/administrador/barbeiros/list/list_barbeiro_page.dart';
import 'package:app4geracao/pages/administrador/list_trabalho/list_trabalho_page.dart';
import 'package:app4geracao/pages/administrador/servicos/list/list_servico_page.dart';
import 'package:app4geracao/pages/calendar/month/calendar_month_page.dart';

import 'package:app4geracao/pages/perfil/perfil_page.dart';
import 'package:flutter/material.dart';

class AdministradorPage extends StatefulWidget {
  @override
  _AdministradorPageState createState() => _AdministradorPageState();
}

class _AdministradorPageState extends State<AdministradorPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          child: Icon(Icons.account_circle),
          onTap: () {
            push(context, PerfilPage());
          },
        ),
        title: Text('Menu'),
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
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), title: Text("Agenda")),
          BottomNavigationBarItem(
              icon: Icon(Icons.room_service), title: Text("Serviços")),
          BottomNavigationBarItem(
              icon: Icon(Icons.perm_contact_calendar),
              title: Text("Barbeiros")),
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
        return ListTrabalhoPage();
        break;
      case 1:
        return CalendarMonthPage();
        break;
      case 2:
        return ListServicoPage();
        break;
      case 3:
        return ListBarbeiroPage();
        break;
      default:
        return Container();
    }
  }
}

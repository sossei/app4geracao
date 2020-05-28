import 'package:app4geracao/control/nav/nav.dart';
import 'package:app4geracao/model/trabalho.dart';
import 'package:app4geracao/pages/calendar/add/cli/cli_add_trab_page.dart';
import 'package:app4geracao/pages/trabalho/trabalho_detalhes_page.dart';
import 'package:app4geracao/widgets/button_4geracao.dart';
import 'package:app4geracao/widgets/panel_uploadimage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarDaypage extends StatefulWidget {
  final DateTime date;
  final bool showData;
  final Trabalho trabalho;
  final List<Trabalho> trabalhos;
  final bool isTwo;
  const CalendarDaypage(this.date, this.trabalho, this.trabalhos,
      {Key key, this.showData = false, this.isTwo = false})
      : super(key: key);

  @override
  _CalendarDaypageState createState() => _CalendarDaypageState();
}

class _CalendarDaypageState extends State<CalendarDaypage> {
  int selectedIndex;
  int maxToSelect = 1;
  static const int MINIMO = 20, START = 9, END = 21, PULAR_HORARIO_ALMOCO = 12;
  DateFormat formatHM = DateFormat('HH:mm');
  List<DateTime> itens = [];
  double tamanhoItem = 50;
  DateTime start, end;
  List<Color> pallete = [
    Color.fromARGB(0xFF, 44, 62, 57),
    Color.fromARGB(0xFF, 60, 83, 53),
    Color.fromARGB(0xFF, 88, 97, 45),
    Color.fromARGB(0xFF, 72, 56, 46),
    Color.fromARGB(0xFF, 122, 65, 44),
    Color.fromARGB(0xFF, 184, 106, 101),
    Color.fromARGB(0xFF, 135, 65, 70),
    Color.fromARGB(0xFF, 150, 55, 28),
    Color.fromARGB(0xFF, 49, 70, 88),
  ];
  int indexPallete = 0;
  _CalendarDaypageState();
  var keyScafold = new GlobalKey<ScaffoldState>();
  bool get isHoje =>
      DateTime.now().day == widget.date.day &&
      DateTime.now().month == widget.date.month &&
      DateTime.now().year == widget.date.year;

  @override
  void initState() {
    montList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyScafold,
      appBar: AppBar(
        actions: <Widget>[
          InkWell(
            onTap: () {
              pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.calendar_today),
            ),
          )
        ],
        leading: appBarLeading(),
      ),
      body: body(),
    );
  }

  Widget body() {
    return listDate();
  }

  Widget appBarLeading() {
    return Column(
      children: <Widget>[
        Text(DateFormat('MMM').format(widget.date)),
        Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: isHoje ? Colors.green : Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.all(const Radius.circular(40.0))),
            child: Padding(
                padding: EdgeInsets.all(2),
                child: Center(
                    child: Text(
                  DateFormat('dd').format(widget.date),
                  style: TextStyle(
                      fontSize: 16,
                      color: isHoje ? Colors.black : Colors.white,
                      fontWeight: FontWeight.bold),
                )))),
      ],
    );
  }

  _showMessage(msg) {
    keyScafold.currentState.showSnackBar(SnackBar(
      content: Text(msg),
      duration: Duration(seconds: 3),
    ));
  }

  Widget listDate() {
    return ListView.separated(
      separatorBuilder: (_, index) {
        return Container();
      },
      itemBuilder: (_, index) {
        if (index == itens.length - 1) return Container();
        return _buildItem(index);
      },
      itemCount: itens.length,
    );
  }

  montList() {
    int _hour = START;
    int _minute = 0;
    itens.clear();
    while (_hour < END) {
      if (_minute == 60) {
        _hour++;
        _minute = 0;
      }
      if (_hour == PULAR_HORARIO_ALMOCO) {
        DateTime date = DateTime(
            widget.date.year, widget.date.month, widget.date.day, _hour, 0);
        itens.add(date);
        _hour++;
        continue;
      }
      DateTime date = DateTime(
          widget.date.year, widget.date.month, widget.date.day, _hour, _minute);
      itens.add(date);
      _minute += MINIMO;
    }
  }

  _onTapUnselected(int index) {
    indexPallete = 0;
    bool isAlmoco = itens[index].hour == 12;
    if (widget.isTwo) {
      if ((index + 1) > itens.length) {
        _showMessage('Horário indisponível');
        return;
      }
      if (itens[index + 1].hour == 12) {
        _showMessage('Horário de almoço');
        return;
      }
      Trabalho trab = _getAgendamento(itens[index + 1]);
      bool temAgendamento = trab != null;
      if (temAgendamento) {
        _showMessage('Horário indisponível');
        return;
      }
    }

    if (isAlmoco) return;
    if (index != selectedIndex) {
      start = itens[index];
      end = widget.isTwo ? itens[index + 2] : itens[index + 1];
      setState(() {
        selectedIndex = index;
      });
    }
  }

  _styleSelected({int index, Widget child}) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              child: child,
            ),
          ],
        ),
      ],
    );
  }

  _itemSelected(int index) {
    var init = formatHM.format(start);
    var finish = formatHM.format(end);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _styleSelected(
          index: index,
          child: Container(
            height: tamanhoItem,
            margin: EdgeInsets.symmetric(horizontal: 4),
            padding: EdgeInsets.all(8),
            child: selectedIndex == index
                ? Row(
                    children: <Widget>[
                      Expanded(child: Text('Das $init até $finish')),
                      GestureDetector(
                        onTap: () {
                          fotoAntes();
                        },
                        child: Icon(
                          Icons.done,
                        ),
                      ),
                    ],
                  )
                : Container(),
          ),
        )
      ],
    );
  }

  void fotoAntes() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Colors.white,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 16,
                  ),
                  Icon(
                    Icons.person_outline,
                    color: Colors.grey,
                    size: 56,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Tire uma foto antes do ${widget.trabalho.servico.descricao} para comparar depois! Não é obrigatório, você pode pular está parte',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    width: 160,
                    child: UploadImageWidget(
                      onImageUploaded: (fileName) {
                        widget.trabalho.antes = fileName;
                        Navigator.pop(context);
                        confirmacao();
                      },
                      placeHolder: 'assets/images/perfil.jpg',
                      showExplore: false,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Button4Geracao(
                    title: 'Pular',
                    action: () {
                      Navigator.pop(context);
                      confirmacao();
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          );
        });
  }

  confirmacao() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) {
          widget.trabalho.trabTimestamp = start.millisecondsSinceEpoch;
          Widget child = CliAddTrabPage(trabalho: widget.trabalho);
          return Container(
            child: child,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          );
        });
  }

  _styleAgendamento({bool first = true, bool isTwo = false, Widget child}) {
    var colorBackground =
        widget.showData ? pallete[indexPallete] : Colors.grey[700];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: first ? 4 : 0),
          color: colorBackground,
          child: child,
        ),
      ],
    );
  }

  _itemAgendamento(Trabalho trabalho, int index) {
    bool isTwo = trabalho.servico.tempo == 40;
    bool isFirst =
        trabalho.trabTimestamp == itens[index].millisecondsSinceEpoch;
    if (isFirst) {
      indexPallete++;
      if (pallete.length <= indexPallete) indexPallete = 0;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _styleAgendamento(
          first: isFirst,
          isTwo: isTwo,
          child: Container(
            height: tamanhoItem,
            padding: EdgeInsets.all(8),
            child: !widget.showData
                ? (isFirst
                    ? Text(
                        'Horário já agendado =(',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    : Container())
                : isFirst
                    ? Text(
                        trabalho.usuario.nome,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      )
                    : Text(
                        '${trabalho.servico.descricao} - ${trabalho.barbeiro.nome}',
                        style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
        )
      ],
    );
  }

  _itemInvalid() {
    return Container(
      height: tamanhoItem,
      color: Colors.grey.withOpacity(0.8),
    );
  }

  _itemSeparator(int index) {
    DateTime item = itens[index];
    bool isBold = item.minute == 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 60,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              formatHM.format(item),
              textAlign: TextAlign.end,
              style: TextStyle(
                  fontSize: isBold ? 18 : 13,
                  fontWeight: isBold ? FontWeight.bold : FontWeight.w100),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            color: Colors.grey.withOpacity(isBold ? 0.8 : 0.2),
            height: 1,
          ),
        ),
      ],
    );
  }

  Trabalho _getAgendamento(DateTime data) {
    int timestamp = data.millisecondsSinceEpoch;

    for (int i = 0; i < widget.trabalhos.length; i++) {
      Trabalho trabalho = widget.trabalhos[i];
      if (trabalho.trabTimestamp == timestamp) return trabalho;
      int init = trabalho.trabTimestamp;
      int end =
          trabalho.trabTimestamp + (60 * 1000 * trabalho.servico.tempo).round();
      if (timestamp < end && timestamp > init) return trabalho;
    }
    return null;
  }

  _buildItem(int index) {
    DateTime item = itens[index];
    bool isInvalid = item.hour == 12;
    bool isSelected = selectedIndex != null &&
        (selectedIndex == index ||
            (widget.isTwo && selectedIndex + 1 == index));
    Trabalho trab = _getAgendamento(item);
    bool temAgendamento = trab != null;
    return GestureDetector(
      onTap: () {
        if (isInvalid) return;
        if (selectedIndex == index) return;
        if (widget.showData && temAgendamento) {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return Container(
                  child: TrabalhoDetahePage(
                    trabalho: trab,
                  ),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                );
              });
        }
        if (temAgendamento) return;
        _onTapUnselected(index);
      },
      child: Stack(
        children: <Widget>[
          Positioned(
            child: _itemSeparator(index),
          ),
          Container(
            margin: EdgeInsets.only(left: 80),
            color: Theme.of(context).backgroundColor.withOpacity(0.3),
            child: isInvalid
                ? _itemInvalid()
                : temAgendamento
                    ? _itemAgendamento(trab, index)
                    : isSelected
                        ? _itemSelected(index)
                        : Container(
                            height: tamanhoItem,
                          ),
          ),
          Container(
            width: 1,
            height: tamanhoItem,
            margin: EdgeInsets.only(left: 80),
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

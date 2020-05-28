import 'dart:collection';

import 'package:app4geracao/model/trabalho.dart';
import 'package:device_calendar/device_calendar.dart';

class ListCalendarRepository {
  DeviceCalendarPlugin _deviceCalendarPlugin;
  ListCalendarRepository() {
    _deviceCalendarPlugin = DeviceCalendarPlugin();
  }
  Future<UnmodifiableListView<Calendar>> getCalendars() async {
    Result<bool> permission = await _deviceCalendarPlugin.requestPermissions();
    if (!permission.isSuccess) throw ('Deve aceitar a permissão');
    Result<UnmodifiableListView<Calendar>> retrieve =
        await _deviceCalendarPlugin.retrieveCalendars();
    if (!retrieve.isSuccess) throw ('Falha ao buscar calendários disponível');
    return retrieve.data;
  }

  createEvent(Calendar calendar, Trabalho trabalho) async {
    Event _event = Event(
      calendar.id,
      allDay: false,
      title: 'Barber 4° - ${trabalho.servico.descricao}',
      start: trabalho.dateStart,
      end: trabalho.dateEnd,
      description:
          'Barbeiro: ${trabalho.barbeiro.nome}, valor: R\$ ${trabalho.servico.valorFormatted}',
    );
    _event.location =
        'R. Washington Osório de Oliveira, 703 - Vila Pedreiro, Piraju - SP, 18800-000, Brazil';
    _event.reminders = [Reminder(minutes: 30)];
    Result<String> result =
        await _deviceCalendarPlugin.createOrUpdateEvent(_event);
    return result;
  }
}

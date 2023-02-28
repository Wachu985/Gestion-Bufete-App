part of 'contrato_bloc.dart';

abstract class ContratoEvent {
  factory ContratoEvent.getContratosMesEvent(String mes) =>
      _GetContratosMesEvent(mes: mes);
  factory ContratoEvent.addContratoMesEvent(Contrato contrato) =>
      _AddContratoMesEvent(contrato: contrato);
  factory ContratoEvent.deleteContratoMesEvent(int id, String mes) =>
      _DeleteContratoMesEvent(id: id, mes: mes);
  factory ContratoEvent.updateContratoMesEvent(int key, Contrato contrato) =>
      _UpdateContratoMesEvent(contrato: contrato, key: key);
}

class _GetContratosMesEvent implements ContratoEvent {
  final String mes;

  const _GetContratosMesEvent({required this.mes});
}

class _AddContratoMesEvent implements ContratoEvent {
  final Contrato contrato;

  const _AddContratoMesEvent({required this.contrato});
}

class _DeleteContratoMesEvent implements ContratoEvent {
  final int id;
  final String mes;

  const _DeleteContratoMesEvent({required this.id, required this.mes});
}

class _UpdateContratoMesEvent implements ContratoEvent {
  final Contrato contrato;
  final int key;

  const _UpdateContratoMesEvent({required this.contrato, required this.key});
}

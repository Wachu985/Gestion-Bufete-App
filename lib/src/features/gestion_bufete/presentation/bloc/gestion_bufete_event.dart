part of 'gestion_bufete_bloc.dart';

abstract class GestionBufeteEvent {
  factory GestionBufeteEvent.getContratosMesEvent(String mes) =>
      _GetContratosMesEvent(mes: mes);
  factory GestionBufeteEvent.addContratoMesEvent(ContratoModel contrato) =>
      _AddContratoMesEvent(contrato: contrato);
  factory GestionBufeteEvent.deleteContratoMesEvent(int id, String mes) =>
      _DeleteContratoMesEvent(id: id, mes: mes);
  factory GestionBufeteEvent.updateContratoMesEvent(
          int key, ContratoModel contrato) =>
      _UpdateContratoMesEvent(contrato: contrato, key: key);
}

class _GetContratosMesEvent implements GestionBufeteEvent {
  final String mes;

  const _GetContratosMesEvent({required this.mes});
}

class _AddContratoMesEvent implements GestionBufeteEvent {
  final ContratoModel contrato;

  const _AddContratoMesEvent({required this.contrato});
}

class _DeleteContratoMesEvent implements GestionBufeteEvent {
  final int id;
  final String mes;

  const _DeleteContratoMesEvent({required this.id, required this.mes});
}

class _UpdateContratoMesEvent implements GestionBufeteEvent {
  final ContratoModel contrato;
  final int key;

  const _UpdateContratoMesEvent({required this.contrato, required this.key});
}

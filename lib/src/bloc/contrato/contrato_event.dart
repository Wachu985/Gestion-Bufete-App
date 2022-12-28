part of 'contrato_bloc.dart';

abstract class ContratoEvent extends Equatable {
  const ContratoEvent();

  @override
  List<Object> get props => [];
}

class GetContratosMesEvent extends ContratoEvent {
  final String mes;

  const GetContratosMesEvent(this.mes);
}

class AddContratoMesEvent extends ContratoEvent {
  final Contrato contrato;

  const AddContratoMesEvent(this.contrato);
}

class DeleteContratoMesEvent extends ContratoEvent {
  final int id;
  final String mes;

  const DeleteContratoMesEvent(this.id, this.mes);
}

class UpdateContratoMesEvent extends ContratoEvent {
  final Contrato contrato;
  final int key;

  const UpdateContratoMesEvent(this.contrato, this.key);
}

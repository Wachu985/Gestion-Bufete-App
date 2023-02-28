// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gestion_bufete_app/src/models/contrato.dart';
import 'package:gestion_bufete_app/src/services/db_service.dart';

part 'contrato_event.dart';
part 'contrato_state.dart';

class ContratoBloc extends Bloc<ContratoEvent, ContratoState> {
  ContratoBloc() : super(ContratoState.initalState()) {
    on<_GetContratosMesEvent>(_getContratoMesEvent);
    on<_AddContratoMesEvent>(_addContratoMesEvent);
    on<_DeleteContratoMesEvent>(_deleteContratoMesEvent);
    on<_UpdateContratoMesEvent>(_updateContratoMesEvent);
  }

  Future<void> _getContratoMesEvent(
      _GetContratosMesEvent event, Emitter<ContratoState> emit) async {
    emit(state.copyWith(status: ContratoStatus.loading));
    final resp = await ContratoDatabaseServices.db.getContratosMes(event.mes);
    emit(state.copyWith(
        status: ContratoStatus.success,
        contratos: resp['equipos'],
        total: resp['total']));
  }

  Future<void> _addContratoMesEvent(
      _AddContratoMesEvent event, Emitter<ContratoState> emit) async {
    await ContratoDatabaseServices.db.addContrato(event.contrato);
    add(ContratoEvent.getContratosMesEvent(event.contrato.mes!));
  }

  Future<void> _deleteContratoMesEvent(
      _DeleteContratoMesEvent event, Emitter<ContratoState> emit) async {
    await ContratoDatabaseServices.db.deleteContrato(event.id);
    add(ContratoEvent.getContratosMesEvent(event.mes));
  }

  Future<void> _updateContratoMesEvent(
      _UpdateContratoMesEvent event, Emitter<ContratoState> emit) async {
    await ContratoDatabaseServices.db.updateContrato(event.key, event.contrato);
    add(ContratoEvent.getContratosMesEvent(event.contrato.mes!));
  }
}

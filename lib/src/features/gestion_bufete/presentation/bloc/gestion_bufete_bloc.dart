import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/contrato_model.dart';
import '../../domain/entities/contrato.dart';
import '../../domain/usecases/add_contrato_bufete.dart';
import '../../domain/usecases/delete_contrato_bufete.dart';
import '../../domain/usecases/edit_contrato_bufete.dart';
import '../../domain/usecases/get_all_contrato_mes.dart';
import '../../domain/usecases/get_saldo_mes.dart';

part 'gestion_bufete_event.dart';
part 'gestion_bufete_state.dart';

class GestionBufeteBloc extends Bloc<GestionBufeteEvent, GestionBufeteState> {
  final AddContratoBufete _addContratoBufete;
  final DeleteContratoBufete _deleteContratoBufete;
  final EditContratoBufete _editContratoBufete;
  final GetAllContratoMes _getAllContratoMes;
  final GetSaldoMes _getSaldoMes;
  GestionBufeteBloc(
      {required AddContratoBufete addContratoBufete,
      required DeleteContratoBufete deleteContratoBufete,
      required EditContratoBufete editContratoBufete,
      required GetAllContratoMes getAllContratoMes,
      required GetSaldoMes getSaldoMes})
      : _addContratoBufete = addContratoBufete,
        _deleteContratoBufete = deleteContratoBufete,
        _editContratoBufete = editContratoBufete,
        _getAllContratoMes = getAllContratoMes,
        _getSaldoMes = getSaldoMes,
        super(GestionBufeteState.initalState()) {
    on<_GetContratosMesEvent>(_getContratoMesEvent);
    on<_AddContratoMesEvent>(_addContratoMesEvent);
    on<_DeleteContratoMesEvent>(_deleteContratoMesEvent);
    on<_UpdateContratoMesEvent>(_updateContratoMesEvent);
  }

  Future<void> _getContratoMesEvent(
      _GetContratosMesEvent event, Emitter<GestionBufeteState> emit) async {
    emit(state.copyWith(status: ContratoStatus.loading));
    final contratos = await _getAllContratoMes(mes: event.mes);
    final saldo = await _getSaldoMes(mes: event.mes);
    contratos
        .fold((failure) => emit(state.copyWith(status: ContratoStatus.error)),
            (contratos) {
      saldo.fold(
          (failure) => emit(state.copyWith(status: ContratoStatus.error)),
          (saldo) => emit(state.copyWith(
              status: ContratoStatus.success,
              total: saldo,
              contratos: contratos)));
    });
  }

  Future<void> _addContratoMesEvent(
      _AddContratoMesEvent event, Emitter<GestionBufeteState> emit) async {
    final results = await _addContratoBufete(contrato: event.contrato);
    results.fold(
        (failure) => emit(state.copyWith(status: ContratoStatus.error)),
        (correct) =>
            add(GestionBufeteEvent.getContratosMesEvent(event.contrato.mes!)));
  }

  Future<void> _deleteContratoMesEvent(
      _DeleteContratoMesEvent event, Emitter<GestionBufeteState> emit) async {
    final results = await _deleteContratoBufete(key: event.id);
    results.fold(
        (failure) => emit(state.copyWith(status: ContratoStatus.error)),
        (correct) => add(GestionBufeteEvent.getContratosMesEvent(event.mes)));
  }

  Future<void> _updateContratoMesEvent(
      _UpdateContratoMesEvent event, Emitter<GestionBufeteState> emit) async {
    final results =
        await _editContratoBufete(key: event.key, contrato: event.contrato);
    results.fold(
        (failure) => emit(state.copyWith(status: ContratoStatus.error)),
        (correct) =>
            add(GestionBufeteEvent.getContratosMesEvent(event.contrato.mes!)));
  }
}

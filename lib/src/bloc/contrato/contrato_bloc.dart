// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gestion_bufete_app/src/models/contrato.dart';
import 'package:gestion_bufete_app/src/services/db_service.dart';

part 'contrato_event.dart';
part 'contrato_state.dart';

class ContratoBloc extends Bloc<ContratoEvent, ContratoState> {
  ContratoBloc() : super(const ContratoInitial()) {
    on<GetContratosMesEvent>((event, emit) async {
      emit(const ContratoLoadingState());
      final resp = await ContratoDatabaseServices.db.getContratosMes(event.mes);
      emit(ContratoSuccessState(resp['equipos'], resp['total']));
    });
    on<AddContratoMesEvent>(((event, emit) async {
      await ContratoDatabaseServices.db.addContrato(event.contrato);
      add(GetContratosMesEvent(event.contrato.mes!));
    }));
    on<DeleteContratoMesEvent>((event, emit) async {
      await ContratoDatabaseServices.db.deleteContrato(event.id);
      add(GetContratosMesEvent(event.mes));
    });
    on<UpdateContratoMesEvent>(
      (event, emit) async {
        await ContratoDatabaseServices.db
            .updateContrato(event.key, event.contrato);
        add(GetContratosMesEvent(event.contrato.mes!));
      },
    );
  }
}

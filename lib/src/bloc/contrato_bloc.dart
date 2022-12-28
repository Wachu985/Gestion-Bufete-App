import 'dart:async';

import 'package:gestion_bufete_app/src/models/contrato_model.dart';
import 'package:gestion_bufete_app/src/providers/db_provider.dart';

class ContratosBloc {
  static final ContratosBloc _singleton = ContratosBloc._internal();
  String mes = '';

  factory ContratosBloc(String mes) {
    mes = mes;
    return _singleton;
  }
  ContratosBloc._internal() {
    //Obtener los Scans de la Base de Datos
    obtenerContratosMes(mes);
  }

  final _contratoController = StreamController<List<Contrato>?>.broadcast();
  final _contratoSumaController = StreamController<double>.broadcast();

  Stream<List<Contrato>?> get contratoStreams => _contratoController.stream;
  Stream<double> get sumaContratoStreams => _contratoSumaController.stream;

  dispose() {
    _contratoController.close();
    _contratoSumaController.close();
  }

  obtenerContratosMes(String mes) async {
    _contratoController.sink.add(await DBProvider.db.getContratoMes(mes));
    _contratoSumaController.sink.add(await DBProvider.db.sumContratosMes(mes));
  }

  //Agregar Contrato
  agregarContrato(Contrato newContrato) async {
    await DBProvider.db.nuevoContrato(newContrato);
    obtenerContratosMes(mes);
  }

  // Borrar Contrato
  borrarContrato(int id, mes) async {
    await DBProvider.db.deleteContrato(id);
    obtenerContratosMes(mes);
  }

  //Update Contrato
  updateContrato(Contrato newContrato) async {
    await DBProvider.db.updateContrato(newContrato);
    obtenerContratosMes(mes);
  }
}

import '../../../domain/entities/contrato.dart';
import '../../models/contrato_model.dart';

abstract class ContratoBufeteLocalDatasource {
  Future<bool> addContratoBufete(ContratoModel newContrato);
  Future<bool> editContratoBufete(int key, ContratoModel contrato);
  Future<bool> deleteContratoBufete(int key);
  Future<Map<dynamic, Contrato>> getAllContratoMes(String mes);
  Future<double> getSaldoMes(String mes);
}

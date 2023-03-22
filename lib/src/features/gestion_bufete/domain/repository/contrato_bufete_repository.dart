import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/contrato_model.dart';
import '../entities/contrato.dart';

abstract class ContratoBufeteRepository {
  Future<Either<Failure, bool>> addContratoBufete(ContratoModel contrato);
  Future<Either<Failure, bool>> editContratoBufete(
      int key, ContratoModel contrato);
  Future<Either<Failure, bool>> deleteContratoBufete(int key);
  Future<Either<Failure, double>> getSaldoMes(String mes);
  Future<Either<Failure, Map<dynamic, Contrato>>> getAllContratosMes(
      String mes);
}

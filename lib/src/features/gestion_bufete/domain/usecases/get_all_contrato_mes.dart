import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/contrato.dart';
import '../repository/contrato_bufete_repository.dart';

class GetAllContratoMes {
  const GetAllContratoMes({required ContratoBufeteRepository repository})
      : _repository = repository;
  final ContratoBufeteRepository _repository;

  Future<Either<Failure, Map<dynamic, Contrato>>> call(
          {required String mes}) async =>
      await _repository.getAllContratosMes(mes);
}

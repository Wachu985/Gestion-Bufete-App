import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repository/contrato_bufete_repository.dart';

class GetSaldoMes {
  const GetSaldoMes({required ContratoBufeteRepository repository})
      : _repository = repository;
  final ContratoBufeteRepository _repository;

  Future<Either<Failure, double>> call({required String mes}) async =>
      await _repository.getSaldoMes(mes);
}

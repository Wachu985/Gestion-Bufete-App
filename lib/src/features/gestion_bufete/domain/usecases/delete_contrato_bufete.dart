import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../repository/contrato_bufete_repository.dart';

class DeleteContratoBufete {
  const DeleteContratoBufete({required ContratoBufeteRepository repository})
      : _repository = repository;
  final ContratoBufeteRepository _repository;

  Future<Either<Failure, bool>> call({required int key}) async =>
      await _repository.deleteContratoBufete(key);
}

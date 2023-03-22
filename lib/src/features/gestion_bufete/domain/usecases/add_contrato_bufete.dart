import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/contrato_model.dart';
import '../repository/contrato_bufete_repository.dart';

class AddContratoBufete {
  const AddContratoBufete({required ContratoBufeteRepository repository})
      : _repository = repository;
  final ContratoBufeteRepository _repository;

  Future<Either<Failure, bool>> call({required ContratoModel contrato}) async =>
      await _repository.addContratoBufete(contrato);
}

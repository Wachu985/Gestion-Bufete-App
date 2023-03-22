import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/contrato_model.dart';
import '../repository/contrato_bufete_repository.dart';

class EditContratoBufete {
  const EditContratoBufete({required ContratoBufeteRepository repository})
      : _repository = repository;
  final ContratoBufeteRepository _repository;

  Future<Either<Failure, bool>> call(
          {required int key, required ContratoModel contrato}) async =>
      _repository.editContratoBufete(key, contrato);
}

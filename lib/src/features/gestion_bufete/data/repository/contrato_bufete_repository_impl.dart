import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/contrato.dart';
import '../../domain/repository/contrato_bufete_repository.dart';
import '../datasource/local/contrato_bufete_local_datasource.dart';
import '../models/contrato_model.dart';

class ContratoBufeteRepositoryImpl implements ContratoBufeteRepository {
  final ContratoBufeteLocalDatasource _localDatasource;

  ContratoBufeteRepositoryImpl(
      {required ContratoBufeteLocalDatasource localDatasource})
      : _localDatasource = localDatasource;

  @override
  Future<Either<Failure, bool>> addContratoBufete(
      ContratoModel contrato) async {
    try {
      final response = await _localDatasource.addContratoBufete(contrato);
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteContratoBufete(int key) async {
    try {
      final response = await _localDatasource.deleteContratoBufete(key);
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> editContratoBufete(
      int key, ContratoModel contrato) async {
    try {
      final response = await _localDatasource.editContratoBufete(key, contrato);
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, Map<dynamic, Contrato>>> getAllContratosMes(
      String mes) async {
    try {
      final response = await _localDatasource.getAllContratoMes(mes);
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, double>> getSaldoMes(String mes) async {
    try {
      final response = await _localDatasource.getSaldoMes(mes);
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_bufete_app/src/core/errors/exception.dart';
import 'package:gestion_bufete_app/src/core/errors/failures.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/data/datasource/local/contrato_bufete_local_datasource.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/data/models/contrato_model.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/data/repository/contrato_bufete_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ContratoBufeteLocalDatasource])
import 'contrato_bufete_repository_impl_test.mocks.dart';

void main() {
  late MockContratoBufeteLocalDatasource mockContratoBufeteLocalDatasource;
  late ContratoBufeteRepositoryImpl repository;

  setUp(() {
    mockContratoBufeteLocalDatasource = MockContratoBufeteLocalDatasource();
    repository = ContratoBufeteRepositoryImpl(
        localDatasource: mockContratoBufeteLocalDatasource);
  });

  group('addContratoBufete', () {
    const tBool = true;
    const tContratoModel = ContratoModel(
        id: 1, mes: 'Enero', nombre: 'Pinocho', numero: '50', precio: 678.49);
    test('Comprobando que se agrega correctamente', () async {
      when(mockContratoBufeteLocalDatasource.addContratoBufete(any))
          .thenAnswer((_) async => tBool);
      final results = await repository.addContratoBufete(tContratoModel);
      verify(
          mockContratoBufeteLocalDatasource.addContratoBufete(tContratoModel));
      expect(results, equals(const Right(tBool)));
    });
    test('Comprobando que se Propaga el Error', () async {
      when(mockContratoBufeteLocalDatasource.addContratoBufete(any))
          .thenThrow(CacheException());
      final result = await repository.addContratoBufete(tContratoModel);
      expect(result, equals(Left(CacheFailure())));
    });
  });

  group('deleteContratoBufete', () {
    const tBool = true;
    const tKey = 1;

    test('Comprobando que se elimina correctamente', () async {
      when(mockContratoBufeteLocalDatasource.deleteContratoBufete(any))
          .thenAnswer((_) async => tBool);
      final results = await repository.deleteContratoBufete(tKey);
      verify(mockContratoBufeteLocalDatasource.deleteContratoBufete(tKey));
      expect(results, equals(const Right(tBool)));
    });
    test('Comprobando que se Propaga el Error', () async {
      when(mockContratoBufeteLocalDatasource.deleteContratoBufete(any))
          .thenThrow(CacheException());
      final result = await repository.deleteContratoBufete(tKey);
      expect(result, equals(Left(CacheFailure())));
    });
  });
  group('editContratoBufete', () {
    const tBool = true;
    const tKey = 1;
    const tContratoModel = ContratoModel(
        id: 1, mes: 'Enero', nombre: 'Pinocho', numero: '50', precio: 678.49);

    test('Comprobando que se edita correctamente', () async {
      when(mockContratoBufeteLocalDatasource.editContratoBufete(any, any))
          .thenAnswer((_) async => tBool);
      final results = await repository.editContratoBufete(tKey, tContratoModel);
      verify(mockContratoBufeteLocalDatasource.editContratoBufete(
          tKey, tContratoModel));
      expect(results, equals(const Right(tBool)));
    });
    test('Comprobando que se Propaga el Error', () async {
      when(mockContratoBufeteLocalDatasource.editContratoBufete(any, any))
          .thenThrow(CacheException());
      final result = await repository.editContratoBufete(tKey, tContratoModel);
      expect(result, equals(Left(CacheFailure())));
    });
  });
  group('getAllContratosMes', () {
    const String tMes = 'Enero';
    const tContratoModel = ContratoModel(
        id: 1, mes: 'Enero', nombre: 'Pinocho', numero: '50', precio: 678.49);
    final Map<dynamic, ContratoModel> tListContrato = {1: tContratoModel};

    test('Comprobando que se obtienen correctamente', () async {
      when(mockContratoBufeteLocalDatasource.getAllContratoMes(any))
          .thenAnswer((_) async => tListContrato);
      final results = await repository.getAllContratosMes(tMes);
      verify(mockContratoBufeteLocalDatasource.getAllContratoMes(tMes));
      expect(results, equals(Right(tListContrato)));
    });
    test('Comprobando que se Propaga el Error', () async {
      when(mockContratoBufeteLocalDatasource.getAllContratoMes(any))
          .thenThrow(CacheException());
      final result = await repository.getAllContratosMes(tMes);
      expect(result, equals(Left(CacheFailure())));
    });
  });
  group('getSaldoMes', () {
    const String tMes = 'Enero';
    const tSaldo = 500.0;

    test('Comprobando que se obtienen correctamente', () async {
      when(mockContratoBufeteLocalDatasource.getSaldoMes(any))
          .thenAnswer((_) async => tSaldo);
      final results = await repository.getSaldoMes(tMes);
      verify(mockContratoBufeteLocalDatasource.getSaldoMes(tMes));
      expect(results, equals(const Right(tSaldo)));
    });
    test('Comprobando que se Propaga el Error', () async {
      when(mockContratoBufeteLocalDatasource.getSaldoMes(any))
          .thenThrow(CacheException());
      final result = await repository.getSaldoMes(tMes);
      expect(result, equals(Left(CacheFailure())));
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_bufete_app/src/core/errors/exception.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/data/datasource/local/contrato_bufete_local_datasource_impl.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/data/models/contrato_model.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([Box])
import 'contrato_bufete_local_datasource_impl_test.mocks.dart';

void main() {
  late MockBox mocksBox;
  late ContratoBufeteLocalDatasourceImpl localDatasource;

  setUp(() {
    mocksBox = MockBox();
    localDatasource = ContratoBufeteLocalDatasourceImpl(hiveBox: mocksBox);
  });
  group('addContratoBufete', () {
    const ContratoModel tContratoModel = ContratoModel(
        id: 1, mes: 'Enero', nombre: 'Pinocho', numero: '50', precio: 678.49);
    test('Comprobando que agrega Correctamente', () async {
      bool tbool = true;
      when(mocksBox.add(any)).thenAnswer((_) async => 1);
      final results = await localDatasource.addContratoBufete(tContratoModel);
      verifyNever(mocksBox.add(tContratoModel));
      expect(results, tbool);
    });
    test('Comprobando que ejecuta el error', () async {
      when(mocksBox.add(any)).thenAnswer((_) async => 2);
      final call = localDatasource.addContratoBufete;
      expect(() => call(tContratoModel),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('deleteContratoBufete', () {
    const bool tBool = true;
    const int tKey = 1;
    test('Comprobando que se elimina Correctamente', () async {
      when(mocksBox.delete(any)).thenAnswer((_) async => 1);
      final results = await localDatasource.deleteContratoBufete(tKey);
      verify(mocksBox.delete(tKey));
      expect(results, tBool);
    });
    test('Comprobando que se Ejecuta el Throw', () {
      when(mocksBox.delete(any)).thenAnswer((_) async => any);
      final call = localDatasource.deleteContratoBufete;
      expect(() => call(tKey), throwsA(const TypeMatcher<CacheException>()));
    });
  });
  group('editContratoBufete', () {
    const bool tBool = true;
    const int tKey = 1;
    const ContratoModel tContratoModel = ContratoModel(
        id: 1, mes: 'Enero', nombre: 'Pinocho', numero: '50', precio: 678.49);
    test('Comprobando que se edita Correctamente', () async {
      when(mocksBox.put(any, any)).thenAnswer((_) async => 1);
      final results =
          await localDatasource.editContratoBufete(tKey, tContratoModel);
      verifyNever(mocksBox.put(tKey, tContratoModel));
      expect(results, tBool);
    });
    test('Comprobando que se Ejecuta el Throw', () {
      when(mocksBox.put(any, any)).thenAnswer((_) async => any);
      final call = localDatasource.editContratoBufete;
      expect(() => call(tKey, tContratoModel),
          throwsA(const TypeMatcher<CacheException>()));
    });
  });
  group('getAllContratoMes', () {
    const String tMes = 'Enero';
    const tContrato = ContratoModel(
        id: 1, mes: 'Enero', nombre: 'Pinocho', numero: '50', precio: 678.49);
    final Map<dynamic, dynamic> tListContrato = {1: tContrato.toJson()};

    test('Comprobando que se edita Correctamente', () async {
      when(mocksBox.toMap()).thenAnswer((_) => tListContrato);
      final results = await localDatasource.getAllContratoMes(tMes);
      verify(mocksBox.toMap());
      expect(results, {1: tContrato});
    });
    test('Comprobando que se Ejecuta el Throw', () {
      when(mocksBox.toMap()).thenThrow((_) => throw Exception());
      final call = localDatasource.getAllContratoMes;
      expect(() => call(tMes), throwsA(const TypeMatcher<CacheException>()));
    });
  });
  group('getSaldoMes', () {
    const String tMes = 'Enero';
    const tContrato = ContratoModel(
        id: 1, mes: 'Enero', nombre: 'Pinocho', numero: '50', precio: 678.49);
    final Map<dynamic, dynamic> tListContrato = {1: tContrato.toJson()};

    test('Comprobando que se edita Correctamente', () async {
      when(mocksBox.toMap()).thenAnswer((_) => tListContrato);
      final results = await localDatasource.getSaldoMes(tMes);
      verify(mocksBox.toMap());
      expect(results, 678.49);
    });
    test('Comprobando que se Ejecuta el Throw', () {
      when(mocksBox.toMap()).thenThrow((_) => throw Exception());
      final call = localDatasource.getSaldoMes;
      expect(() => call(tMes), throwsA(const TypeMatcher<CacheException>()));
    });
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/data/models/contrato_model.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/entities/contrato.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const ContratoModel tContratoModel = ContratoModel(
      id: 1, mes: 'Enero', nombre: 'Pinocho', numero: '50', precio: 678.49);

  test('Comprobar que ContratoModel es extiende  de Contrato', () {
    expect(tContratoModel, isA<Contrato>());
  });

  group('fromJson', () {
    test('Comprobando la conversion correctamente', () {
      const tContratoModel = ContratoModel(
          id: 1, mes: 'Enero', nombre: 'Pinocho', numero: '50', precio: 678.49);
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixtures('contrato.json'));
      final results = ContratoModel.fromJson(jsonMap);
      expect(results, tContratoModel);
    });
  });

  group('toJson', () {
    test('Comprobando la conversion correctamente', () {
      Map<String, dynamic> jsonMap = jsonDecode(fixtures('contrato.json'));
      const tContratoModel = ContratoModel(
          id: 1, mes: 'Enero', nombre: 'Pinocho', numero: '50', precio: 678.49);
      final results = tContratoModel.toJson();

      expect(results, jsonMap);
    });
  });
}

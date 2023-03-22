// import 'package:gestion_bufete_app/src_clean/core/errors/exception.dart';
// import 'package:gestion_bufete_app/src_clean/features/gestion_bufete/data/datasource/local/contrato_bufete_local_datasource.dart';
// import 'package:gestion_bufete_app/src_clean/features/gestion_bufete/data/models/contrato_model.dart';
// import 'package:gestion_bufete_app/src_clean/features/gestion_bufete/domain/entities/contrato.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../../../core/errors/exception.dart';
import '../../../domain/entities/contrato.dart';
import '../../models/contrato_model.dart';
import 'contrato_bufete_local_datasource.dart';

class ContratoBufeteLocalDatasourceImpl
    implements ContratoBufeteLocalDatasource {
  final Box _hiveBox;

  ContratoBufeteLocalDatasourceImpl({required Box hiveBox})
      : _hiveBox = hiveBox;

  @override
  Future<bool> addContratoBufete(ContratoModel newContrato) async {
    try {
      await _hiveBox.add(newContrato.toJson());

      return true;
    } catch (ex) {
      throw CacheException();
    }
  }

  @override
  Future<bool> deleteContratoBufete(int key) async {
    try {
      await _hiveBox.delete(key);
      return true;
    } catch (ex) {
      throw CacheException();
    }
  }

  @override
  Future<bool> editContratoBufete(int key, ContratoModel contrato) async {
    try {
      await _hiveBox.put(key, contrato.toJson());
      return true;
    } catch (ex) {
      throw CacheException();
    }
  }

  @override
  Future<Map<dynamic, Contrato>> getAllContratoMes(String mes) async {
    try {
      Map<dynamic, Contrato> listContrato = {};
      final resp = _hiveBox.toMap();
      resp.forEach((key, value) {
        final contrato = ContratoModel.fromJson(value);
        if (contrato.mes == mes) {
          listContrato[key] = contrato;
        }
      });
      return listContrato;
    } catch (ex) {
      throw CacheException();
    }
  }

  @override
  Future<double> getSaldoMes(String mes) async {
    try {
      double saldo = 0.0;
      final resp = _hiveBox.toMap();
      resp.forEach((key, value) {
        final contrato = ContratoModel.fromJson(value);
        if (contrato.mes == mes) {
          saldo += contrato.precio!;
        }
      });
      return saldo;
    } catch (ex) {
      throw CacheException();
    }
  }
}

import 'dart:io';

import 'package:gestion_bufete_app/src/models/contrato_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._private();

  DBProvider._private();
  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'ScanDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Contratos (id INTEGER PRIMARY KEY,mes TEXT,numero TEXT,nombre TEXT,precio FLOAT)');
    });
  }

  //Agregar Contrato
  nuevoContrato(Contrato newContrato) async {
    final db = await database;
    final res = await db!.insert('Contratos', newContrato.toJson());
    return res;
  }

  //Buscar Contratos por Mes
  Future<List<Contrato>?> getContratoMes(String mes) async {
    final db = await database;
    final res = await db!.query('Contratos', where: 'mes=?', whereArgs: [mes]);
    List<Contrato>? list = res.isNotEmpty
        ? res.map((contrato) => Contrato.fromJson(contrato)).toList()
        : [];
    return list;
  }

  Future<List<Contrato>?> getContratosAll() async {
    final db = await database;
    final res = await db!.query('Contrato');
    List<Contrato>? list = res.isNotEmpty
        ? res.map((contrato) => Contrato.fromJson(contrato)).toList()
        : [];
    return list;
  }

  //Sumar Total de Contratos del mes
  Future<double> sumContratosMes(String mes) async {
    final db = await database;
    final res = await db!.query('Contratos', where: 'mes=?', whereArgs: [mes]);
    List<Contrato>? list = res.isNotEmpty
        ? res.map((contrato) => Contrato.fromJson(contrato)).toList()
        : [];
    double total = 0;
    if (list.isNotEmpty) {
      for (var contrato in list) {
        total += contrato.precio!;
      }
    }
    return total;
  }

  //Update Contrato
  Future<int> updateContrato(Contrato nuevoContrato) async {
    final db = await database;
    final res = await db!.update("Contratos", nuevoContrato.toJson(),
        where: 'id=?', whereArgs: [nuevoContrato.id]);
    return res;
  }

  //Eliminar Contrato
  Future<int> deleteContrato(int id) async {
    final db = await database;
    final res = db!.delete('Contratos', where: 'id=?', whereArgs: [id]);
    return res;
  }
}

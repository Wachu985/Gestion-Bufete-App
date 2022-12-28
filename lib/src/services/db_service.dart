import 'dart:io';

import 'package:gestion_bufete_app/src/models/contrato.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

// Operaciones Crud
class ContratoDatabaseServices {
  static final ContratoDatabaseServices db =
      ContratoDatabaseServices._private();
  static Box? _contratoBox;
  // Usando el Patron Singlenton
  ContratoDatabaseServices._private();

  Future<Box?> get contratoBox async {
    if (_contratoBox != null) return _contratoBox;
    await checkDatabaseExists();
    return _contratoBox;
  }

  Future<void> checkDatabaseExists() async {
    Directory databaseDir =
        await getApplicationSupportDirectory(); //Initialise the database
    Hive.init(databaseDir.path);
    if (await Hive.boxExists('contratoBox')) {
      Hive.registerAdapter(ContratoAdapter());
      _contratoBox = await Hive.openBox('contratoBox');
    } else {
      await createDatabase();
    }
  }

  Future<void> createDatabase() async {
    Directory databaseDir = await getApplicationSupportDirectory();
    Hive.init(databaseDir.path);
    Hive.registerAdapter(ContratoAdapter());
    _contratoBox = await Hive.openBox('contratoBox');
  }

  Future addContrato(Contrato newContrato) async {
    await _contratoBox!.add(newContrato);
  }

  Future getContratosMes(String mes) async {
    final resp = _contratoBox!.toMap();
    Map<dynamic, Contrato> equipos = {};
    double total = 0.0;
    resp.forEach((key, value) {
      value as Contrato;
      if (value.mes == mes) {
        equipos[key] = value;
        total += value.precio!;
      }
    });
    return {'equipos': equipos, 'total': total};
  }

  Future deleteContrato(int id) async {
    await _contratoBox!.delete(id);
  }

  Future updateContrato(int key, Contrato newContrato) async {
    await _contratoBox!.put(key, newContrato);
  }
}

import 'package:gestion_bufete_app/src/features/gestion_bufete/data/datasource/local/contrato_bufete_local_datasource.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/data/datasource/local/contrato_bufete_local_datasource_impl.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/data/repository/contrato_bufete_repository_impl.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/repository/contrato_bufete_repository.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/usecases/add_contrato_bufete.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/usecases/delete_contrato_bufete.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/usecases/edit_contrato_bufete.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/usecases/get_all_contrato_mes.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/domain/usecases/get_saldo_mes.dart';
import 'package:gestion_bufete_app/src/features/gestion_bufete/presentation/bloc/gestion_bufete_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(() => GestionBufeteBloc(
      addContratoBufete: sl(),
      deleteContratoBufete: sl(),
      editContratoBufete: sl(),
      getAllContratoMes: sl(),
      getSaldoMes: sl()));

  // UsesCases
  sl.registerLazySingleton(() => AddContratoBufete(repository: sl()));
  sl.registerLazySingleton(() => DeleteContratoBufete(repository: sl()));
  sl.registerLazySingleton(() => EditContratoBufete(repository: sl()));
  sl.registerLazySingleton(() => GetAllContratoMes(repository: sl()));
  sl.registerLazySingleton(() => GetSaldoMes(repository: sl()));

  // Reposptory
  sl.registerLazySingleton<ContratoBufeteRepository>(
      () => ContratoBufeteRepositoryImpl(localDatasource: sl()));

  // Datasurce
  sl.registerLazySingleton<ContratoBufeteLocalDatasource>(
      () => ContratoBufeteLocalDatasourceImpl(hiveBox: sl()));

  await Hive.initFlutter();
  final box = await Hive.openBox('contratos');
  // External
  sl.registerLazySingleton(() => box);
}

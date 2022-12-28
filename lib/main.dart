import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gestion_bufete_app/src/bloc/contrato/contrato_bloc.dart';
import 'package:gestion_bufete_app/src/screens/home_screen.dart';
import 'package:gestion_bufete_app/src/services/db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ContratoDatabaseServices.db.contratoBox;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ContratoBloc(),
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestion Bufete',
        home: HomeScreen(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/gestion_bufete_bloc.dart';
import '../widgets/fondo_app.dart';
import 'add_contrato_screen.dart';
import 'home_screen.dart';

class MesScreen extends StatelessWidget {
  const MesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mes = ModalRoute.of(context)!.settings.arguments as String;
    BlocProvider.of<GestionBufeteBloc>(context)
        .add(GestionBufeteEvent.getContratosMesEvent(mes));
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: mes,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddContratoScreen(),
                  settings: RouteSettings(arguments: {'mes': mes})));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          const FondoApp(),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                _TitleBar(mes: mes),
                _ListadoContratos(mes: mes),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ListadoContratos extends StatelessWidget {
  const _ListadoContratos({
    Key? key,
    required this.mes,
  }) : super(key: key);

  final String mes;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GestionBufeteBloc, GestionBufeteState>(
      builder: (context, state) {
        if (state.status == ContratoStatus.success) {
          final contratos = state.contratos;
          if (contratos.isEmpty) {
            return const Center(
              child: Text(
                'No Hay Información',
                style: TextStyle(fontSize: 20.0),
              ),
            );
          }
          List<Widget> colums = <Widget>[];
          contratos.forEach((key, value) {
            colums.add(Dismissible(
              key: UniqueKey(),
              confirmDismiss: (direction) async {
                bool isDelete = false;
                if (direction == DismissDirection.endToStart) {
                  await showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          title: const Text('Confirmacion'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                '¿Está Seguro de Eliminar este Contrato?',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                isDelete = false;
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                isDelete = true;
                                Navigator.of(context).pop();
                              },
                              child: const Text('Ok'),
                            )
                          ],
                        );
                      });
                }
                return isDelete;
              },
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  BlocProvider.of<GestionBufeteBloc>(context)
                      .add(GestionBufeteEvent.deleteContratoMesEvent(key, mes));
                }
              },
              background: Container(
                alignment: Alignment.centerRight,
                color: Colors.red,
                child: const Icon(
                  Icons.delete_sweep_rounded,
                  color: Colors.white,
                ),
              ),
              child: Container(
                color: const Color.fromRGBO(255, 255, 255, 0.7),
                child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddContratoScreen(),
                              settings: RouteSettings(arguments: {
                                'mes': mes,
                                'contrato': value,
                                'key': key
                              })));
                    },
                    leading: Icon(Icons.document_scanner,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      value.nombre!,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                    subtitle: Text('Codigo: ${value.numero}'),
                    trailing: Text('${value.precio} \$')),
              ),
            ));
          });
          return Column(
            children: colums,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class _TitleBar extends StatelessWidget {
  const _TitleBar({
    Key? key,
    required this.mes,
  }) : super(key: key);

  final String mes;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GestionBufeteBloc, GestionBufeteState>(
      builder: (context, state) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      mes,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold),
                    ),
                    FloatingActionButton(
                      heroTag: 2,
                      elevation: 0.0,
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.0),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ));
                      },
                      child: const Icon(Icons.arrow_back_sharp),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 7.0,
                ),
                Text(
                  "${state.total} \$",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gestion_bufete_app/src/bloc/contrato_bloc.dart';
import 'package:gestion_bufete_app/src/models/contrato_model.dart';
import 'package:gestion_bufete_app/src/pages/add_contrato_page.dart';
import 'package:gestion_bufete_app/src/pages/home_page.dart';
import 'package:gestion_bufete_app/src/pages/update_contrato_page.dart';

class MesPage extends StatelessWidget {
  const MesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mes = ModalRoute.of(context)!.settings.arguments as String;
    final contratoBloc = ContratosBloc(mes);
    contratoBloc.obtenerContratosMes(mes);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: mes,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddContrato(),
                  settings: RouteSettings(arguments: mes)));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
        children: [
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: [
                _titulos(mes, context, contratoBloc),
                _listadodeContratos(contratoBloc, mes),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _fondoApp() {
    final gradiente = Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.6),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Color.fromRGBO(52, 54, 101, 1.0),
            Color.fromRGBO(35, 37, 57, 1.0)
          ])),
    );

    final cajaRosa = Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        height: 360.0,
        width: 360.0,
        decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(236, 98, 188, 1.0),
              Color.fromRGBO(241, 142, 172, 1.0)
            ]),
            borderRadius: BorderRadius.circular(90.0)),
      ),
    );

    return Stack(
      children: [gradiente, Positioned(top: -100, child: cajaRosa)],
    );
  }

  Widget _titulos(
      String mes, BuildContext context, ContratosBloc contratoBloc) {
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
                          builder: (context) => const HomePage(),
                        ));
                  },
                  child: const Icon(Icons.arrow_back_sharp),
                ),
              ],
            ),
            const SizedBox(
              height: 7.0,
            ),
            StreamBuilder(
                stream: contratoBloc.sumaContratoStreams,
                builder:
                    (BuildContext context, AsyncSnapshot<double> snapshot) {
                  if (!snapshot.hasData) {
                    return const Text(
                      "0.0 \$",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    );
                  }
                  double valor = snapshot.data!;
                  if (valor == null) {
                    valor = 0;
                  }
                  return Text(
                    "$valor \$",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  _listadodeContratos(ContratosBloc contratoBloc, String mes) {
    return StreamBuilder(
        stream: contratoBloc.contratoStreams,
        builder:
            (BuildContext context, AsyncSnapshot<List<Contrato>?> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final contratos = snapshot.data;
          var len = contratos?.length ?? 0;
          if (len == 0) {
            return const Center(
              child: Text(
                'No Hay Información',
                style: TextStyle(fontSize: 20.0),
              ),
            );
          }
          List<Widget> rows = <Widget>[];
          for (var contrato in contratos!) {
            rows.add(Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) =>
                  {contratoBloc.borrarContrato(contrato.id!, mes)},
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
                      // Navigator.pushNamed(context, UpdateContratoPage.routeName,
                      //     arguments: {'mes': mes, 'contrato': contrato});
                    },
                    leading: Icon(Icons.document_scanner,
                        color: Theme.of(context).primaryColor),
                    title: Text(
                      contrato.nombre!,
                      style: const TextStyle(fontSize: 20.0),
                    ),
                    subtitle: Text('Codigo: ${contrato.numero}'),
                    trailing: Text('${contrato.precio} \$')),
              ),
            ));
          }
          return Column(
            children: rows,
          );
        });
  }
}

import 'package:flutter/material.dart';
import 'package:gestion_bufete_app/src/pages/mes_page.dart';
import 'dart:math';

import '../bloc/contrato_bloc.dart';
import '../models/contrato_model.dart';

class UpdateContratoPage extends StatefulWidget {
  const UpdateContratoPage({super.key});

  @override
  State<UpdateContratoPage> createState() => _UpdateContratoPage();
}

class _UpdateContratoPage extends State<UpdateContratoPage> {
  String _codigo = '';
  TextEditingController? codigo;

  String _nombre = '';
  TextEditingController? nombre;

  double _valor = 0;
  TextEditingController? valor;

  Contrato? contrato;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final mes = arguments['mes'];
    contrato = arguments['contrato'];
    _codigo = contrato!.numero!;
    codigo = TextEditingController(text: _codigo);
    _nombre = contrato!.nombre!;
    nombre = TextEditingController(text: _nombre);
    _valor = contrato!.precio!;
    valor = TextEditingController(text: _valor.toString());
    final contratoBloc = ContratosBloc(mes);
    contratoBloc.obtenerContratosMes(mes);
    return Scaffold(
      body: Stack(
        children: [
          _fondoApp(),
          SingleChildScrollView(
            child: Column(
              children: [
                _titulos(mes, context),
                _formsContratos(mes, context, contratoBloc),
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

  Widget _titulos(String mes, BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                FloatingActionButton(
                  heroTag: 2,
                  elevation: 0.0,
                  backgroundColor: const Color.fromRGBO(255, 255, 255, 0.0),
                  onPressed: () {
                    // Navigator.pushNamed(context, MesPage.routeName,
                    //     arguments: mes);
                  },
                  child: const Icon(Icons.arrow_back_sharp),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: Container()),
                const Text(
                  'Actualizar Contrato',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(
              height: 7.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget _formsContratos(
      String mes, BuildContext context, ContratosBloc contratoBloc) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      width: size.width * 0.90,
      height: (size.height < 450.0) ? size.height : size.height * 0.70,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.8),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0.5, 5.0), color: Colors.black, blurRadius: 10.0)
        ],
        shape: BoxShape.rectangle,
      ),
      child: Column(
        children: [
          const Text(
            'Inserte los Datos',
            style: TextStyle(fontSize: 25.0),
          ),
          const SizedBox(
            height: 40.0,
          ),
          TextField(
            controller: codigo,
            autofocus: false,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'Código del Contrato',
              labelText: 'Código',
              suffixIcon: const Icon(Icons.format_list_numbered),
              icon: const Icon(Icons.numbers),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            onChanged: (valor) {
              _codigo = valor;
            },
          ),
          const SizedBox(
            height: 40.0,
          ),
          TextField(
            controller: nombre,
            autofocus: false,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'Nombre de la Persona',
              labelText: 'Nombre',
              suffixIcon: const Icon(Icons.accessibility),
              icon: const Icon(Icons.account_circle),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            onChanged: (valor) {
              _nombre = valor;
            },
          ),
          const SizedBox(
            height: 40.0,
          ),
          TextField(
            controller: valor,
            autofocus: false,
            keyboardType: TextInputType.number,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'Valor del Contrato',
              labelText: 'Valor',
              suffixIcon: const Icon(Icons.done_all_sharp),
              icon: const Icon(Icons.monetization_on),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
            ),
            onChanged: (valor) {
              _valor = (valor != '') ? double.parse(valor) : 0;
            },
          ),
          Expanded(child: Container()),
          Hero(
            tag: mes,
            child: ElevatedButton(
              onPressed: () => _guardarValores(
                mes,
                context,
                contratoBloc,
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)))),
                elevation: MaterialStateProperty.all(10.0),
              ),
              child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 30.0),
                  child: const Text(
                    'Guardar Datos',
                    style: TextStyle(fontSize: 20.0),
                  )),
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  _guardarValores(
      String mes, BuildContext context, ContratosBloc contratoBloc) {
    contrato!.mes = mes;
    contrato!.nombre = _nombre;
    contrato!.numero = _codigo;
    contrato!.precio = _valor;

    contratoBloc.updateContrato(contrato!);
    // Navigator.pushNamed(context, MesPage.routeName, arguments: mes);
  }
}

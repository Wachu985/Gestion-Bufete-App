import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/contrato_model.dart';
import '../bloc/gestion_bufete_bloc.dart';
import '../widgets/fondo_app.dart';
import 'mes_screen.dart';

class AddContratoScreen extends StatefulWidget {
  const AddContratoScreen({super.key});

  @override
  State<AddContratoScreen> createState() => _AddContratoState();
}

class _AddContratoState extends State<AddContratoScreen> {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final mes = arguments['mes'];
    final ContratoModel contrato = arguments['contrato'] ??
        const ContratoModel(mes: '', nombre: '', numero: '', precio: 0);
    final int? key = arguments['key'];
    return Scaffold(
      body: Stack(
        children: [
          const FondoApp(),
          SingleChildScrollView(
            child: Column(
              children: [
                _Titulos(mes: mes, context: context),
                _ContratosForm(
                  mes: mes,
                  newContrato: contrato,
                  keyContrat: key,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Titulos extends StatelessWidget {
  const _Titulos({
    Key? key,
    required this.mes,
    required this.context,
  }) : super(key: key);

  final String mes;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MesScreen(),
                            settings: RouteSettings(arguments: mes)));
                  },
                  child: const Icon(Icons.arrow_back_sharp),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(child: Container()),
                const Text(
                  'Agregar Contrato al Mes',
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
}

// ignore: must_be_immutable
class _ContratosForm extends StatelessWidget {
  String codigo = '';
  String nombre = '';
  double valor = 0;
  ContratoModel newContrato;
  int? keyContrat;
  final String mes;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  _ContratosForm(
      {required this.mes, required this.newContrato, required this.keyContrat});

  @override
  Widget build(BuildContext context) {
    codigo = newContrato.numero ?? '';
    nombre = newContrato.nombre ?? '';
    valor = newContrato.precio ?? 0;
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      width: size.width * 0.90,
      height: 500.0,
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
            'Introduzca los Datos',
            style: TextStyle(fontSize: 25.0),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Este Campo no Puede Estar Vacio';
                    } else if (value == '') {
                      return 'Este Campo no Puede Estar Vacio';
                    } else if (value.isEmpty) {
                      return 'Este Campo no Puede Estar Vacio';
                    }
                    return null;
                  },
                  autofocus: false,
                  initialValue: newContrato.numero ?? '',
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    hintText: 'Código del Contrato',
                    labelText: 'Código',
                    suffixIcon: const Icon(Icons.format_list_numbered),
                    icon: const Icon(Icons.numbers),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onChanged: (valor) {
                    codigo = valor;
                  },
                ),
                const SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Este Campo no Puede Estar Vacio';
                    } else if (value == '') {
                      return 'Este Campo no Puede Estar Vacio';
                    } else if (value.isEmpty) {
                      return 'Este Campo no Puede Estar Vacio';
                    }
                    return null;
                  },
                  autofocus: false,
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  initialValue: newContrato.nombre ?? '',
                  decoration: InputDecoration(
                    hintText: 'Nombre de la Persona',
                    labelText: 'Nombre',
                    suffixIcon: const Icon(Icons.accessibility),
                    icon: const Icon(Icons.account_circle),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onChanged: (valor) {
                    nombre = valor;
                  },
                ),
                const SizedBox(
                  height: 40.0,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null) {
                      return 'Este Campo no Puede Estar Vacio';
                    } else if (value == '') {
                      return 'Este Campo no Puede Estar Vacio';
                    } else if (value.isEmpty) {
                      return 'Este Campo no Puede Estar Vacio';
                    }
                    return null;
                  },
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  initialValue: newContrato.precio.toString(),
                  textInputAction: TextInputAction.newline,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: 'Valor del Contrato',
                    labelText: 'Valor',
                    suffixIcon: const Icon(Icons.done_all_sharp),
                    icon: const Icon(Icons.monetization_on),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                  onChanged: (valor) {
                    this.valor = (valor != '') ? double.parse(valor) : 0;
                  },
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          Hero(
            tag: mes,
            child: ElevatedButton(
              onPressed: () {
                _guardarValores(
                  mes,
                  context,
                );
              },
              style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  elevation: 10),
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

  _guardarValores(String mes, BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (keyContrat != null) {
        newContrato.copyWith(
            mes1: mes, nombre1: nombre, numero1: codigo, precio1: valor);

        BlocProvider.of<GestionBufeteBloc>(context).add(
            GestionBufeteEvent.updateContratoMesEvent(
                keyContrat!, newContrato));
      } else {
        newContrato = ContratoModel(
            mes: mes, nombre: nombre, numero: codigo, precio: valor);

        BlocProvider.of<GestionBufeteBloc>(context)
            .add(GestionBufeteEvent.addContratoMesEvent(newContrato));
      }
      Navigator.pop(context);
    }
  }
}

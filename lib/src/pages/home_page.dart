import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gestion_bufete_app/src/pages/mes_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _FondoApp(),
          SingleChildScrollView(
            child: Column(
              children: const [_Titulos(), _TableButtoms()],
            ),
          )
        ],
      ),
    );
  }
}

class _FondoApp extends StatelessWidget {
  const _FondoApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}

class _Titulos extends StatelessWidget {
  const _Titulos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Gestion de Contratos',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 7.0,
            ),
            Text(
              'Gestion de Contratos por Meses',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _TableButtoms extends StatelessWidget {
  const _TableButtoms({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: const [
        TableRow(
          children: [
            _BotonesRedondeados(
              color: Colors.blueAccent,
              icono: Icons.brunch_dining,
              text: 'Enero',
            ),
            _BotonesRedondeados(
              color: Colors.redAccent,
              icono: Icons.favorite,
              text: 'Febrero',
            )
          ],
        ),
        TableRow(
          children: [
            _BotonesRedondeados(
              color: Colors.green,
              icono: Icons.filter_vintage,
              text: 'Marzo',
            ),
            _BotonesRedondeados(
              color: Colors.purpleAccent,
              icono: Icons.cruelty_free,
              text: 'Abril',
            )
          ],
        ),
        TableRow(
          children: [
            _BotonesRedondeados(
              color: Colors.blue,
              icono: Icons.cloudy_snowing,
              text: 'Mayo',
            ),
            _BotonesRedondeados(
              color: Colors.green,
              icono: Icons.attractions,
              text: 'Junio',
            )
          ],
        ),
        TableRow(
          children: [
            _BotonesRedondeados(
              color: Colors.pinkAccent,
              icono: Icons.camera_alt,
              text: 'Julio',
            ),
            _BotonesRedondeados(
              color: Colors.orange,
              icono: Icons.beach_access,
              text: 'Agosto',
            )
          ],
        ),
        TableRow(
          children: [
            _BotonesRedondeados(
              color: Colors.purpleAccent,
              icono: Icons.balance,
              text: 'Septiembre',
            ),
            _BotonesRedondeados(
              color: Colors.green,
              icono: Icons.eco,
              text: 'Octubre',
            )
          ],
        ),
        TableRow(
          children: [
            _BotonesRedondeados(
              color: Colors.red,
              icono: Icons.chalet,
              text: 'Noviembre',
            ),
            _BotonesRedondeados(
              color: Colors.blue,
              icono: Icons.celebration,
              text: 'Diciembre',
            )
          ],
        ),
      ],
    );
  }
}

class _BotonesRedondeados extends StatelessWidget {
  const _BotonesRedondeados({
    Key? key,
    required this.color,
    required this.icono,
    required this.text,
  }) : super(key: key);

  final Color color;
  final IconData icono;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const MesPage(),
                settings: RouteSettings(arguments: text)));
      },
      child: Container(
        height: 180.0,
        margin: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(62, 66, 107, 0.7),
            borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: text,
              child: CircleAvatar(
                backgroundColor: color,
                radius: 35.0,
                child: Icon(
                  icono,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              text,
              style: TextStyle(color: color, fontSize: 18.0),
            ),
          ],
        ),
      ),
    );
  }
}

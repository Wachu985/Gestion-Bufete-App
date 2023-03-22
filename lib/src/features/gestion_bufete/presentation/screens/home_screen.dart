import 'package:flutter/material.dart';

import '../widgets/fondo_app.dart';
import 'mes_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const FondoApp(),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: const [_Titulos(), _TableButtoms()],
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
                builder: (context) => const MesScreen(),
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

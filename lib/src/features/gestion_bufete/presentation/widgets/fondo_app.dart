import 'dart:math';

import 'package:flutter/material.dart';

class FondoApp extends StatelessWidget {
  const FondoApp({
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

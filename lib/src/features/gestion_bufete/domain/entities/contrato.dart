import 'package:equatable/equatable.dart';

class Contrato extends Equatable {
  final int? id;
  final String? mes;
  final String? numero;
  final String? nombre;
  final double? precio;

  const Contrato({this.id, this.mes, this.nombre, this.numero, this.precio});

  @override
  List<Object?> get props => [id, mes, numero, nombre, precio];
}

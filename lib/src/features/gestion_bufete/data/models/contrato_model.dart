import '../../domain/entities/contrato.dart';

class ContratoModel extends Contrato {
  const ContratoModel(
      {int? id,
      required String mes,
      required String nombre,
      required String numero,
      required double precio})
      : super(id: id, mes: mes, nombre: nombre, numero: numero, precio: precio);

  factory ContratoModel.fromJson(Map<String, dynamic> json) => ContratoModel(
      id: json['id'],
      mes: json['mes'],
      numero: json['numero'],
      nombre: json['nombre'],
      precio: (json['precio'] as num).toDouble());

  Map<String, dynamic> toJson() => {
        'id': id,
        'mes': mes,
        'numero': numero,
        'nombre': nombre,
        'precio': precio
      };
  ContratoModel copyWith(
          {String? mes1, String? nombre1, String? numero1, double? precio1}) =>
      ContratoModel(
          mes: mes1 ?? mes!,
          nombre: nombre1 ?? nombre!,
          numero: numero1 ?? numero!,
          precio: precio1 ?? precio!);
}

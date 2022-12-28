import 'package:hive/hive.dart';

part 'contrato.g.dart';

@HiveType(typeId: 0)
class Contrato extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? mes;
  @HiveField(2)
  String? numero;
  @HiveField(3)
  String? nombre;
  @HiveField(4)
  double? precio;

  Contrato({
    this.id,
    this.mes,
    this.numero,
    this.nombre,
    this.precio,
  });

  factory Contrato.fromJson(Map<String, dynamic> json) => Contrato(
        id: json["id"],
        mes: json["mes"],
        numero: json["numero"],
        nombre: json["nombre"],
        precio: json["precio"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mes": mes,
        "numero": numero,
        "nombre": nombre,
        "precio": precio,
      };
}

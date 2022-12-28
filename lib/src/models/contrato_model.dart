class Contrato {
  Contrato({
    this.id,
    this.mes,
    this.numero,
    this.nombre,
    this.precio,
  });

  int? id;
  String? mes;
  String? numero;
  String? nombre;
  double? precio;

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

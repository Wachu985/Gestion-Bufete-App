// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contrato.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContratoAdapter extends TypeAdapter<Contrato> {
  @override
  final int typeId = 0;

  @override
  Contrato read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Contrato(
      id: fields[0] as int?,
      mes: fields[1] as String?,
      numero: fields[2] as String?,
      nombre: fields[3] as String?,
      precio: fields[4] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Contrato obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.mes)
      ..writeByte(2)
      ..write(obj.numero)
      ..writeByte(3)
      ..write(obj.nombre)
      ..writeByte(4)
      ..write(obj.precio);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContratoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

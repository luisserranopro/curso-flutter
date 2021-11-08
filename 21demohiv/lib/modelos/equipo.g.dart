// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equipo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EquipoAdapter extends TypeAdapter<Equipo> {
  @override
  final int typeId = 1;

  @override
  Equipo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Equipo(
      fields[0] as String,
      fields[1] as String,
      (fields[2] as List).cast<Jugador>(),
    );
  }

  @override
  void write(BinaryWriter writer, Equipo obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.entrenador)
      ..writeByte(2)
      ..write(obj.jugadores);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EquipoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

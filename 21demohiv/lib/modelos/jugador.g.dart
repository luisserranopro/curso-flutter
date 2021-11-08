// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jugador.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JugadorAdapter extends TypeAdapter<Jugador> {
  @override
  final int typeId = 0;

  @override
  Jugador read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Jugador(
      nombre: fields[0] as String,
      posicion: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Jugador obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.nombre)
      ..writeByte(1)
      ..write(obj.posicion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JugadorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

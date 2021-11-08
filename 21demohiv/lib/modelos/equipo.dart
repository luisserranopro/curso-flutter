

import 'jugador.dart';
import 'package:hive/hive.dart';

part 'equipo.g.dart';

@HiveType(typeId : 1)
class Equipo{
  @HiveField(0)
  String nombre;
  @HiveField(1)
  String entrenador;
  @HiveField(2)
  List<Jugador> jugadores;

  Equipo(
      this.nombre,
      this.entrenador,
      this.jugadores
      );
}
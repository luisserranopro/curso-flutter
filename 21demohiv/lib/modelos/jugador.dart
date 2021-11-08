
import 'package:hive/hive.dart';

part 'jugador.g.dart';

@HiveType(typeId : 0)
class Jugador{
  @HiveField(0)
  String nombre;
  @HiveField(1)
  String posicion;

  Jugador({
    required this.nombre,
    required this.posicion
});
}
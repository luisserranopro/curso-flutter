
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

class EquipoProvider{

  late Box box;

  Future<bool> inicializarBox() async{
    final directorio = await getApplicationSupportDirectory();
    Hive.init(directorio.path);
    box = await Hive.openBox('equiposBox');
    return box.isOpen;
  }

  Future<bool> anadirEquipo(var equipo) async{
    await box.add(equipo);
    return true;
  }

  Map<dynamic,dynamic> leerEquipos(){
    Map<dynamic,dynamic> equiposMap = box.toMap();
    return equiposMap;
  }

  Future<bool> eliminarEquipo(int indice) async{
    await box.deleteAt(indice);
    return true;
  }

  Future<bool> actualizarEquipo(int indice, var equipo) async{
    await box.putAt(indice, equipo);
    return true;
  }

  dispose(){
    box.close();
  }

}
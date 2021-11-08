
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class Preferencias {
  static const REDSOCIAL = "redsocial";
  static const USUARIO = "usuario";
  static const CONTRASENA = "contrasena";

  SharedPreferences? _preferencias;
  SharedPreferences? _preferenciasEncriptadas;
  EncryptedSharedPreferences _encryptedSharedPreferences = EncryptedSharedPreferences();
  bool redSocial = false;
  String usuario = "";
  String contrasena = "";

  Future<SharedPreferences> get preferences async {
    if (_preferencias == null) {
      _preferencias = await SharedPreferences.getInstance();
      _preferenciasEncriptadas = await _encryptedSharedPreferences.getInstance();
      redSocial = _preferencias?.getBool(REDSOCIAL)??false;
      usuario = _preferencias?.getString(USUARIO)??"";
      contrasena = _preferenciasEncriptadas?.getString(CONTRASENA)??"";
    }
    return _preferencias!;
  }

  Future<Preferencias> init() async {
    _preferencias = await preferences;
    return this;
  }

  Future<void> guardarRedSocial() async {
    await _preferencias!.setBool(REDSOCIAL, redSocial);
  }

  Future<void> guardarUsuario() async  {
    await _preferencias!.setString(USUARIO,usuario);
  }

  Future<void> guardarContrasena() async {
    await _preferenciasEncriptadas!.setString(CONTRASENA,contrasena);
  }

}
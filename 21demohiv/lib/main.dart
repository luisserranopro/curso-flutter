import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:demohive/modelos/equipo.dart';
import 'package:demohive/modelos/jugador.dart';
import 'package:demohive/listar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(JugadorAdapter());
  Hive.registerAdapter(EquipoAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Demo Hive',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      initialRoute: Listar.nombreRuta,
      routes: {
        Listar.nombreRuta : (context) => Listar(),
      }
    );
  }

}
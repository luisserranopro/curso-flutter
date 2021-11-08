import 'package:flutter/material.dart';
import 'package:preferencias/ajustes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Preferencias',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              _mostrarAjustes(context);
            },
          )
        ]
      ),
    );
  }

  void _mostrarAjustes(BuildContext context) {
    Navigator.push(context,
    new MaterialPageRoute(builder: (BuildContext context) {
      return Ajustes();
    }));
  }
}

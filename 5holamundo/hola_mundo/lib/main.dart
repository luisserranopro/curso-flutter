import 'package:flutter/material.dart';

//Nuestro programa empieza por la ejecución del método main
void main() => runApp(MiApp());

// Este widget es la raíz de mi aplicación
class MiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MiHomePage(),
    );
  }
}

class MiHomePage extends StatelessWidget {
  MiHomePage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Primer ejemplo"),
      ),
      body: Center(
          child:
          Text(
            '¡Hola mundo!',
          )
      ),
    );
  }
}


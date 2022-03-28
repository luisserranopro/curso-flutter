import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FichaProducto(nombre: 'Producto ejemplo', descripcion: 'Breve descripción del producto de ejemplo',
            precio: 21, imagen: 'producto.png'),
    );
  }
}

class FichaProducto extends StatelessWidget {

  final String nombre;
  final String descripcion;
  final int precio;
  final String imagen;

  const FichaProducto({this.nombre, this.descripcion, this.precio, this.imagen}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 150,
        child: Row(
          children: <Widget>[
            Image.asset("assets/imagenes/" + this.imagen),
            Column(
              children: <Widget>[
                Text(this.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(this.descripcion),
                Text("Precio: "+ this.precio.toString())
              ]
            )
          ],
        )
      )
    );
  }
}
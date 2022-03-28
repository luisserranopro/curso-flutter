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
      home: ListadoProductos(titulo: 'Listado de productos'),
    );
  }
}

class ListadoProductos extends StatelessWidget {

  final String titulo;

  const ListadoProductos({this.titulo}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.titulo),
      ),
      body: ListView(
        children: <Widget>[
          FichaProducto(nombre: 'Producto ejemplo', descripcion: 'Breve descripción del producto de ejemplo',
              precio: 21, imagen: 'producto.png'),
          FichaProducto(nombre: 'Producto ejemplo', descripcion: 'Breve descripción del producto de ejemplo',
              precio: 21, imagen: 'producto.png'),
          FichaProducto(nombre: 'Producto ejemplo', descripcion: 'Breve descripción del producto de ejemplo',
              precio: 21, imagen: 'producto.png'),
          FichaProducto(nombre: 'Producto ejemplo', descripcion: 'Breve descripción del producto de ejemplo',
              precio: 21, imagen: 'producto.png'),
          FichaProducto(nombre: 'Producto ejemplo', descripcion: 'Breve descripción del producto de ejemplo',
              precio: 21, imagen: 'producto.png'),
        ],
      )
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
    return Card(
        child: Container(
            height: 150,
            child: Row(
              children: <Widget>[
                Image.asset("assets/imagenes/" + this.imagen),
                Expanded (
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(this.nombre, style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(this.descripcion),
                        Text("Precio: "+ this.precio.toString())
                      ]
                  )
                )
              ],
            )
        ),
    );
  }
}
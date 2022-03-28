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
      home: ListadoProductos(titulo: 'Listado de productos con gestures'),
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
          FichaProducto(nombre: 'Producto 1', descripcion: 'Breve descripción del producto de ejemplo',
              precio: 21, imagen: 'producto.png'),
          FichaProducto(nombre: 'Producto 2', descripcion: 'Breve descripción del producto de ejemplo',
              precio: 21, imagen: 'producto.png'),
          FichaProducto(nombre: 'Producto 3', descripcion: 'Breve descripción del producto de ejemplo',
              precio: 21, imagen: 'producto.png'),
          FichaProducto(nombre: 'Producto 4', descripcion: 'Breve descripción del producto de ejemplo',
              precio: 21, imagen: 'producto.png'),
          FichaProducto(nombre: 'Producto 5', descripcion: 'Breve descripción del producto de ejemplo',
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
    return GestureDetector(
      child: Card(
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
          )
      ),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:(context)=> ProductoDetalle(nombre: this.nombre,descripcion: this.descripcion,precio: this.precio,imagen: this.imagen)));
      },
    );
  }
}

class ProductoDetalle extends StatelessWidget {

  final String nombre;
  final String descripcion;
  final int precio;
  final String imagen;

   ProductoDetalle({ @required this.nombre, @required this.descripcion, @required this.precio, @required this.imagen}): super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(this.nombre)
      ),
       body:  Center(
           child:
           Text(this.nombre))

    );
  }
}
import 'package:flutter/material.dart';
import 'package:listatareas/tarea.dart';
import 'package:listatareas/fichatarea.dart';
import 'package:listatareas/nuevatarea.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista Tareas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaTareas(),
    );
  }
}

class ListaTareas extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ListaTareasState();
  }
}

class ListaTareasState extends State<ListaTareas> {
  List<Tarea> listaTareas;


  @override
  Widget build(BuildContext context) {

    if (listaTareas == null) {
      listaTareas = [];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de tareas')
      ),
      body: ListView.builder(
          itemCount: listaTareas.length,
          itemBuilder:
          (BuildContext context, int posicion) {
            final item= listaTareas[posicion];
            return new GestureDetector(
              onTap: () {
                _editaTarea(listaTareas[posicion],this,posicion);
              },
              child: Dismissible (
                key: Key(item.nombre),
                onDismissed: (direction) {
                  eliminar(posicion);
                },
                child: Card(
                  margin: EdgeInsets.all(1.0),
                  elevation: 2.0,
                  child: FichaTarea (
                    titulo: item.nombre,
                    estado: item.estado,
                  )
                ),
              )
            );
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: "Añadir tarea",
        child: Icon(Icons.add),
        onPressed: () {
          _crearTarea(this);
        },
      ),
    );
  }

  void _crearTarea(ListaTareasState obj) {
    Navigator.push(context,
      MaterialPageRoute(builder: (context) => nuevaTarea(Tarea("",""),"Añadir tarea",obj))
    );
    actualizarListView();
  }

  void _editaTarea(Tarea tarea, ListaTareasState obj, int posicion) {
    Navigator.push(context,
    MaterialPageRoute(builder: (context) => nuevaTarea(tarea,'Editar tarea', obj, posicion))
    );
    actualizarListView();
  }

  void eliminar(int posicion) {
    this.listaTareas.removeAt(posicion);
    //Actualizar estado
    actualizarListView();
  }

  void actualizarListView() {
    setState(() {
      this.listaTareas = listaTareas;
    });
  }
}

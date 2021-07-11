import 'dart:core';

import 'package:sqlite/animal.dart';
import 'package:sqlite/db.dart';
import 'package:flutter/material.dart';

class Listado extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animales"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context,"/editar",arguments: Animal(id:0,nombre:"",especie:""));

        },
      ),
      body: Container(
        child: Lista()
      )
    );
  }
}

class Lista extends StatefulWidget {

  @override
  _MiLista createState() => _MiLista();

}

class _MiLista extends State<Lista> {

  List<Animal> animales = [];

  @override
  void initState() {
    cargaAnimales();
    super.initState();
  }

  cargaAnimales() async {
    List<Animal> auxAnimal = await DB.animales();

    setState(() {
      animales = auxAnimal;
    });

  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: animales.length,
        itemBuilder:
            (context, i) =>
          Dismissible(key: Key(i.toString()),
              direction: DismissDirection.startToEnd,
              background: Container (
                color: Colors.red,
                padding: EdgeInsets.only(left: 5),
                  child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.delete, color: Colors.white)
              )
              ),
            onDismissed: (direction) {
              DB.delete(animales[i]);
            },
            child: ListTile(
              title: Text(animales[i].nombre),
              trailing: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context,"/editar",arguments: animales[i]);
                },
                child: Icon(Icons.edit)
              )
            )
          )
    );
  }

}
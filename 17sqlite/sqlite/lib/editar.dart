import 'package:sqlite/db.dart';
import 'package:sqlite/animal.dart';
import 'package:flutter/material.dart';

class Editar extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final especieController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    Animal animal = ModalRoute.of(context).settings.arguments;
    nombreController.text = animal.nombre;
    especieController.text = animal.especie;

    return Scaffold(
      appBar: AppBar(
        title: Text("Guardar")
      ),
      body: Container(
        child: Padding(
          child: Form (
              key: _formKey,
              child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: nombreController,
                      validator: (value) {
                        if (value.isEmpty)
                          return "El nombre es obligatorio";
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Nombre"
                      ),

                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: especieController,
                      validator: (value) {
                        if (value.isEmpty)
                          return "La especie es obligatoria";
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Especie"
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            if (animal.id > 0) {
                              animal.nombre = nombreController.text;
                              animal.especie = especieController.text;
                              DB.update(animal);
                            }
                            else
                              DB.insert(Animal(nombre: nombreController.text, especie: especieController.text));
                            Navigator.pushNamed(context,"/");
                          }
                        },
                        child: Text("Guardar"))
                  ]
              )
          ),
          padding: EdgeInsets.all(15),
        )
      )
    );
  }

}
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:mongodb/bd/mongodb.dart';
import 'package:mongodb/modelos/jugador.dart';

class EditarJugador extends StatefulWidget {
  @override
  _EditarJugadorState createState() => _EditarJugadorState();
}

class _EditarJugadorState extends State<EditarJugador> {

  static const EDICION = 1;
  static const INSERCION = 2;

  TextEditingController nombreController = TextEditingController();
  TextEditingController equipoController = TextEditingController();
  TextEditingController dorsalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textoWidget = "Añadir jugador";
    int operacion = INSERCION;
    Jugador? jugador;

    if (ModalRoute.of(context)?.settings.arguments != null) {
      operacion = EDICION;
      jugador = ModalRoute.of(context)?.settings.arguments as Jugador;
      nombreController.text = jugador.nombre;
      equipoController.text = jugador.equipo;
      dorsalController.text = jugador.dorsal.toString();
      textoWidget = "Editar jugador";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(textoWidget)
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nombreController,
                    decoration: InputDecoration(labelText: "Nombre"),
                  )
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: equipoController,
                      decoration: InputDecoration(labelText: "Equipo"),
                    )
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: dorsalController,
                      decoration: InputDecoration(labelText: "Dorsal"),
                      keyboardType: TextInputType.number,
                    )
                )
              ],
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
              child: ElevatedButton(
                child: Text(textoWidget),
                onPressed: () {
                  if (operacion == EDICION) {
                    _actualizarJugador(jugador!);
                  } else {
                    _insertarJugador();
                  }
                  Navigator.pop(context);
                }
              )
            ),
          )
        ],
      )
    );

  }

  _insertarJugador() async {
    final jugador = Jugador(
      id: M.ObjectId(),
      nombre: nombreController.text,
      dorsal: int.parse(dorsalController.text),
      equipo: equipoController.text
    );
    await MongoDB.insertar(jugador);

  }

  _actualizarJugador(Jugador jugador) async {
    final j = Jugador (
      id: jugador.id,
      nombre: nombreController.text,
      equipo: equipoController.text,
      dorsal: int.parse(dorsalController.text)
    );
    await MongoDB.actualizar(j);

  }

  @override
  void dispose() {
    super.dispose();
    nombreController.dispose();
    equipoController.dispose();
    dorsalController.dispose();
  }

}
import 'package:flutter/material.dart';
import 'package:mongodb/modelos/jugador.dart';

class FichaJugador extends StatelessWidget {

  FichaJugador({required this.jugador, required this.onTapDelete, required this.onTapEdit});
  final Jugador jugador;
  final VoidCallback onTapEdit, onTapDelete;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      color: Colors.white,
      child: ListTile(
        leading: Text('${jugador.dorsal}', style: Theme.of(context).textTheme.headline6),
        title: Text(jugador.nombre),
        subtitle: Text(jugador.equipo),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: Icon(Icons.edit),
              onTap: onTapEdit
            ),
            GestureDetector(
              child: Icon(Icons.delete),
              onTap: onTapDelete,
            )
          ],
        ),
      )
    );

  }

}
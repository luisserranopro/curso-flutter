
import 'package:flutter/material.dart';
import 'package:demohive/modelos/equipo.dart';
import 'package:demohive/modelos/jugador.dart';
import 'package:demohive/provider/equipo_provider.dart';
import 'package:demohive/editar.dart';

class Listar extends StatefulWidget{
  static const nombreRuta = 'listar';

  @override
  _ListarState createState() => _ListarState();
}

class _ListarState extends State<Listar> {

  var equipoProvider = EquipoProvider();

  @override
  void dispose() {
    super.dispose();
    equipoProvider.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Equipos')
      ),
      body: FutureBuilder(
        future: equipoProvider.inicializarBox(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.done) {
            return (equipoProvider.box.length < 1) ? Container() : _leerEquipos(context);
          }
          return Container();
        }
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add_circle),
        iconSize: 60.0,
          onPressed: (){

            var jugador1 = Jugador(posicion: '',nombre: '');
            var jugador2 = Jugador(posicion: '',nombre: '');
            var jugador3 = Jugador(posicion: '',nombre: '');
            var equipo = Equipo('','',[]);
            equipo.jugadores
              ..add(jugador1)
              ..add(jugador2)
              ..add(jugador3);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Editar(
                  equipo: equipo,
                  indiceEquipo: null,
                  guardar: true
                )
              )
            );
          },
      )
    );
  }

  ListView _leerEquipos(BuildContext context) {
    var equiposMap = equipoProvider.leerEquipos();
    var clavesEquipos = equiposMap.keys;

    return ListView.builder(
        itemCount: equiposMap.length,
        itemBuilder: (context, indiceEquipos) {
          var claveEquipo = clavesEquipos.elementAt(indiceEquipos);
          var equipo = equiposMap[claveEquipo];
          return Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
            child: ListTile(
              title: GestureDetector(
                child: Text(
                  '${equipo.nombre}\nEntrenador: ${equipo.entrenador}',
                   style: TextStyle(fontWeight: FontWeight.bold)
                ),
                onTap: ()  {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Editar(
                        equipo: equipo,
                        indiceEquipo: indiceEquipos,
                        guardar: false
                      )
                    )
                  );
                }
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
                  _eliminarEquipo(indiceEquipos);
                  setState((){});
                },
              )
            )
          );
        }
    );

  }

  void _eliminarEquipo (int indice){
    equipoProvider.eliminarEquipo(indice);
  }

}
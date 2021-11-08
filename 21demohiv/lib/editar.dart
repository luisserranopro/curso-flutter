
import 'package:flutter/material.dart';
import 'package:demohive/provider/equipo_provider.dart';
import 'package:demohive/listar.dart';

class Editar extends StatefulWidget{
  static const nombreRuta = 'editar';
  final equipo;
  final int? indiceEquipo;
  final bool guardar;

  Editar({
    required this.equipo,
    required this.indiceEquipo,
    required this.guardar
  });

  @override
  _EditarState createState() => _EditarState();
}

class _EditarState extends State<Editar> {
  final _controller = ScrollController();
  var equipoProvider = EquipoProvider();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose()  {
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    final formKey = GlobalKey<FormState>();
    equipoProvider.inicializarBox();

    return Scaffold(
      appBar: AppBar(
        title: widget.indiceEquipo!=null ? Text('${widget.equipo.nombre}') : Text('Equipo nuevo')
      ),
      body: Form(
        key: formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nombre:'),
                  initialValue: '${widget.equipo.nombre}',
                  onSaved: (nuevoNombre) => widget.equipo.nombre = nuevoNombre!,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Entrenador:'),
                  initialValue: widget.equipo.entrenador,
                  onSaved: (nuevoEntrenador) => widget.equipo.entrenador = nuevoEntrenador!,
                ),
                SizedBox(
                  height: 200.0,
                  child: ListView.builder(
                    itemCount: 3,
                    scrollDirection: Axis.vertical,
                    controller: _controller,
                    itemBuilder: (context, indice) {
                      var jugador = widget.equipo.jugadores[indice];
                      return Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            height: 60,
                            width: 160,
                            child: TextFormField(
                              decoration: InputDecoration(labelText: 'Nombre:'),
                              initialValue: jugador.nombre,
                              onSaved: (nuevoNombre) => jugador.nombre = nuevoNombre,
                            )
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            height: 60.0,
                            width: 120.0,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Posición:'
                              ),
                              initialValue: jugador.posicion,
                              onSaved: (nuevaPosicion) => jugador.posicion = nuevaPosicion,
                            )
                          )
                        ],
                      );
                    },
                  )
                )
              ],
            )
        )
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.save),
        onPressed: () {
          formKey.currentState!.save();
          (widget.guardar) ?
          _anadirEquipo(widget.equipo)
                  : _actualizarEquipo(widget.indiceEquipo!, widget.equipo);
        },
      ),
    );
  }

  _anadirEquipo(var equipo){
    equipoProvider.anadirEquipo(equipo);
    Navigator.pushNamed(context, Listar.nombreRuta);
  }

  _actualizarEquipo(int indiceEquipo, var equipo){
    equipoProvider.actualizarEquipo(indiceEquipo, equipo);
    Navigator.pushNamed(context, Listar.nombreRuta);
  }
}
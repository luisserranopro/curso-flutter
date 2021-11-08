
import 'package:flutter/material.dart';
import 'package:preferencias/preferencias.dart';


class Ajustes extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  Preferencias _preferencias = Preferencias();

  @override
  Widget build(BuildContext context) {
    TextEditingController usuarioController =
        TextEditingController(text: _preferencias.usuario);
    TextEditingController contrasenaController =
        TextEditingController(text: _preferencias.contrasena);
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes')
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Red social:")
                ),
                Switch(value: _preferencias.redSocial,
                    onChanged: (value) {
                      setState(() {
                        _preferencias.redSocial = value;
                        _preferencias.guardarRedSocial();
                      });
                    })
              ]
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Usuario:")
                ),
                Container(
                  width: 120,
                  child: TextField(
                    controller: usuarioController,
                    onChanged: (value){
                      _preferencias.usuario = value;
                      _preferencias.guardarUsuario();
                    },
                  )
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Contraseña:")
                ),
                Container(
                  width: 120,
                  child: TextField(
                    obscureText: true,
                    controller: contrasenaController,
                    onChanged: (value) {
                      _preferencias.contrasena = value;
                      _preferencias.guardarContrasena();
                    },
                  )
                )
              ],
            )
          ]
        )
      )
    );
  }

  @override
  void initState() {
    super.initState();
    _preferencias.init().then((value) {
      setState(() {
        _preferencias = value;
      });
    });
  }

}
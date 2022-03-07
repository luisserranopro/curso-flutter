
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:googlemaps/click.dart';
import 'package:googlemaps/mapa.dart';
import 'package:googlemaps/animaciones.dart';

class DrawerItem {
  String title;
  IconData icon;

  DrawerItem(this.title, this.icon);
}

class Portada extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Mapa UI", Icons.map),
    new DrawerItem("Click", Icons.mouse),
    new DrawerItem("Animaciones", Icons.animation)
  ];

  @override
  State<StatefulWidget> createState() => PortadaState();

}

class PortadaState extends State<Portada> {
  int _indiceDrawerItemSeleccionado = 0;

  _getDrawerFragment(int posicion) {
    switch (posicion) {
      case 0:
        return new Mapa();
      case 1:
        return new ClickPagina();
      case 2:
        return AnimacionesPagina();
      default:
        return new Text("Error");
    }
  }

  _onSelectItem(int index) {
    setState(() => _indiceDrawerItemSeleccionado=  index);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> opcionesDrawer = [];

    for (var i=0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      opcionesDrawer.add(
        new ListTile(
          leading: new Icon(d.icon),
          title: new Text(d.title),
          selected: i == _indiceDrawerItemSeleccionado,
          onTap: () => _onSelectItem(i),
        )
      );
    }

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.drawerItems[_indiceDrawerItemSeleccionado].title),
      ),
      drawer: new Drawer(
        child: Column(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Luis Serrano"),
              accountEmail: new Text("luis@luisserrano.pro"),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: new AssetImage("assets/profile.png"),
              ),
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/bg.jpg"),
                  fit: BoxFit.cover
                )
              ),
            ),
            new Column(
              children: opcionesDrawer
            )
          ],
        )
      ),
      body: _getDrawerFragment(_indiceDrawerItemSeleccionado),
    );
  }

}
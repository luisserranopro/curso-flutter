import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/pagina.dart';


const CameraPosition _posicionInicial =
CameraPosition(target: LatLng(37.18817, -3.60667), zoom: 11.0);

class ClickPagina extends Pagina {
  ClickPagina() : super(const Icon(Icons.mouse), 'Clicks');

  @override
  Widget build(BuildContext context) {
    return const Click();
  }
}

class Click extends StatefulWidget {
  const Click();

  @override
  State<StatefulWidget> createState() => _ClickState();
}

class _ClickState extends State<Click> {
  _ClickState();

  GoogleMapController? _controllerMap;
  LatLng? _ultimoTap;
  LatLng? _ultimoLongPress;

  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: _posicionInicial,
      onTap: (LatLng pos) {
        setState(() {
          _ultimoTap = pos;
        });
      },
      onLongPress: (LatLng pos) {
        setState(() {
          _ultimoLongPress = pos;
        });
      },
    );

    final List<Widget> columnChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: googleMap,
          ),
        ),
      ),
    ];

    if (_controllerMap != null) {
      final String ultimoTap = 'Tap:\n${_ultimoTap ?? ""}\n';
      final String ultimoLongPress = 'Long press:\n${_ultimoLongPress ?? ""}';
      columnChildren.add(Center(
          child: Text(
            ultimoTap,
            textAlign: TextAlign.center,
          )));
      columnChildren.add(Center(
          child: Text(
            _ultimoTap != null ? 'Tap' : '',
            textAlign: TextAlign.center,
          )));
      columnChildren.add(Center(
          child: Text(
            ultimoLongPress,
            textAlign: TextAlign.center,
          )));
      columnChildren.add(Center(
          child: Text(
            _ultimoLongPress != null ? 'Long press' : '',
            textAlign: TextAlign.center,
          )));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: columnChildren,
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    setState(() {
      _controllerMap = controller;
    });
  }
}

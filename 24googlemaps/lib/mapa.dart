import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'pagina.dart';

class Mapa extends Pagina {
  Mapa() : super(const Icon(Icons.map), "Mapa UI");
  
  @override
  Widget build(BuildContext context) {
    return const MapaUI();
  }
}

class MapaUI extends StatefulWidget {
  const MapaUI();
  
  @override
  State<StatefulWidget> createState() => MapaUIState();
}

class MapaUIState extends State<MapaUI> {
  MapaUIState();
  
  static final CameraPosition _posicionInicial = const CameraPosition(
    target: LatLng(37.18817, -3.60667),
    zoom: 11.0,
  );
  
  CameraPosition _posicion = _posicionInicial;
  bool _estaMapaCreado = false;
  bool _estaMoviendose = false;
  bool _brujulaActiva = true;
  bool _barraHerramientasMapaActiva = true;
  CameraTargetBounds _limitesCamara = CameraTargetBounds.unbounded;
  MinMaxZoomPreference _preferenciasMinMaxZoom = MinMaxZoomPreference.unbounded;
  MapType _tipoMapa = MapType.normal;
  bool _gestoRotacionActivado = true;
  bool _gestoScrollActivado = true;
  bool _gestoInclinacionActivado = true;
  bool _controlesZoomActivos = true;
  bool _gestoZoomActivo = true;
  bool _vistaInteriorActiva = true;
  bool _miTraficoActivo = false;
  bool _botonLocalizacionActivo = true;
  bool _localizacionActiva = true;
  late GoogleMapController _controller;
  bool _modoNocturno = false;
  
  @override
  Widget build(BuildContext context) {
    final GoogleMap googleMap = GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: _posicionInicial,
      compassEnabled: _brujulaActiva,
      mapToolbarEnabled: _barraHerramientasMapaActiva,
      cameraTargetBounds: _limitesCamara,
      minMaxZoomPreference: _preferenciasMinMaxZoom,
      mapType: _tipoMapa,
      rotateGesturesEnabled: _gestoRotacionActivado,
      scrollGesturesEnabled: _gestoScrollActivado,
      tiltGesturesEnabled: _gestoInclinacionActivado,
      zoomGesturesEnabled: _gestoZoomActivo,
      zoomControlsEnabled: _controlesZoomActivos,
      indoorViewEnabled: _vistaInteriorActiva,
      myLocationEnabled: _localizacionActiva,
      myLocationButtonEnabled: _botonLocalizacionActivo,
      trafficEnabled: _miTraficoActivo,
      onCameraMove: _actualizarPosicionCamara,
    );  
    
    final List<Widget> columnChildren = <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: googleMap,
          )
        )
      )
    ];
    
    if (_estaMapaCreado) {
      columnChildren.add(
        Expanded(
          child: ListView(
            children: <Widget>[
              Text('Objetivo cámara: ${_posicion.target.latitude.toStringAsFixed(4)},'
                '${_posicion.target.longitude.toStringAsFixed(4)}'),
              Text('Zoom cámara: ${_posicion.zoom}'),
              Text('Inclinacion cámara: ${_posicion.tilt}'),
              _botonBrujula(),
              _botonBarraHerramientasMapa(),
              _botonLimitesLatLng(),
              _botonTipoMapa(),
              _botonRotacion(),
              _botonScroll(),
              _botonInclinacion(),
              _botonZoom(),
              _botonControlesZoom(),
              _botonVistaInterior(),
              _botonMiLocalizacion(),
              _botonMiLocalizacionBoton(),
              _botonMiTrafico(),
              _botonModoNocturno(),

            ],
          )
        )
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: columnChildren,
    );
  }

  Widget _botonBrujula() {
    return TextButton(
      child: Text('${_brujulaActiva ? 'Desactivar' : 'Activar' } brújula'),
      onPressed: () {
        setState(() {
          _brujulaActiva = !_brujulaActiva;
        });
      },
    );
  }

  Widget _botonBarraHerramientasMapa() {
    return TextButton(
      child: Text('${_barraHerramientasMapaActiva ? 'Desactivar' : 'Activar'} barra de herramientas'),
      onPressed: () {
        setState(() {
          _barraHerramientasMapaActiva = !_barraHerramientasMapaActiva;
        });
      },
    );
  }

  Widget _botonLimitesLatLng() {
    return TextButton(
      child: Text(
        _limitesCamara.bounds == null ? 'Objetivo de cámara limitado' : 'Liberar objetivo '),
      onPressed: () {
        setState(() {
          _limitesCamara = _limitesCamara.bounds == null
              ? CameraTargetBounds( LatLngBounds(
                  southwest: const LatLng(37.102096, -3.511572),
                  northeast: const LatLng(37.186522, -3.729067))
                )
              : CameraTargetBounds.unbounded;
        });
      },

    );
  }

  Widget _botonTipoMapa() {
    final MapType siguienteTipo =
        MapType.values[(_tipoMapa.index + 1) % MapType.values.length];
    return TextButton(
      child: Text ('Tipo de mapa $siguienteTipo'),
      onPressed: (){
        setState(() {
          _tipoMapa = siguienteTipo;
        });
      },
    );
  }

  Widget _botonRotacion() {
    return TextButton(
      child: Text('${_gestoRotacionActivado ? 'Desactivar' : 'Activar'} gestos rotación'),
      onPressed: () {
        setState(() {
          _gestoRotacionActivado = !_gestoRotacionActivado;
        });
      },
    );
  }

  Widget _botonScroll() {
    return TextButton(
      child: Text('${_gestoScrollActivado ? 'Desactivar' : 'Actovar'} gestos scroll'),
      onPressed: () {
        setState(() {
          _gestoScrollActivado = !_gestoScrollActivado;
        });
      },
    );
  }

  Widget _botonInclinacion() {
    return TextButton(
      child: Text('${_gestoInclinacionActivado ? 'Desactivar' : 'Activar'} gestos inclinación'),
      onPressed: () {
        setState(() {
          _gestoInclinacionActivado = !_gestoInclinacionActivado;
        });
      },
    );
  }

  Widget _botonZoom() {
    return TextButton(
      child: Text('${_gestoZoomActivo ? 'Desactivar' : 'Activar'} gestos zoom'),
      onPressed: () {
        setState(() {
            _gestoZoomActivo = !_gestoZoomActivo;
        });
      },
    );
  }

  Widget _botonControlesZoom() {
    return TextButton(
      child:
        Text('${_controlesZoomActivos ? 'Desactivar' : 'Activar'} control zoom'),
      onPressed: () {
        setState(() {
          _controlesZoomActivos = !_controlesZoomActivos;
        });
      },
    );
  }

  Widget _botonVistaInterior() {
    return TextButton(
      child: Text('${_vistaInteriorActiva ? 'Desactivar' : 'Activar'} vista interior'),
      onPressed: () {
        setState(() {
          _vistaInteriorActiva = !_vistaInteriorActiva;
        });
      },
    );
  }

  Widget _botonMiLocalizacion() {
    return TextButton(
      child: Text('${_localizacionActiva ? 'Desactivar' : 'Activar'} localización'),
      onPressed: () {
        setState(() {
          _localizacionActiva = !_localizacionActiva;
        });
      },
    );
  }

  Widget _botonMiLocalizacionBoton() {
    return TextButton(
      child: Text('${_botonLocalizacionActivo ? 'Desactivar' : 'Activar'} botón de localización'),
      onPressed: () {
        setState(() {
          _botonLocalizacionActivo = !_botonLocalizacionActivo;
        });
      },
    );
  }

  Widget _botonMiTrafico() {
    return TextButton(
      child: Text('${_miTraficoActivo ? 'Desactivar' : 'Activar'} mi tráfico'),
      onPressed: () {
        setState(() {
          _miTraficoActivo = !_miTraficoActivo;
        });
      },
    );
  }

  Future<String> _leerFichero(String ruta) async {
    return await rootBundle.loadString(ruta);
  }
  
  void _cargarMapaEstilos(String mapaEstilos) {
    setState(() {
      _modoNocturno = true;
      _controller.setMapStyle(mapaEstilos);
    });
  }
  
  Widget _botonModoNocturno() {
    assert(_estaMapaCreado);
    return TextButton(
      child: Text('${_modoNocturno ? 'Desactivar' : 'Activar'} modo nocturno'),
      onPressed: () {
        if (_modoNocturno) {
          _modoNocturno = false;
          _controller.setMapStyle(null);
        }
        else {
          _leerFichero("assets/night_mode.json").then(_cargarMapaEstilos);
        }
      },
    );
  }

  void _actualizarPosicionCamara(CameraPosition posicion) {
    setState(() {
      _posicion = posicion;
    });
  }
  
  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
      _estaMapaCreado = true;
    });
  }
  
}
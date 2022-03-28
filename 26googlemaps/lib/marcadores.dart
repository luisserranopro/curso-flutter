import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/pagina.dart';
import 'dart:async';
import 'dart:math';
import 'dart:ui';

class MarcadorLugarPagina extends Pagina {
  MarcadorLugarPagina() : super (const Icon(Icons.place), 'Marcadores');

  @override
  Widget build(BuildContext context) {
    return MarcadorLugar();
  }
}

class MarcadorLugar extends StatefulWidget {
  const MarcadorLugar();

  @override
  State<StatefulWidget> createState() => MarcadorLugarState();
}

class MarcadorLugarState extends State<MarcadorLugar> {
  MarcadorLugarState();

  static final LatLng centro = const LatLng(37.188817, -3.60667);

  GoogleMapController? _controladorMapa;
  Map<MarkerId, Marker> _marcadores = <MarkerId, Marker>{};
  MarkerId? _marcadorSeleccionado;
  int _contadorIdMarcador = 1;
  LatLng? _posicionMarcador;

  void _onMapCreated(GoogleMapController controlador) {
    this._controladorMapa = controlador;
  }

  void _anadir() {
    if (_marcadores.length == 12)
      return;

    final String cadenaIdMarcador = 'marcador_id_$_contadorIdMarcador';
    _contadorIdMarcador++;
    final MarkerId idMarcador = MarkerId(cadenaIdMarcador);

    final Marker marcador = Marker(
      markerId: idMarcador,
      position: LatLng(centro.latitude + sin (_contadorIdMarcador * pi / 6.0) / 20.0,
        centro.longitude + cos(_contadorIdMarcador * pi / 6.0) / 20.0,
      ),
      infoWindow: InfoWindow(
        title: cadenaIdMarcador,
        snippet: 'info'
      ),
      onTap: () => _onMarkerTapped(idMarcador),
      onDragEnd: (LatLng posicion) => _onMarkerDragEnd(idMarcador, posicion),
      onDrag: (LatLng posicion) => _onMarkerDrag(idMarcador, posicion),
    );
    setState(() {
      _marcadores[idMarcador] = marcador;
    });
  }

  void _onMarkerTapped(MarkerId idMarcador) {
    final Marker? marcadorTocado = _marcadores[idMarcador];

    if (marcadorTocado!=null) {
      setState(() {
        final MarkerId? idMarcadorAnterior = _marcadorSeleccionado;
        if (idMarcadorAnterior != null && _marcadores.containsKey(idMarcadorAnterior)) {
          final Marker anteriorActualizado = _marcadores[idMarcadorAnterior]!.copyWith(
            iconParam: BitmapDescriptor.defaultMarker
          );
        }
        _marcadorSeleccionado = idMarcador;
        final Marker marcadorNuevo = marcadorTocado.copyWith(
          iconParam: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen)
        );
        _marcadores[idMarcador] = marcadorNuevo;
        _posicionMarcador = null;
      });
    }
  }

  void _onMarkerDrag(MarkerId idMarcador, LatLng nuevaPosicion) async {
    setState(() {
      this._posicionMarcador = nuevaPosicion;
    });
  }

  void _onMarkerDragEnd(MarkerId idMarcador, LatLng nuevaPosicion) async {
    final Marker? marcadorTocado = _marcadores[idMarcador];
    if (marcadorTocado != null) {
      setState(() {
        this._posicionMarcador = null;
      });
      await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
       return AlertDialog(
        actions: <Widget> [
          TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
          )
        ],
         content: Padding(padding: const EdgeInsets.symmetric(vertical: 66),
         child: Column(
           mainAxisSize: MainAxisSize.min,
           children: <Widget>[
             Text('Anterior posición: ${marcadorTocado.position}'),
             Text('Nueva posición: $nuevaPosicion')
           ]
         )),
       );
    });
    }
  }

  void _eliminar(MarkerId idMarcador) {
    setState(() {
      if (_marcadores.containsKey(idMarcador)) {
        _marcadores.remove(idMarcador);
      }
    });
  }

  void _cambiarPosicion(MarkerId idMarcador) {
    final Marker marcador = _marcadores[idMarcador]!;
    final LatLng actual = marcador.position;
    final Offset desplazamiento = Offset(
      centro.latitude - actual.latitude,
      centro.longitude - actual.longitude
    );
    setState(() {
      _marcadores[idMarcador] = marcador.copyWith(
        positionParam: LatLng(
          centro.latitude + desplazamiento.dy,
          centro.longitude + desplazamiento.dx
        )
      );
    });
  }

  void _cambiarAnclaje(MarkerId idMarcador) {
    final Marker marcador = _marcadores[idMarcador]!;
    final Offset anclajeActual = marcador.anchor;
    final Offset anclajeNuevo = Offset(
        1.0 - anclajeActual.dy,
        anclajeActual.dx);
    setState(() {
      _marcadores[idMarcador] = marcador.copyWith(
        anchorParam: anclajeNuevo
      );
    });
  }

  Future <void> _cambiarInfoAnclaje(MarkerId idMarcador) async {
    final Marker marcador = _marcadores[idMarcador]!;
    final Offset anclajeActual = marcador.infoWindow.anchor;
    final Offset anclajeNuevo = Offset(
      1.0 - anclajeActual.dy,
      anclajeActual.dx
    );
    setState(() {
      _marcadores[idMarcador] = marcador.copyWith(
        anchorParam: anclajeNuevo,
      );
    });
  }

  Future<void> _cambiarArrastrable(MarkerId idMarcador) async {
    final Marker marcador = _marcadores[idMarcador]!;
    setState(() {
      _marcadores[idMarcador] = marcador.copyWith(
          draggableParam: !marcador.draggable
      );
    });
  }

    Future<void> _cambiarPlano(MarkerId idMarcador) async {
      final Marker marcador = _marcadores[idMarcador]!;
      setState(() {
        _marcadores[idMarcador] = marcador.copyWith(
          flatParam: !marcador.flat
        );
      });
    }

   Future<void> _cambiarInfo(MarkerId idMarcador) async{
    final Marker marcador = _marcadores[idMarcador]!;
    final String nuevoSnippet = marcador.infoWindow.snippet! + '+';
    setState(() {
      _marcadores[idMarcador] = marcador.copyWith(
        infoWindowParam: marcador.infoWindow.copyWith(
          snippetParam: nuevoSnippet,
        )
      );
    });

    Future<void> _cambiarTransparencia(MarkerId idMarcador) async {
      final Marker marcador = _marcadores[idMarcador]!;
      final double transparenciaActual = marcador.alpha;
      setState(() {
        _marcadores[idMarcador] = marcador.copyWith(
          alphaParam: transparenciaActual < 0.1 ? 1.0 : transparenciaActual * 0.75
        );
      });
    }
    }

    Future<void> _cambiarRotacion(MarkerId idMarcador) async{
    final Marker marcador = _marcadores[idMarcador]!;
    final double rotacionActual = marcador.rotation;
    setState(() {
      _marcadores[idMarcador] = marcador.copyWith(
        rotationParam: rotacionActual == 330.0 ? 0 : rotacionActual + 30.0
      );
    });

    }

    Future<void> _cambiarVisibilidad(MarkerId idMarcador) async {
    final Marker marcador = _marcadores[idMarcador]!;
    setState(() {
      _marcadores[idMarcador] = marcador.copyWith(
        visibleParam: !marcador.visible
      );
    });
    }

    Future<void> _cambiarIndiceZ(MarkerId idMarcador) async {
    final Marker marcador = _marcadores[idMarcador]!;
    final double indiceZActual = marcador.zIndex;
    setState(() {
      _marcadores[idMarcador] = marcador.copyWith(
        zIndexParam: indiceZActual == 12.0 ? 0.0 : indiceZActual + 1.0
      );
    });
    }

    void _cambiarIcono(MarkerId idMarcador, BitmapDescriptor icono) {
    final Marker marcador = _marcadores[idMarcador]!;
    setState(() {
      _marcadores[idMarcador] = marcador.copyWith(
        iconParam: icono,
      );
    });
    }

    Future<BitmapDescriptor> _leerIcono(BuildContext context) async {
    final Completer<BitmapDescriptor> bitmapIcon = Completer<BitmapDescriptor>();
    final ImageConfiguration configuracion = createLocalImageConfiguration(context);
    const AssetImage('assets/red_square.png').resolve(configuracion)
      .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
        final ByteData? bytes = await image.image.toByteData(format: ImageByteFormat.png);
        if (bytes == null) {
          bitmapIcon.completeError(Exception('Imposible codificar el icono'));
          return;
        }
        final BitmapDescriptor bitmap = BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
        bitmapIcon.complete(bitmap);
    }));
    return await bitmapIcon.future;
    }

    @override
    Widget build(BuildContext context) {
    final MarkerId? idSeleccionado = _marcadorSeleccionado;
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: const CameraPosition(target: LatLng(37.188817, -3.60667),zoom: 11.0),
                markers: Set<Marker>.of(_marcadores.values),
              )
            ),
            Row (mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                child: const Text('Añadir'),
                onPressed: _anadir,
              ),
              TextButton(
                  onPressed: idSeleccionado == null ? null : () => _eliminar(idSeleccionado),
                  child: const Text('Eliminar')
              )
            ],),
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: <Widget>[
                TextButton(
                  child: const Text('Cambiar info'),
                  onPressed: idSeleccionado == null ? null : () => _cambiarInfo(idSeleccionado),
                ),
                TextButton(
                  child: const Text('Cambiar info anclaje'),
                  onPressed: idSeleccionado == null ? null : () => _cambiarInfoAnclaje(idSeleccionado),
                ),
                TextButton(
                  child: const Text('Cambiar anclaje'),
                  onPressed: idSeleccionado == null ? null : () => _cambiarAnclaje(idSeleccionado),
                ),
                TextButton(
                  child: const Text('Cambiar arrastrable'),
                  onPressed: idSeleccionado == null ? null : () => _cambiarArrastrable(idSeleccionado),
                ),
                TextButton(
                  child: const Text('Cambiar plano'),
                  onPressed: idSeleccionado == null ? null : () => _cambiarPlano(idSeleccionado),
                ),
                TextButton(
                  child: const Text('Cambiar posición'),
                  onPressed: idSeleccionado == null ? null : () => _cambiarPosicion(idSeleccionado),
                ),
                TextButton(
                  child: const Text('Cambiar rotación'),
                  onPressed: idSeleccionado == null ? null : () => _cambiarRotacion(idSeleccionado),
                ),
                TextButton(
                  child: const Text('Cambiar visible'),
                  onPressed: idSeleccionado == null ? null : () => _cambiarVisibilidad(idSeleccionado),
                ),
                TextButton(
                  child: const Text('Cambiar índice Z'),
                  onPressed: idSeleccionado == null ? null : () => _cambiarIndiceZ(idSeleccionado),
                ),
                TextButton(
                  child: const Text('Cambiar icono marcador'),
                  onPressed: idSeleccionado == null ? null : () {
                      _leerIcono(context).then(
                      (BitmapDescriptor icon) {
                        _cambiarIcono(idSeleccionado, icon);
                        }
                      );
                    }
                  ),
              ],
            ),
            Visibility(
              visible: _posicionMarcador != null,
                child: Container(
                  color: Colors.white70,
                  height: 30,
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _posicionMarcador == null ? Container() : Expanded(
                        child: Text("lat: ${_posicionMarcador!.latitude}")),
                      _posicionMarcador == null ? Container() : Expanded(
                        child: Text("lng: ${_posicionMarcador!.longitude}")
                      ),
                    ],
                  )
                ))
          ],
        )
      ],
    );
  }


}
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/pagina.dart';

class AnimacionesPagina extends Pagina {
  AnimacionesPagina()
      : super(Icon(Icons.animation) , 'Animaciones');

  @override
  Widget build(BuildContext context) {
    return const Animaciones();
  }
}

class Animaciones extends StatefulWidget {
  const Animaciones();
  @override
  State createState() => AnimacionesState();
}

class AnimacionesState extends State<Animaciones> {
  GoogleMapController? _controllerMap;

  void _onMapCreated(GoogleMapController controllerMap) {
    _controllerMap = controllerMap;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Center(
          child: SizedBox(
            width: 300.0,
            height: 200.0,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition:
              const CameraPosition(target: LatLng(37.18817, -3.60667)),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    _controllerMap?.animateCamera(
                      CameraUpdate.newCameraPosition(
                        const CameraPosition(
                          bearing: 270.0,
                          target: LatLng(37.18817, -3.60667),
                          tilt: 30.0,
                          zoom: 17.0,
                        ),
                      ),
                    );
                  },
                  child: const Text('newCameraPosition'),
                ),
                TextButton(
                  onPressed: () {
                    _controllerMap?.animateCamera(
                      CameraUpdate.newLatLng(
                        const LatLng(48.85341, 2.3488),
                      ),
                    );
                  },
                  child: const Text('newLatLng'),
                ),
                TextButton(
                  onPressed: () {
                    _controllerMap?.animateCamera(
                      CameraUpdate.newLatLngBounds(
                        LatLngBounds(
                          southwest: const LatLng(-38.483935, 113.248673),
                          northeast: const LatLng(-8.982446, 153.823821),
                        ),
                        10.0,
                      ),
                    );
                  },
                  child: const Text('newLatLngBounds'),
                ),
                TextButton(
                  onPressed: () {
                    _controllerMap?.animateCamera(
                      CameraUpdate.newLatLngZoom(
                        const LatLng(37.4231613, -122.087159),
                        11.0,
                      ),
                    );
                  },
                  child: const Text('newLatLngZoom'),
                ),
                TextButton(
                  onPressed: () {
                    _controllerMap?.animateCamera(
                      CameraUpdate.scrollBy(150.0, -225.0),
                    );
                  },
                  child: const Text('scrollBy'),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    _controllerMap?.animateCamera(
                      CameraUpdate.zoomBy(
                        -0.5,
                        const Offset(30.0, 20.0),
                      ),
                    );
                  },
                  child: const Text('zoomBy with focus'),
                ),
                TextButton(
                  onPressed: () {
                    _controllerMap?.animateCamera(
                      CameraUpdate.zoomBy(-0.5),
                    );
                  },
                  child: const Text('zoomBy'),
                ),
                TextButton(
                  onPressed: () {
                    _controllerMap?.animateCamera(
                      CameraUpdate.zoomIn(),
                    );
                  },
                  child: const Text('zoomIn'),
                ),
                TextButton(
                  onPressed: () {
                    _controllerMap?.animateCamera(
                      CameraUpdate.zoomOut(),
                    );
                  },
                  child: const Text('zoomOut'),
                ),
                TextButton(
                  onPressed: () {
                    _controllerMap?.animateCamera(
                      CameraUpdate.zoomTo(16.0),
                    );
                  },
                  child: const Text('zoomTo'),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}

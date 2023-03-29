/*import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Home/Home.dart';

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context, 'Valor enviado a la página anterior');
        },
        label: const Text('Salida'),
        icon: const Icon(Icons.exit_to_app),
      ),

    );
  }
}
 */

/*import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class GoogleMapWeb extends StatefulWidget {
  const GoogleMapWeb({Key? key}) : super(key: key);

  @override
  _GoogleMapWebState createState() => _GoogleMapWebState();
}

class _GoogleMapWebState extends State<GoogleMapWeb> {
  late InAppWebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Web'),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
          url: Uri.parse(
              'https://www.google.com/maps/embed/v1/place?key=<YOUR_API_KEY>&q=SPACE+Needle,Seattle+WA'),
        ),
        onWebViewCreated: (controller) {
          _controller = controller;
        },
      ),
    );
  }
}
 */
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapa extends StatefulWidget {
  const Mapa({Key? key}) : super(key: key);

  @override
  _MapaState createState() => _MapaState();
}

class _MapaState extends State<Mapa> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _markers = {};

  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    _markers.add(
      Marker(
        markerId: MarkerId('value'),
        position: _center,
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: 'Ubicación',
          snippet: 'Esta es la ubicación',
        ),
      ),
    );
  }

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType =
      _currentMapType == MapType.normal ? MapType.satellite : MapType.normal;
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(_lastMapPosition.toString()),
          position: _lastMapPosition,
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(
            title: 'Marcador agregado',
            snippet: 'Latitud:${_lastMapPosition.latitude}, Longitud:${_lastMapPosition.longitude}',
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            mapType: _currentMapType,
            markers: _markers,
            onCameraMove: _onCameraMove,
          ),
          Positioned(
            top: 20.0,
            right: 15.0,
            child: FloatingActionButton(
              onPressed: _onMapTypeButtonPressed,
              tooltip: 'Cambiar tipo de mapa',
              backgroundColor: Colors.green,
              child: Icon(Icons.map),
            ),
          ),
          Positioned(
            bottom: 20.0,
            right: 15.0,
            child: FloatingActionButton(
              onPressed: _onAddMarkerButtonPressed,
              tooltip: 'Agregar marcador',
              backgroundColor: Colors.red,
              child: Icon(Icons.add_location),
            ),
          ),
        ],
      ),
    );
  }
}


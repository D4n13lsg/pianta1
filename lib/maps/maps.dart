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

/*import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';



// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoiZGFuaWVsc2cxOCIsImEiOiJjbGZ1N3F6ZWcwNDByM2Vtamo1OTNoc3hrIn0.5dFY3xEDB7oLtMbCWDdW9A';

final myPosition = LatLng(40.697488, -73.979681);

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.black26, //color of divider
            height: 4, //height spacing of divider
            thickness: 1, //thickness of divier line
            indent: 15, //spacing at the start of divider
            endIndent: 0,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, // establecer el fondo transparente
        elevation: 0,
        title: const Text(
          'Location',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
        ),
      ),
      body: FlutterMap(
        options:
        MapOptions(center: myPosition, minZoom: 5, maxZoom: 25, zoom: 18),
        nonRotatedChildren: [
          TileLayer(
            urlTemplate:
            'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
            additionalOptions: const {
              'accessToken': MAPBOX_ACCESS_TOKEN,
              'id': 'mapbox/satellite-v9'
            },
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: myPosition,
                builder: (context) {
                  return Container(
                    child: const Icon(
                      Icons.person_pin,
                      color: Colors.blueAccent,
                      size: 40,
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
 */
/*import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ignore: constant_identifier_names
const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoiZGFuaWVsc2cxOCIsImEiOiJjbGZ1N3F6ZWcwNDByM2Vtamo1OTNoc3hrIn0.5dFY3xEDB7oLtMbCWDdW9A';

final myPosition = LatLng(40.697488, -73.979681);

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.black26, //color of divider
            height: 4, //height spacing of divider
            thickness: 1, //thickness of divier line
            indent: 15, //spacing at the start of divider
            endIndent: 0,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent, // establecer el fondo transparente
        elevation: 0,
        title: const Text(
          'Location',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context, 'Valor enviado a la página anterior');
        },
        label: const Text('Salida'),
        icon: const Icon(Icons.exit_to_app),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FlutterMap(
          options:
              MapOptions(center: myPosition, minZoom: 5, maxZoom: 25, zoom: 18),
          nonRotatedChildren: [
            TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
              additionalOptions: const {
                'accessToken': MAPBOX_ACCESS_TOKEN,
                'id': 'mapbox/satellite-v9'
              },
            ),
          ],
        ),
      ),
    );
  }
}
 */



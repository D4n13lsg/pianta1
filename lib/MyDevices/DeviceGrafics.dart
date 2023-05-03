/*import 'package:flutter/material.dart';
import 'package:pianta/Funciones/constantes.dart';

class DeviceGrafics extends StatefulWidget {
  const DeviceGrafics({Key? key}) : super(key: key);

  @override
  State<DeviceGrafics> createState() => _DeviceGraficsState();
}

class _DeviceGraficsState extends State<DeviceGrafics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SizedBox(
            width: 100,
            child: Navigation(title: 'nav', selectedIndex: 0 /* Fundamental SelectIndex para que funcione el selector*/),
          ),
          Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding( padding: EdgeInsets.all(10),
                        child: Text(
                          'Name Device Grafics',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black26, //color of divider
                    height: 2, //height spacing of divider
                    thickness: 1, //thickness of divider line
                    indent: 15, //spacing at the start of divider
                    endIndent: 0, //spacing at the end of divider
                  ),
                    Expanded(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(Icons.person_2_outlined, size: 100),
                              title: Text(' Device Name', style: TextStyle(fontSize: 40)),
                            )
                          ],
                        )
                    )
                ],
              )
          )
        ],
      ),
    );
  }
}
 */
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:math';

// ignore: camel_case_types
//grafica circular

class SensorData {
  final String name;
  final DateTime createdAt;
  final double v12;

  SensorData({
    required this.name,
    required this.createdAt,
    required this.v12,
  });

  factory SensorData.fromJson(Map<String, dynamic> json) {
    return SensorData(
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      v12: json['v12'],
    );
  }
}

class Device {
  int id;
  final String name;
  final String location;
  Device({
    required this.id,
    required this.name,
    required this.location,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'],
      name: json['name'],
      location: json['location'],
    );
  }
}

List<Device> devices = <Device>[];

List<SensorData> device = [];

class DeviceGrafics extends StatefulWidget {
  const DeviceGrafics({super.key});

  @override
  State<DeviceGrafics> createState() => _DeviceGraficsState();
}

class _DeviceGraficsState extends State<DeviceGrafics>
    with SingleTickerProviderStateMixin {
  //firebase

  bool isLoading = false;

  //final FirebaseDatabase _database = FirebaseDatabase.instance;

  late AnimationController _animationController;
  late Animation<double> _animation;
  final maxProgress = 100.0;
  double v12 = 0.0;
  SensorData? selectedDevice;
  Map<String, dynamic>? apiData;
  late Future<List<SensorData>> _fetchDevicesFuture;

  Future<void> _fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('http://127.0.0.1:8000/user/datos-sensores/v12/'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          apiData = data;
        });
        print('v12 value: ${apiData![0]['v12']}');
      } else {
        // Handle the error
      }
    } catch (e) {
      // Handle the error
    }
  }

  Future<List<SensorData>> fetchDevices() async {
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/user/datos-sensores/v12/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<SensorData> devices = [];
      for (var item in data) {
        devices.add(SensorData.fromJson(item));
      }
      setState(() {
        device = devices;
        selectedDevice = devices.isNotEmpty ? devices[0] : null;
      });
      print('Sensor data: ${devices[0].v12}');
      return devices;
    } else {
      throw Exception('Failed to load devices');
    }
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
    _animation =
        Tween<double>(begin: 0, end: maxProgress).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
    _fetchData();
    _fetchDevicesFuture = fetchDevices();
    super.initState();

    // Programamos la actualización cada 5 segundos
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _fetchDevicesFuture = fetchDevices();
      });
    });
  }

  @override
  void dispose() {
    // Cancelamos el timer cuando se destruye el widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lastData = device.isNotEmpty ? device.last : null;
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Name Device Grafics',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.black),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(
                              context, 'Valor enviado a la página anterior');
                        },
                        icon: const Icon(Icons.exit_to_app),
                      ),
                    ],
                  ),
                  const Divider(
                    color: Colors.black26,
                    height: 2,
                    thickness: 1,
                    indent: 15,
                    endIndent: 0,
                  ),
                  Expanded(
                    child: Card(
                      margin: const EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            /* const ListTile(
                              leading: Icon(Icons.person_2_outlined, size: 100),
                              title: Text('Device Name',
                                  style: TextStyle(fontSize: 40)),
                            ),

                            */
                            SizedBox(height: 16),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomPaint(
                                    painter: CircularGraphicsPainter(
                                        lastData?.v12 ?? 0.0),
                                    child: Container(
                                      width: 300,
                                      height: 300,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (_animationController.value ==
                                              maxProgress) {
                                            _animationController.reverse();
                                          } else {
                                            _animationController.forward();
                                          }
                                        },
                                        child: Center(
                                          child: lastData == null
                                              ? Text('No data available')
                                              : Text('${lastData.v12} °C',
                                                  style: const TextStyle(
                                                      fontSize: 50)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 300.0,
                                    width: 300.0,
                                    child: Linea_Graphics(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircularGraphicsPainter extends CustomPainter {
  final double currentProgress;

  CircularGraphicsPainter(this.currentProgress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()
      ..strokeWidth = 5
      ..color = Colors.black
      ..style = PaintingStyle.stroke;

    Offset center = Offset(
      size.width / 2,
      size.height / 2,
    );
    double radius = 150;
    canvas.drawCircle(center, radius, circle);

    Paint animationArc = Paint()
      ..strokeWidth = 5
      ..color = Colors.purpleAccent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double angle = 2 * pi * (currentProgress / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), pi / 2,
        angle, false, animationArc);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

//grafica dias. lineal
class Linea_Graphics extends StatelessWidget {
  const Linea_Graphics({super.key});

  @override
  Widget build(BuildContext context) {
    final data = [
      Expenses(0, 0),
      Expenses(0, 0),
      Expenses(0, 0),
      Expenses(0, 0),
      Expenses(0, 0),
      Expenses(0, 0),
      Expenses(0, 0),
    ];
    final series = [
      charts.Series(
        id: 'Expenses',
        data: data,
        domainFn: (Expenses expenses, _) => expenses.day,
        measureFn: (Expenses expenses, _) => expenses.amount,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        labelAccessorFn: (Expenses expenses, _) =>
            '${expenses.day}: \$${expenses.amount}',
      ),
    ];

    final chart = charts.LineChart(
      series,
      animate: true,
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: chart,
    );
  }
}

class Expenses {
  final int day;
  final int amount;

  Expenses(this.day, this.amount);
}
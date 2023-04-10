import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pianta/MyDevices/New_Devices.dart';

class Devices {
  final int id;
  final String name;
  final String location;

  Devices({required this.id, required this.name, required this.location});

  factory Devices.fromJson(Map<String, dynamic> json) {
    return Devices(
      id: json['id'],
      name: json['name'],
      location: json['location'],
    );
  }
}

class MyDevice extends StatefulWidget {
  const MyDevice({Key? key}) : super(key: key);

  @override
  State<MyDevice> createState() => _MyDeviceState();
}

class _MyDeviceState extends State<MyDevice> {
  List<Devices> _devices = [];

  @override
  void initState() {
    super.initState();
    _getDevices();
  }

  Future<void> _getDevices() async {
    final url = Uri.parse('http://127.0.0.1:8000/user/devices/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        _devices = (json.decode(response.body) as List)
            .map((e) => Devices.fromJson(e))
            .toList();
      });
    } else {
      throw Exception('Failed to load devices');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(
            color: Colors.black26,
            //color of divider
            height: 4,
            //height spacing of divider
            thickness: 1,
            //thickness of divier line
            indent: 15,
            //spacing at the start of divider
            endIndent: 0,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        // establecer el fondo transparente
        elevation: 0,
        title: const Text(
          'My Devices',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
        ),
        actions: [
          Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    primary: Color.fromRGBO(0, 191, 174, 1)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewDevice()),
                  );
                },
                child: Row(
                  children: const [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "+New Device",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
      body: _devices.isEmpty
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _devices.length,
        itemBuilder: (context, index) {
          final device = _devices[index];
          return ListTile(
            title: Text(device.name),
            subtitle: Text(device.location),
            onTap: () {
              // Aquí se puede agregar la navegación para mostrar los detalles del dispositivo.
            },
          );
        },
      ),
    );
  }
}
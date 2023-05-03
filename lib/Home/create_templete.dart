/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pianta/Home/Home.dart';
import 'package:http/http.dart' as http;
import 'package:pianta/Home/templates.dart';

class Project {
  final String name;
  final String sensor;
  final String location;

  Project({
    required this.name,
    required this.location,
    required this.sensor,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'description': sensor,
    };
  }
}

class CreateTemplate extends StatefulWidget {
  const CreateTemplate({Key? key}) : super(key: key);

  @override
  State<CreateTemplate> createState() => _CreateTemplateState();
}

// ignore: camel_case_types
class _CreateTemplateState extends State<CreateTemplate> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _sensorController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _sensorController.dispose();
    super.dispose();
  }

  Future<void> _addProject() async {
    final url = Uri.parse('http://127.0.0.1:8000/user/template/');
    final headers = {'Content-Type': 'application/json'};
    final project = Project(
      name: _nameController.text,
      location: '',
      sensor: _sensorController.text,
    );
    final body = json.encode(project.toMap());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al agregar el proyecto'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> guardarSeleccion(List<String> opcionesSeleccionadas) async {
    var url = Uri.parse('http://127.0.0.1:8000/user/template/');

    var data = {'opciones': opcionesSeleccionadas};

    var body = jsonEncode(data);

    var response = await http
        .post(url, body: body, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print('Datos guardados en la API');
    } else {
      print('Error al guardar datos en la API');
    }
  }

  List<String> listaDeOpciones = <String>[
    "ESP 32",
    "ESP 8266",
    "3",
  ];
  List<String> listaDeConexion = <String>[
    "WiFi",
    "Ethernet",
    "USB",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
              child: Card(
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: SizedBox(
                    width: 900,
                    height: 450,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Create New Template',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                  textAlign: TextAlign.left)
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'NAME',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          TextFormField(
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 16, 12, 16),
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.top,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter content';
                              }
                              return null;
                            },
                            controller: _nameController,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'HARDWARE',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          DropdownButtonFormField(
                            items: listaDeOpciones.map((e) {
                              return DropdownMenuItem(child: Text(e), value: e);
                            }).toList(),
                            onChanged: (String? value) {
                              if (value != null) {
                                guardarSeleccion([value]);
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Seleccione una opción'),
                          ),
                          DropdownButtonFormField(
                            items: listaDeConexion.map((e) {
                              return DropdownMenuItem(child: Text(e), value: e);
                            }).toList(),
                            onChanged: (String? value) {
                              if (value != null) {
                                guardarSeleccion([value]);
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Seleccione una conexión'),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'DESCRIPTION',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          TextFormField(
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  EdgeInsets.fromLTRB(12, 16, 12, 16),
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                            textAlign: TextAlign.left,
                            textAlignVertical: TextAlignVertical.top,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter content';
                              }
                              return null;
                            },
                            controller: _locationController,
                          ),
                          const SizedBox(height: 35.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Home(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(90, 30),
                                    backgroundColor:
                                        Color.fromRGBO(255, 255, 255, 1)),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(16, 16, 16, 1)),
                                ),
                              ),
                              const SizedBox(
                                width:
                                    25, // Espacio de 16 píxeles entre los botones
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _addProject();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Home(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(90, 30),
                                  backgroundColor:
                                      Color.fromRGBO(0, 191, 174, 1),
                                ),
                                child: const Text(
                                  'Done',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))),
        ),
      ),
    );
  }
}
 */
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateTemplate extends StatefulWidget {
  const CreateTemplate({Key? key}) : super(key: key);

  @override
  State<CreateTemplate> createState() => _CreateTemplateState();
}

class _CreateTemplateState extends State<CreateTemplate> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sensorController = TextEditingController();
  final _descriptionController = TextEditingController();

  String? _selectedSensorOption; // added this line
  String? _selectedRedOption;

  List<String> _sensorOptions = ["ESP32", "SP23", "Option"];
  List<String> _redOptions = ["WiFi", "Ethernet", "USB"];

  Future<void> guardarSeleccion(List<String> opcionesSeleccionadas) async {
    var url = Uri.parse('http://127.0.0.1:8000/user/template/');

    var data = {'opciones': opcionesSeleccionadas};

    var body = jsonEncode(data);

    var response = await http
        .post(url, body: body, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      print('Datos guardados en la API');
    } else {
      print('Error al guardar datos en la API');
    }
  }

  Future<void> _addProject() async {
    final url = Uri.parse('http://127.0.0.1:8000/user/template/');
    final headers = {'Content-Type': 'application/json'};
    final project = Project(
      name: _nameController.text,
      descripcion: _descriptionController.text,
      sensor:
          _selectedSensorOption!, // convertir el valor seleccionado en una lista
      red: _selectedRedOption!,
    );
    final body = json.encode(project.toMap());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding project'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sensorController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              width: 900,
              height: 500,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16.0),
                        const Text(
                          'Create New Template',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        const Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0, // Se ha cambiado el tamaño a 14.0
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'Enter the Project Name',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'HARDWARE',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10.0,
                                ),
                              ),
                              DropdownButtonFormField<String>(
                                value: _selectedSensorOption,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedSensorOption = newValue;
                                  });
                                },
                                items: _sensorOptions
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16.0),
                        Flexible(
                          flex: 1,
                          child: DropdownButtonFormField<String>(
                            value: _selectedRedOption,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedRedOption = newValue;
                              });
                            },
                            decoration: const InputDecoration(
                              labelText: 'WIFI',
                            ),
                            items: _redOptions
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DESCRIPTION',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                            hintText: 'Enter the project description',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a description for the project';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        SizedBox(width: 16), // Agregar espacio horizontal
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await _addProject();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(0, 191, 174, 1),
                          ),
                          child: const Text(
                            'DONE',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Project {
  final String name;
  final String descripcion;
  final String sensor;
  final String red;

  Project(
      {required this.name,
      required this.descripcion,
      required this.sensor,
      required this.red});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'descripcion': descripcion,
      'sensor': sensor,
      'red': red,
    };
  }
}

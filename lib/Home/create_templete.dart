import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pianta/Home/Home.dart';
import 'package:http/http.dart' as http;

/*class Project {
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

  Future<void> _addProject(Project project) async {
    final url = Uri.parse('http://127.0.0.1:8000/user/template/');
    final headers = {'Content-Type': 'application/json'};
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


  List<String> listaDeOpciones = <String>["ESP 32","ESP 8266","3",];
  List<String> listaDeConexion = <String>["WiFi","Ethernet","USB",];

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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey), //<-- SEE HERE
                                ),
                              ),
                            ),
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
                            items:listaDeOpciones.map((e){
                              // Ahora creamos "e" y contiene cada uno de los items de la lista.
                              return DropdownMenuItem(
                                  child: Text(e),
                                  value: e
                              );
                            }).toList(),
                            onChanged: (String? value) { },
                          ),
                          DropdownButtonFormField(
                            items:listaDeConexion.map((e){
                              // Ahora creamos "e" y contiene cada uno de los items de la lista.
                              return DropdownMenuItem(
                                  child: Text(e),
                                  value: e
                              );
                            }).toList(),
                            onChanged: (String? value) { },
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.grey), //<-- SEE HERE
                                ),
                              ),
                            ),
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
                                    backgroundColor: Color.fromRGBO(255, 255, 255, 1)),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromRGBO(16, 16, 16, 1)),
                                ),
                              ),
                              const SizedBox(
                                width: 25, // Espacio de 16 píxeles entre los botones
                              ),
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
                                  backgroundColor: Color.fromRGBO(0, 191, 174, 1),
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
                  )
              )
          ),
        ),
      ),
    );
  }
}
 */

/*import 'package:flutter/material.dart';
import 'package:pianta/Home/create_templete.dart';

//clase creada para la pantalla donde aparecen los templates
class Templates extends StatefulWidget {
  const Templates({Key? key}) : super(key: key);

  @override
  State<Templates> createState() => _TemplatesState();
}

class _TemplatesState extends State<Templates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        //Modulo 1° Texto inicial
        //se tomara una fila para poder ubicarlo
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //texto inicial de la pagina
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Templates',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(19.0),
              //boton
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    //accion que permitira al dar click retornar al login
                    MaterialPageRoute(builder: (context) => CreateTemplate()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(
                        0, 191, 174, 1) // Color de fondo del botón
                    ),
                //texto que aparecera en el boton
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(width: 5),
                    Text('+New Template'),
                  ],
                ),
              ),
            ),
          ],
        ), //fin modulo 1°

        //Modulo 2° linea divisoria
        //linea divisoria para separar titulo y botones iniciales de las card de los templates
        const Divider(
          color: Colors.black26, //color of divider
          height: 2, //height spacing of divider
          thickness: 1, //thickness of divier line
          indent: 15, //spacing at the start of divider
          endIndent: 0, //spacing at the end of divider
        ), //fin modulo 2°

        //Modulo 3° card para templates creados
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: SizedBox(
              width: 260,
              height: 300,
              child: Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        width: 260,
                        height: 350,
                        color: Colors.white, // color de la primera mitad
                      ),
                    ),
                    Expanded(
                      child: Container(
                          width: 260,
                          height: 1,
                          color: const Color.fromRGBO(0, 191, 174, 1),
                          child: const ListTile(
                              title: Text('Template Name',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 30)),
                              subtitle: Text('Connected device',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize:
                                          20))) // color de la segunda mitad
                          ),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ],
    ));
  }
}
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Home.dart';
import 'new_project.dart';

//el Project es lo que esta en la api
class Project {
  int id;
  final String name;
  int sensor;
  final String location;

  Project({
    required this.id,
    required this.name,
    required this.sensor,
    required this.location,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      name: json['name'] ,
      sensor : json['sensor'],
      location: json['location'],
    );
  }
}


List<Project> projects = [];

class Templates extends StatefulWidget {
  const Templates({Key? key}) : super(key: key);

  @override
  State<Templates> createState() => _TemplatesState();
}

class _TemplatesState extends State<Templates> {
  late Timer timer;
  List<Project> projects = [];
  late Future<List<Project>> futureProjects;
  final projectListKey = GlobalKey<_TemplatesState>();
  late String idrandomValue; // nuevo

  @override
  void initState() {
    super.initState();
    futureProjects = fetchProjects();
    idrandomValue = "1";
  }

//esto es para mostrar la card
  Future<List<Project>> fetchProjects() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/user/template/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<Project> projects =
          jsonList.map((json) => Project.fromJson(json)).toList();
      //esto refresca el proyecto para ver los cambios
      await refreshProjects();
      return projects;
    } else {
      throw Exception('Failed to load project list');
    }
  }

  Future<void> refreshProjects() async {
    setState(() {
      futureProjects = fetchProjects();
    });
  }
  //esto es para meter el id para el guardar un proyecto

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
          backgroundColor:
              Colors.transparent, // establecer el fondo transparente
          elevation: 0,
          title: const Text(
            'Proyecto',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
          ),
          actions: [
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      primary: Color.fromRGBO(0, 191, 174, 1)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddProjectScreen()),
                    );
                  },
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "+New Project",
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
        key: projectListKey,
        body: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              futureProjects = fetchProjects();
            });
          },
          child: FutureBuilder<List<Project>>(
            future: futureProjects,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final projects = snapshot.data!;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).size.width > 1200
                        ? 5
                        : MediaQuery.of(context).size.width > 800
                            ? 4
                            : MediaQuery.of(context).size.width > 600
                                ? 3
                                : 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: projects.length,
                  itemBuilder: (BuildContext context, int index) {
                    final project = projects[index];
                    return Card(
                      child: ListTile(
                        title: Text(project.name),
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}


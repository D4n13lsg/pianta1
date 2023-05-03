import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pianta/Funciones/constantes.dart';
import 'package:pianta/MyDevices/My_Devices.dart';
import '../constants.dart';
import 'new_project.dart';

//el Project es lo que esta en la api
class Project {
  int id;
  final String idrandom;
  final String name;
  //final String location;
  final String description;

  Project({
    required this.id,
    required this.idrandom,
    required this.name,
    //required this.location,
    required this.description,
  })  : assert(id != null),
        assert(idrandom != null),
        assert(name != null),
       // assert(location != null),
        assert(description != null);

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      idrandom: json['idrandom'],
      name: json['name'] ?? '',
      //location: json['location'] ?? '',
      description: json['description'] ?? '',
    );
  }
}

List<Project> projects = [];


class Proyectos extends StatefulWidget {
  const Proyectos({Key? key}) : super(key: key);

  @override
  State<Proyectos> createState() => _ProyectosState();
}

class _ProyectosState extends State<Proyectos> {

  List<Project> projects = [];
  late Future<List<Project>> futureProjects;
  final projectListKey = GlobalKey<_ProyectosState>();
  late String idrandomValue; // nuevo
  late Future<List<Project>> _fetchDevicesFuture;
  @override
  void initState() {
    super.initState();
    futureProjects = fetchProjects();
    idrandomValue = "1";
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _fetchDevicesFuture = fetchProjects();
      });
    });
  }

//esta Future es para eliminar el projecto por medio del id
  Future<void> deleteProject(int projectId) async {
    var box = await Hive.openBox(tokenBox);
    final token = box.get("token") as String?;
    final response = await http
        .delete(Uri.parse('http://127.0.0.1:8000/user/project/$projectId/'),
      headers: {'Authorization': 'Token $token'},
    );
    if (response.statusCode == 204) {
      print('Project deleted successfully');
      await refreshProjects();
    } else {
      throw Exception('Failed to delete project');
    }
  }

  void createNewCard(String idrandom) async {
    var box = await Hive.openBox(tokenBox);
    final token = box.get("token") as String?;
    // 1. Obtener el proyecto específico usando el `idrandom`.
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/user/project/$idrandom/'),
      headers: {'Authorization': 'Token $token'},
    );
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body)[0];
      final project = Project.fromJson(json);

      // 2. Crear una nueva instancia de `Project` con los mismos valores del proyecto obtenido anteriormente.
      final newProject = Project(
        id: project.id,
        idrandom: project.idrandom,
        name: project.name,
        description: project.description,
      );

      // 3. Agregar la nueva instancia de `Project` a la lista de proyectos existente.
      setState(() {
        projects.add(newProject);
      });
      await refreshProjects();
    } else {
      throw Exception('Failed to load project');
    }
  }

//esto es para mostrar la card
  Future<List<Project>> fetchProjects() async {
    var box = await Hive.openBox(tokenBox);
    final token = box.get("token") as String?;
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/user/project/'),
            headers: {'Authorization': 'Token $token'},
        );

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
        key: projectListKey,
        body: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                futureProjects = fetchProjects();
              });
            },
          child: Row(
            children: [
              //llamado de la barra
              const SizedBox(
                width: 100,
                child: Navigation(title: 'nav', selectedIndex: 0 /* Fundamental SelectIndex para que funcione el selector*/),
              ),
              Expanded(
                  child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding( padding: EdgeInsets.all(10),
                                child: Text(
                                'Project',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
                              ),
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        String enteredCode = '';
                                        return AlertDialog(
                                          title: const Text('Project Created'),
                                          content: SizedBox(
                                            width: 500,
                                            height: 100,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text('Project ID:'),
                                                TextField(
                                                  onChanged: (value) {
                                                    enteredCode = value;
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                                            ),
                                            const Spacer(),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                const Color.fromRGBO(0, 191, 174, 1),
                                              ),
                                              onPressed: () {
                                                createNewCard(enteredCode);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Accept'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5), backgroundColor: const Color.fromRGBO(255, 255, 255, 1.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: const Text(
                                    "Open Project",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5), backgroundColor: Color.fromRGBO(0, 191, 174, 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      )),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Container(
                                              width: MediaQuery.of(context).size.width * 0.7,
                                              height: MediaQuery.of(context).size.height * 0.9,
                                              child: Column(
                                                children: [
                                                  Expanded(child: AddProjectScreen()),
                                                ],
                                              )
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Text(
                                    "+New Project",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.black26, //color of divider
                          height: 4, //height spacing of divider
                          thickness: 1, //thickness of divier line
                          indent: 15, //spacing at the start of divider
                          endIndent: 0,
                        ),
                        Expanded(
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
                                    return Container(
                                      height: 1200,
                                      child: Card(
                                        color: Color.fromRGBO(0, 191, 174, 1),
                                        child: Padding(
                                          padding: EdgeInsets.all(0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: new EdgeInsets.all(0),
                                                height: 100,
                                                decoration: new BoxDecoration(
                                                  border: new Border.all(color: Colors.white),
                                                  color: Colors.white,
                                                ),
                                              ),
                                              ListTile(
                                                title: Text(
                                                  project.name,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                onTap: () {
                                                  // Navegar a la pantalla de detalles del proyecto
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => MyDevice()),
                                                  );
                                                },
                                              ),
                                              Align(
                                                alignment: Alignment.bottomRight,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons.delete),
                                                      onPressed: () async {
                                                        bool confirmDelete = await showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              title: Text(
                                                                  "Do you want to delete this project?"),
                                                              content: Text(
                                                                project.name,
                                                                textAlign: TextAlign.center,
                                                              ),
                                                              actions: <Widget>[
                                                                Align(
                                                                  alignment: Alignment
                                                                      .bottomRight, // Align buttons to bottom right corner
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      ElevatedButton(
                                                                        onPressed: () =>
                                                                            Navigator.of(context).pop(true),
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          minimumSize:
                                                                          const Size(
                                                                              100, 30),
                                                                          backgroundColor:
                                                                          const Color
                                                                              .fromRGBO(242, 23, 23, 1),
                                                                        ),
                                                                        child: const Text(
                                                                          'Delete',
                                                                          textAlign:
                                                                          TextAlign.center,
                                                                          style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight.bold,
                                                                            fontSize: 12,
                                                                            color: Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(), // Add some space between buttons
                                                                      ElevatedButton(
                                                                        onPressed: () {
                                                                          Navigator.pop(context, false);
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          minimumSize:
                                                                          const Size(
                                                                              100, 30),
                                                                          backgroundColor:
                                                                          const Color
                                                                              .fromRGBO(0, 191, 174, 1),
                                                                        ),
                                                                        child: const Text(
                                                                          'Cancel',
                                                                          textAlign:
                                                                          TextAlign.center,
                                                                          style: TextStyle(
                                                                            fontWeight:
                                                                            FontWeight.bold,
                                                                            fontSize: 12,
                                                                            color: Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                        if (confirmDelete == true) {
                                                          try {
                                                            await deleteProject(project.id);
                                                            setState(() {
                                                              projects.remove(project);
                                                            });
                                                          } catch (e) {
                                                            print("Error deleting project: $e");
                                                          }
                                                        }
                                                      },
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons.share),
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return AlertDialog(
                                                              title: Text("Random ID"),
                                                              content: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                                children: [
                                                                  Text(project.idrandom),
                                                                  IconButton(
                                                                    icon: Icon(Icons.copy),
                                                                    onPressed: () {
                                                                      //se guarda en el porta papeles
                                                                      Clipboard.setData(
                                                                          ClipboardData(
                                                                              text: project
                                                                                  .idrandom));
                                                                      ScaffoldMessenger.of(
                                                                          context)
                                                                          .showSnackBar(
                                                                        SnackBar(
                                                                            content: Text(
                                                                                "code copied to clipboard")),
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  child: Text("Close"),
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              // By default, show a loading spinner
                              return Center(child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      ]
                  )
              )
            ]
          )
        ),
    );
  }
}
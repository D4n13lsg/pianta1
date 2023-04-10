import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pianta/Home/project_created.dart';
import 'package:pianta/MyDevices/My_Devices.dart';

import 'Home.dart';
import 'new_project.dart';

//el Project es lo que esta en la api
class Project {
  int id;
  final String idrandom;
  final String name;
  final String description;

  Project({
    required this.id,
    required this.idrandom,
    required this.name,
    required this.description,
  })  : assert(id != null),
        assert(name != null),
        assert(description != null);

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      idrandom: json['idrandom'],
      name: json['name'] ?? '',
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
  late Timer timer;
  List<Project> projects = [];
  late Future<List<Project>> futureProjects;
  final projectListKey = GlobalKey<_ProyectosState>();
  late String idrandomValue; // nuevo

  @override
  void initState() {
    super.initState();
    futureProjects = fetchProjects();
    idrandomValue = "1";
  }

//esta Future es para eliminar el projecto por medio del id
  Future<void> deleteProject(int projectId) async {
    final response = await http
        .delete(Uri.parse('http://127.0.0.1:8000/user/project/$projectId/'));
    if (response.statusCode == 204) {
      print('Project deleted successfully');
      await refreshProjects();
    } else {
      throw Exception('Failed to delete project');
    }
  }

  void createNewCard(String idrandom) async {
    // 1. Obtener el proyecto específico usando el `idrandom`.
    final response = await http
        .get(Uri.parse('http://127.0.0.1:8000/user/project/$idrandom/'));
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
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/user/project/'));
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
                                const Text('ID del proyecto:'),
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
                              child: const Text('Cancelar'),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                createNewCard(enteredCode);
                                Navigator.of(context).pop();
                              },
                              child: const Text('Aceptar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    primary: const Color.fromRGBO(255, 255, 255, 1.0),
                  ),
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Crear Proyecto",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
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
                        subtitle: Text(project.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("ID Aleatorio"),
                                      content: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(project.idrandom),
                                          IconButton(
                                            icon: Icon(Icons.copy),
                                            onPressed: () {
                                              //se guarda en el porta papeles
                                              Clipboard.setData(ClipboardData(
                                                  text: project.idrandom));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        "Código copiado al portapapeles")),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text("Cerrar"),
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
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                                bool confirmDelete = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Do you want to delete this project"),
                                      content: Text(
                                        project.name,
                                        textAlign: TextAlign.center,
                                      ),
                                      actions: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              style: ElevatedButton.styleFrom(
                                                minimumSize:
                                                    const Size(100, 30),
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        242, 23, 23, 1),
                                              ),
                                              child: const Text(
                                                'Delete',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                minimumSize:
                                                    const Size(100, 30),
                                                backgroundColor:
                                                    const Color.fromRGBO(
                                                        0, 191, 174, 1),
                                              ),
                                              child: const Text(
                                                'Cancel',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
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
                          ],
                        ),
                        onTap: () {
                          // Navigate to project details screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyDevice()),
                          );
                        },
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

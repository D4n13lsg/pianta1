import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'new_project.dart';

class Project {
  String cardId = Uuid().v4();
  final String name;
  final String description;

  Project({ required this.name, required this.description});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'],
      description: json['description'],
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

  @override
  void initState() {
    super.initState();
    futureProjects = fetchProjects();
  }

  Future<List<Project>> fetchProjects() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/user/project/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      final List<Project> projects =
          jsonList.map((json) => Project.fromJson(json)).toList();
      return projects;
    } else {
      throw Exception('Failed to load project list');
    }
  }


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
                  onPressed: () async {},
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      primary: Color.fromRGBO(255, 255, 255, 1.0)),
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Proyecto Create",
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
        body: Center(
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
                    /*return Card(
                      child: ListTile(
                        title: Text(project.name),
                        subtitle: Text(project.description),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await deleteProject(index);
                          },
                        ),
                        onTap: () {
                          // Navigate to project details screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ProjectDetailsScreen(project: project)),
                          );
                        },
                      ),
                    );
                     */
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(project.name),
                            subtitle: Text(project.description),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () async {
                              },
                            ),
                            onTap: () {
                              // Navigate to project details screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ProjectDetailsScreen(project: project),
                                ),
                              );
                            },
                          ),
                        ],
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

class ProjectDetailsScreen extends StatelessWidget {
  final Project project;

  ProjectDetailsScreen({required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(project.description),
      ),
    );
  }
}

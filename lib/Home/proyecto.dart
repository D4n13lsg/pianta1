/*import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pianta/Cards/card.dart';

import 'package:pianta/Funciones/delete_project.dart';
import 'package:pianta/Funciones/share_project.dart';
import 'package:pianta/Home/new_project.dart';
import 'package:pianta/Home/project_created.dart';

class CardModel {
  String title;
  String content;
  DateTime createdAt;

  CardModel({
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}


//clase para craer la pagina proyecto
class Proyectos extends StatefulWidget {
  const Proyectos({Key? key}) : super(key: key);

  @override
  State<Proyectos> createState() => _ProyectosState();
}

class _ProyectosState extends State<Proyectos> {

  List<CardModel> _cards = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartas'),
          backgroundColor: const Color.fromRGBO(
              255, 255, 255, 1)

      ),
      body: ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final card = _cards[index];
          return Card(
            child: ListTile(
              title: Text(card.title),
              subtitle: Text(card.content),
              trailing: Text(card.createdAt.toString()),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newCard = await Navigator.push<CardModel>(
            context,
            MaterialPageRoute(builder: (context) => NewCardPage()),
          );
          if (newCard != null) {
            setState(() {
              _cards.add(newCard);
            });
            _guardarCartas();
          }
        },
        child: Icon(Icons.add),
      ),


    );
  }
  Future<void> _cargarCartas() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/cards.json');
      final content = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(content);
      final List<CardModel> cards =
      jsonList.map((json) => CardModel.fromJson(json)).toList();
      setState(() {
        _cards = cards;
      });
    } catch (e) {
      print('Error al cargar las cartas: $e');
    }
  }

  Future<void> _guardarCartas() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/cards.json');
      final List<dynamic> jsonList =
      _cards.map((card) => card.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error al guardar las cartas: $e');
    }
  }
}
class NewCardPage extends StatefulWidget {
  @override
  _NewCardPageState createState() => _NewCardPageState();
}

class _NewCardPageState extends State<NewCardPage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva carta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Título',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: 'Contenido',
              ),
              maxLines: null,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final content = _contentController.text;
                if (title.isNotEmpty && content.isNotEmpty) {
                  final newCard = CardModel(
                    title: title,
                    content: content,
                    createdAt: DateTime.now(),
                  );
                  Navigator.pop(context, newCard);
                }
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
 */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pianta/Funciones/constantes.dart';
import 'dart:convert';
import 'package:pianta/Home/project_created.dart';
import 'package:pianta/maps/maps2.dart';
import '../Funciones/delete_project.dart';
import '../Funciones/share_project.dart';
import '../maps/maps.dart';
import 'Home.dart';

class CardModel {
  String title;
  String content;

  CardModel({
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      title: json['title'],
      content: json['content'],
    );
  }
}

//clase para craer la pagina proyecto
class Proyectos extends StatefulWidget {
  const Proyectos({Key? key}) : super(key: key);

  @override
  State<Proyectos> createState() => _ProyectosState();
}

class _ProyectosState extends State<Proyectos> {
  List<CardModel> _cards = [];

  @override
  void initState() {
    super.initState();
    _cargarCartas();
  }
//eliminar card
  void _eliminarCarta(int index) {
    String title = _cards[index].title;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Do you want to delete this project?"),
          content: Text(
            "$title",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _cards.removeAt(index);
                    });
                    _guardarCartas();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 30),
                    backgroundColor: const Color.fromRGBO(242, 23, 23, 1),
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
                    minimumSize: const Size(100, 30),
                    backgroundColor: const Color.fromRGBO(0, 191, 174, 1),
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
        backgroundColor: Colors.transparent, // establecer el fondo transparente
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
                onPressed: () async {
                  final newCard = await Navigator.push<CardModel>(
                    context,
                    MaterialPageRoute(builder: (context) => ProjectCreated()),
                  );
                  if (newCard != null) {
                    setState(() {
                      _cards.add(newCard);
                    });
                    _guardarCartas();
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                onPressed: () async {
                  final newCard = await Navigator.push<CardModel>(
                    context,
                    MaterialPageRoute(builder: (context) => NewCardPage()),
                  );
                  if (newCard != null) {
                    setState(() {
                      _cards.add(newCard);
                    });
                    _guardarCartas();
                  }
                },
                style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    primary: Color.fromRGBO(0, 191, 174, 1)),
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;

          // Si el ancho de la pantalla es menor o igual a 600,
          // mostrar 2 columnas en el GridView
          if (width <= 600) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                final card = _cards[index];
                //esto funciona para la creacion de cards
                Container(
                  color: Colors.blue,
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(card.title),
                            subtitle: Text(card.content),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _eliminarCarta(index);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ShareProject();
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          // Si el ancho de la pantalla es mayor que 600,
          // mostrar 5 columnas en el GridView
          else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _cards.length,
              itemBuilder: (context, index) {
                final card = _cards[index];
                //esto funciona para la creacion de cards
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Text(
                            card.title,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _eliminarCarta(index);
                              //este showDialog funciona para que aparesca como alerta
                            },
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.share),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ShareProject();
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<void> _cargarCartas() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/cards.json');
      final content = await file.readAsString();
      final List<dynamic> jsonList = jsonDecode(content);
      final List<CardModel> cards =
          jsonList.map((json) => CardModel.fromJson(json)).toList();
      setState(() {
        _cards = cards;
      });
    } catch (e) {
      print('Error al cargar las cartas: $e');
    }
  }

  Future<void> _guardarCartas() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/cards.json');
      final List<dynamic> jsonList =
          _cards.map((card) => card.toJson()).toList();
      final jsonString = jsonEncode(jsonList);
      await file.writeAsString(jsonString);
    } catch (e) {
      print('Error al guardar las cartas: $e');
    }
  }
}

class NewCardPage extends StatefulWidget {
  @override
  _NewCardPageState createState() => _NewCardPageState();
}

class _NewCardPageState extends State<NewCardPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;
//creacion de la card
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Card(
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          margin: EdgeInsets.all(30.0),
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 900,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Create new project',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'NAME',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese un título';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _title = value!;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'DESCRIPTION',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 16),
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
                        onSaved: (value) {
                          _content = value!;
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'LOCATION',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MapScreen(),
                                ),
                              ); // Acción del botón "Location"
                            },
                            icon: Icon(Icons.location_on), // Icono del botón
                            label: Text('Location'),
                            style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(
                                    0, 191, 174, 1) // Color de fondo del botón
                                ), // Texto del botón
                          ),
                        ],
                      ),
                      const SizedBox(height: 50),
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
                              ); // Acción del botón "Cancelar"
                            },
                            child: Text('Cancelar'),
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(
                                    0, 191, 174, 1) // Color de fondo del botón
                                ), //
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                final newCard = CardModel(
                                  title: _title,
                                  content: _content,
                                );
                                Navigator.pop(context, newCard);
                              }
                            },
                            child: Text('Guardar'),
                            style: ElevatedButton.styleFrom(
                                primary: Color.fromRGBO(
                                    0, 191, 174, 1) // Color de fondo del botón
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
      ),
    );
  }
}

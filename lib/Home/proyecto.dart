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


/*@override
Widget build(BuildContext context) {
  return Scaffold(

    //se tomara una columna Para el resto de la pantalla a parte de la navbar llamada en (Home)
      body: Column(
        children: [
          //1° modulo ubicacion del texto
          //se tomara una fila para ubicar el texto centrado como se desea
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //texto inicial de la pagina
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Projects',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ), //fin modulo
              const SizedBox(height: 35),
              // 2° Modulo del boton projecto creado y boton de new project
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //creacion primer boton
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProjectCreated(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(90, 35),
                        backgroundColor: const Color.fromRGBO(
                            255, 255, 255, 1)),
                    child: const Text(
                      'Project Created',
                      style: TextStyle(
                          fontSize: 13, color: Color.fromRGBO(16, 16, 16, 1)),
                    ),
                  ),
                  //caja para poner un espacio
                  const SizedBox(width: 20),
                  //segundo boton
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(70, 35),
                      backgroundColor: const Color.fromRGBO(0, 191, 174, 1),
                    ),
                    //texto del segundo boton
                    child: const Text(
                      '+New Project',
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20)
                ],
              ),
            ],
          ),
          //cierre modulo 2°

          //Modulo 3° linea divisoria
          //linea divisoria para separar la informacion inicial de una pequeña seccion y el resto
          //de la pagina donde se hallaran los proyectos creados
          const Divider(
            color: Colors.black26,
            //color of divider
            height: 2,
            //height spacing of divider
            thickness: 1,
            //thickness of divier line
            indent: 15,
            //spacing at the start of divider
            endIndent: 0, //spacing at the end of divider
          ),


          //Modulo 4° las Card de proyectos guardados
          //se tomara una fila para poder ubicar la card donde queremos
          /*Row(
            mainAxisAlignment: MainAxisAlignment.start, children: [
          //espacio de margen paar la card
          Padding(
            padding: const EdgeInsets.all(19.0),
            child: SizedBox(
              //dimensiones de la card en general
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
                    Container(
                        color: const Color.fromRGBO(0, 191, 174, 1),
                        child: ListTile(
                          leading: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DeleteProject()),
                                ); // Acción cuando se presione el botón
                              },
                              child: const Icon(Icons.delete,
                                  size: 30, color: Colors.black)),
                          title: const Text('Projects Name',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30)),
                          trailing: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  //accion que le permitira llevar a la ppagina deseada con el click
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ShareProject()),
                                ); // Acción cuando se presione el botón
                              },
                              child: const Icon(Icons.share,
                                  size: 30, color: Colors.black)),
                        ) // color de la segunda mitad
                        ),
                  ],
                ),
              ),
            ),
          )

        ]),
         */
        ],
      ));
}

 */
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';



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
  void initState() {
    super.initState();
    _cargarCartas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartas'),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),

        actions: [

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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  primary: Colors.green, // Agregar color
                ),
                child: Row(
                  children: const [

                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "+New Project",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Create new project',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'NAME',
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
                  TextFormField(
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'DESCRIPTION',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingrese contenido';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _content = value!;
                    },
                  ),
                  TextFormField(
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'LOCATION',
                      border: OutlineInputBorder(),
                    ),

                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Acción del botón "Cancelar"
                        },
                        child: Text('Cancelar'),
                      ),
                      const SizedBox(width: 16),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final newCard = CardModel(
                              title: _title,
                              content: _content,
                              createdAt: DateTime.now(),
                            );
                            Navigator.pop(context, newCard);
                          }
                        },
                        child: Text('Guardar'),
                      ),
                    ],
                  ),
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }
}








import 'package:flutter/material.dart';

import 'package:pianta/Funciones/delete_project.dart';
import 'package:pianta/Funciones/share_project.dart';
import 'package:pianta/Home/new_project.dart';
import 'package:pianta/Home/project_created.dart';

//clase para craer la pagina proyecto
class Proyectos extends StatefulWidget {
  const Proyectos({Key? key}) : super(key: key);

  @override
  State<Proyectos> createState() => _ProyectosState();
}

class _ProyectosState extends State<Proyectos> {
  @override
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
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1)),
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
                        builder: (context) => const NewProject(),
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
        ), //cierre modulo 2°

        //Modulo 3° linea divisoria
        //linea divisoria para separar la informacion inicial de una pequeña seccion y el resto
        //de la pagina donde se hallaran los proyectos creados
        const Divider(
          color: Colors.black26, //color of divider
          height: 2, //height spacing of divider
          thickness: 1, //thickness of divier line
          indent: 15, //spacing at the start of divider
          endIndent: 0, //spacing at the end of divider
        ),

        //Modulo 4° las Card de proyectos guardados
        //se tomara una fila para poder ubicar la card donde queremos
        Row(
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
      ],
    ));
  }
}

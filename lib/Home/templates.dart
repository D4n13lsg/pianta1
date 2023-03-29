import 'package:flutter/material.dart';
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

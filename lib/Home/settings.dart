import 'package:flutter/material.dart';
import 'package:pianta/register/login.dart';
import 'package:pianta/Funciones/edit_setting.dart';

//clase creada para la pantalla de configuracion
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        //Modulo 1° texto inicial
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //se toma un row para poder ubicarlo segun diseño
            Row(children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                //texto al inico de la pagina
                child: Text(
                  'Name',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              //funcion que permite volver el iciono solo, un boton
              InkWell(
                //icono deseado
                child: Icon(Icons.list, size: 50),
                onTap: () {
                  Navigator.push(
                    context,
                    //accion que llevara al dar click a la pagina de editar la informacion
                    MaterialPageRoute(builder: (context) => EditInformation()),
                  );
                },
              )
            ]),

            //Modulo 2° boton de log out
            //espacio de margen del boton
            Padding(
              padding: const EdgeInsets.all(19.0),
              //boton
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    //accion que permitira al dar click retornar al login
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.white // Color de fondo del botón
                    ),
                //texto que aparecera en el boton
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.logout, color: Colors.black),
                    SizedBox(width: 5),
                    Text('Log Out', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            )
          ],
        ),

        //Modulo 3°
        //linea divisoria entre que separa el titulo y botones iniciales de las card que continen los templates creados
        const Divider(
          color: Colors.black26, //color of divider
          height: 2, //height spacing of divider
          thickness: 1, //thickness of divier line
          indent: 15, //spacing at the start of divider
          endIndent: 0, //spacing at the end of divider
        ),
      ],
    ));
  }
}

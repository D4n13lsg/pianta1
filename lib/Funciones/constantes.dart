import 'package:flutter/material.dart';
import 'package:pianta/Home/settings.dart';
import 'package:pianta/Home/templates.dart';
import 'package:pianta/register/login.dart';
import 'package:flutter/material.dart';
import 'package:pianta/Home/Home.dart';
import 'package:pianta/Home/proyecto.dart';
var myDefaultBackground = Colors.white;

var myAppBar = AppBar(
  title: const Center(child: Text(' C O M P A N N Y'),),
  actions: const [
  //imagen
  ],
);

//clase creada unicamente para la bara de navegacion
class Navigation extends StatefulWidget {
  const Navigation({super.key, required this.title});
  final String title;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  //variable int para instanciar la seleccion de las paginas a navegar
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //se toma una fila para crear la barra lateral
      body: Row(
        children:<Widget>[
          //SizedBox guarda la la barra de navegación para llamarla sin problema y evitar el desbordamiento de pixeles
          SizedBox(width: 100, child:
          //Item general para crear la NavBar
          NavigationRail(
            //este campo permite la seleccion de cada item
            selectedIndex: _selectedIndex,
            //tamaño de la NavBar
            minWidth: 100,
            elevation: 5,
            //llama la clase logo, (linea 84)
            leading: const logo(),
            //se genera el indicador cuando se de click cambiara el color de los iconos
            useIndicator: true,
            //se asigna el color al que cambiara
            indicatorColor: const Color.fromRGBO(0, 191, 174, 1),
            //anotacion que permitira ir a las paginas seleccionadas en la barra cuando se hace click
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            //se crean los item de la barra, con lo que va a contener
            destinations: const <NavigationRailDestination>[
              //primer item
              NavigationRailDestination(
                icon: Icon(Icons.search, color:Colors.black, size: 50),
                label: Text('Projects'),
              ),
              //segundo item
              NavigationRailDestination(
                icon: Icon(Icons.more_horiz, color: Colors.black, size: 50),
                label: Text('Temp'),
              ),
              //tercer item
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined, color: Colors.black, size: 50),
                label: Text('Settings'),
              ),
            ],
          ),

          ),
          //Expanded creado para instanciar y llamar a las paginas a las que se navegara dando click a los items
          Expanded(
            //funcion que ayuda a ubicar la lista de paginas a llamar en un solo child
              child: IndexedStack(
                //variable de seleccion
                index: _selectedIndex,
                children: const [
                  //llamado de las paginas
                  Proyectos(),
                  Templates(),
                  Settings()
                ],
              )
          )
        ],
      ),
    );
  }
}
//clase creada unicamente para poder visualizar y llamar el logo a la parte superior de los items
class logo extends StatelessWidget {
  const logo ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //child que contiene la imagen
      child: Image.asset('assets/logo_P.jpeg', width: 80),
    );
  }
}
//variable que contiene la clase y los metodos que tendra la bara de navegación para llamarla en otras clases
var myNav = const Navigation(title: 'Barra de Navegación');








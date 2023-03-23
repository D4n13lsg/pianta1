import 'package:flutter/material.dart';
import 'package:pianta/Funciones/constantes.dart';

//clase para instanciar y llamar la barra de navegacion
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //se tomara una columna solo para la barra
        body: Column(
          children: [
            //llamado de la barra con la variable myNav que es la instancia de la NavBar, y se ubica
            // dentro de un expanded para traer los recursos
            //evitando que se genere un desbordamiento de pixeles
            Expanded(
              child: myNav,
              // primer widget
            ),
          ],
        )
    );
  }
}

class HomeTemplate extends StatefulWidget {
  const HomeTemplate({Key? key}) : super(key: key);

  @override
  State<HomeTemplate> createState() => _HomeTemplateState();
}

class _HomeTemplateState extends State<HomeTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //se tomara una columna solo para la barra
        body: Column(
          children: [
            //llamado de la barra con la variable myNav que es la instancia de la NavBar, y se ubica
            // dentro de un expanded para traer los recursos
            //evitando que se genere un desbordamiento de pixeles
            Expanded(
              child: myNav,
              // primer widget
            ),
          ],
        )
    );
  }
}


import 'package:flutter/material.dart';
import 'package:pianta/Home/Home.dart';
import 'package:pianta/register/reset_password.dart';

//clase creada para el alert de editar información
class EditInformation extends StatefulWidget {
  const EditInformation({Key? key}) : super(key: key);

  @override
  State<EditInformation> createState() => _EditInformationState();
}

class _EditInformationState extends State<EditInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //retorno de un alert
      body: AlertDialog(
        //titulo inicial del alert
        title: Text('User Profile'),
        content: Column(
          //dimension de la card
          mainAxisSize: MainAxisSize.min,
          children:  [
             Row(
               mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('NAME', textAlign: TextAlign.left)
                ]
            ),
                  //creacion campo de texto
                  const TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_2_outlined),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Colors.grey), //<-- SEE HERE
                    ),
                  ),
                ),
            const SizedBox(height: 20),
            //segundo subtitulo antes del campo de texto
            Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(5),
                      child: Text('EMAIL', textAlign: TextAlign.left)
                  )
                ]
            ),
            //margen de espacio para el campo 2

                //creacion del segundo campo de texto
                const TextField(
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email_outlined),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Colors.grey), //<-- SEE HERE
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  //margen de espacio para el boton
                  padding: const EdgeInsets.all(5.0),
                  //boton flotante para el created projectd
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        //accion que llevara a la card del projecto ya creado
                        MaterialPageRoute(builder: (context) => const reset_passaword()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(0, 191, 174, 1) // Color de fondo del botón
                    ),
                    //texto que aparecera dentro del boton
                    child: const Text('Reset Password', style: TextStyle(color:Colors.white)),
                  ),
                )
              ]
            ),
            const SizedBox(height: 35.0),
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
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(90, 30),
                      backgroundColor: Color.fromRGBO(255, 255, 255, 1)),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(16, 16, 16, 1)),
                  ),
                ),
                const SizedBox(
                  width: 25, // Espacio de 16 píxeles entre los botones
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(90, 30),
                    backgroundColor: Color.fromRGBO(0, 191, 174, 1),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

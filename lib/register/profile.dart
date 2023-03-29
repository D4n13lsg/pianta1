import 'package:flutter/material.dart';
import 'package:pianta/Home/Home.dart';
import 'package:pianta/register/create_password.dart';
import 'package:email_validator/email_validator.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  final _keyForm = GlobalKey<FormState>();
  late String name;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: _keyForm,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/Logotipo_pianta.png',
                      width: 350,
                    ),
                  ],
                ),
                Container(
                  width: 450,
                  height: 500,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black26,
                      width: 2.0,
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Profile',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                              textAlign: TextAlign.center)
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Flexible(
                            flex: 1,
                            child: Text(
                              'Fill in information your personal data',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),

                      const SizedBox(height: 30.0),
                      //se pone el nombre de ususario a registar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'FIRST NAME',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      //se ponber el nombre de ususario
                      TextFormField(
                        validator: (valor) {
                          if (valor!.isEmpty ||
                              !RegExp(r'^[a-z A-Z]+$').hasMatch(valor)) {
                            //allow upper and lower case alphabets and space
                            return "Please enter your name";
                          } else {
                            return null;
                          }
                        },
                        decoration:
                            const InputDecoration(border: OutlineInputBorder()),
                      ),
                      const SizedBox(height: 25.0),
                      const SizedBox(height: 25.0),
                      const SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const create_password(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: const Color.fromRGBO(122, 146, 233, 1),
                              ),
                              child: const Text(
                                'Back to password creation',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_keyForm.currentState!.validate()) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Home(),
                                    ),
                                  );
                                } else {
                                  print('An error has occurred, check your email or password');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(0, 191, 174, 1),
                              ),
                              child: const Text(
                                'Done',
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25.0),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:pianta/register/forgot_password.dart';
import 'package:pianta/register/signup.dart';


import 'package:pianta/Home/Home.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //contrasena
  bool _showPassword = false;
  final _keyForm = GlobalKey<FormState>();

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
                      fit: BoxFit.cover,
                      width: 350,
                    ),
                  ],
                ),
                Container(
                  width: 410,
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
                          Text('LOG IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                              ),
                              textAlign: TextAlign.center)
                        ],
                      ),
                      //email usuario
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'EMAIL',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const [
                          Text(
                            'PASSWORD',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      //este textfromfile sirve para dejar ver la contraseña del usuario
                      TextFormField(
                        //validacion email
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(),
                            suffixIcon: GestureDetector(
                              child: Icon(_showPassword == false
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onTap: () {
                                setState(() {
                                  _showPassword = !_showPassword;
                                });
                              },
                            )),
                        obscureText: _showPassword == false ? true : false,
                      ),

                      const SizedBox(height: 25.0),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const forgot_password(),
                                  ),
                                );
                              },

                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 22,
                                    color: Color.fromRGBO(122, 146, 233, 1)),
                              ), // El texto que se mostrará en el botón
                            )
                          ]),
                      const SizedBox(height: 25.0),
                      //boton para iniciar proyecto
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_keyForm.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Home(),
                                  ),
                                );
                              } else {
                                print(
                                    'An error has occurred, check your email or password');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(350, 70),
                              backgroundColor: Color.fromRGBO(0, 191, 174, 1),
                            ),
                            child: const Text(
                              'LOG IN',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),

                       */
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: double.infinity,
                          minHeight: 70,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_keyForm.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ),
                              );
                            } else {
                              print(
                                  'An error has occurred, check your email or password');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(0, 191, 174, 1),
                          ),
                          child: const Text(
                            'LOG IN',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 25.0),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUp(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Create new account',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 22,
                                    color: Color.fromRGBO(122, 146, 233, 1)),
                              ), // El texto que se mostrará en el botón
                            )
                          ]),
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

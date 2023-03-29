import 'package:flutter/material.dart';
import 'package:pianta/register/create_newpassword.dart';
import 'package:pianta/register/login.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
                      width: 350,
                    ),
                  ],
                ),
                Container(
                  width: 450.0,
                  height: 500.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black26,
                      width: 2.0,
                    ),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('LOG IN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 38,
                              ),
                              textAlign: TextAlign.center)
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      //creacion un nuevo contraseña
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: const [
                          Flexible(
                            flex: 1,
                            child: Text(
                              'Welcome! Fill in your email address and we will',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 19,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: const [
                          Flexible(
                            flex: 1,
                            child: Text(
                              'send an account activation link.',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 19,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20.0),
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
                        validator: (valor) {
                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp = RegExp(pattern);
                          if (valor!.length == 0) {
                            return 'Plase input your email';
                          } else if (!regExp.hasMatch(valor)) {
                            return 'your email is not valid';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      const SizedBox(height: 25.0),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: double.infinity,
                          minHeight: 50,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_keyForm.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const create_password1(),
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
                            'Sign up',
                            style: TextStyle(
                              fontSize: 28,
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
                                    builder: (context) => const Login(),
                                  ),
                                );
                              },

                              child: const Text(
                                'Back to Login?',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 22,
                                    color: Color.fromRGBO(122, 146, 233, 1)),
                              ), // El texto que se mostrará en el botón
                            )
                          ])
                    ],
                  ),
                )
              ],
            ),
          ))),
    ));
  }
}

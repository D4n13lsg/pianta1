import 'package:flutter/material.dart';
import 'package:pianta/register/create_password.dart';
import 'package:pianta/register/login.dart';
import 'package:pianta/register/profile.dart';
import 'package:pianta/register/reset_password.dart';
import 'package:email_validator/email_validator.dart';

class forgot_password extends StatefulWidget {
  const forgot_password({Key? key}) : super(key: key);

  @override
  State<forgot_password> createState() => _forgot_passwordState();
}

class _forgot_passwordState extends State<forgot_password> {
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
                          Text('Forgot Password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 38,
                              ),
                              textAlign: TextAlign.center)
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: const [
                          Flexible(
                            flex: 1,
                            child: Text(
                              'It happens sometimes, no worries. We will send ',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 19,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 10),
                          Flexible(
                            flex: 1,
                            child: Text(
                              'you an email with the link to reset password',
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
                              fontSize: 23,
                            ),
                          )
                        ],
                      ),
                      TextFormField(
                        validator: (valor) {
                          String pattern =
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                          RegExp regExp = new RegExp(pattern);
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
                      const SizedBox(height: 30.0),
                      const SizedBox(height: 30.0),
                      /*Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_keyForm.currentState!.validate()) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const reset_passaword(),
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
                              'Submit',
                              style: TextStyle(
                                fontSize: 28,
                              ),
                            ),
                          ),
                        ],
                      ),

                       */
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
                                  builder: (context) => const reset_passaword(),
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
                            'Submit',
                            style: TextStyle(
                              fontSize: 28,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
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
                                'Back to Login',
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

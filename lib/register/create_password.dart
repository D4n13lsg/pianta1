import 'package:flutter/material.dart';
import 'package:pianta/register/mensaje.dart';
import 'package:pianta/register/profile.dart';

import 'login.dart';

class create_password extends StatefulWidget {
  const create_password({Key? key}) : super(key: key);

  @override
  State<create_password> createState() => _create_passwordState();
}

class _create_passwordState extends State<create_password> {
  bool _showPassword = false;
  bool _showPassword2 = false;
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

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
                          width: 300.0,
                          height: 200.0,
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
                              Text('Create Password',
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
                              Text('Create a password which is hard to guess.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                  textAlign: TextAlign.center)
                            ],
                          ),
                          const SizedBox(height: 30.0),
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
                          //se digita la contrasena
                          TextFormField(
                            controller: password,
                            validator: (valor) {
                              if (valor!.isEmpty ) {
                                return 'please entrer passowrd';
                              }if(valor!.length < 8){
                                return 'la contrasena tiene que tener almenos 8 caracteres ';
                              }else if( valor?.trim()?.isEmpty ?? true){
                                return 'your password must have digits';
                              }
                              return null;
                            },
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Text(
                                'CONFIRM PASSWORD',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              )
                            ],
                          ),
                          //se confirma contrasena
                          TextFormField(
                            controller: confirmpassword,
                            validator: (valor) {
                              if (valor!.isEmpty) {
                                return 'Please re-enter password';
                              }
                              print(password.text);
                              print(confirmpassword.text);
                              if (password.text != confirmpassword.text) {
                                return "Password does not match";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock),
                                border: OutlineInputBorder(),
                                suffixIcon: GestureDetector(
                                  child: Icon(_showPassword2 == false
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onTap: () {
                                    setState(() {
                                      _showPassword2 = !_showPassword2;
                                    });
                                  },
                                )),
                            obscureText: _showPassword2 == false ? true : false,
                          ),
                          const SizedBox(height: 25.0),
                          const SizedBox(height: 25.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Login(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: Size(200, 50),
                                    backgroundColor:
                                    Color.fromRGBO(255, 255, 255, 1)),
                                child: const Text(
                                  'LOG IN',
                                  style: TextStyle(
                                      fontSize: 28,
                                      color: Color.fromRGBO(122, 146, 233, 1)),
                                ),
                              ),
                              const SizedBox(
                                width:
                                25, // Espacio de 16 píxeles entre los botones
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_keyForm.currentState!.validate()) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const mensaje(),
                                      ),
                                    );
                                  } else {
                                    print(
                                        'An error has occurred, check your email or password');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(200, 50),
                                  backgroundColor: Color.fromRGBO(0, 191, 174, 1),
                                ),
                                child: const Text(
                                  'Next',
                                  style: TextStyle(
                                    fontSize: 28,
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

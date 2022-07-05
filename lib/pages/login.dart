// ignore_for_file: prefer_const_constructors

import 'package:best_parking_app_firebase/pages/Operario/inicioOperador.dart';
import 'package:best_parking_app_firebase/pages/Operario/listaParqueosActivos.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../peticiones/usuariohttp.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usuario = TextEditingController();
  TextEditingController clave = TextEditingController();
  var usuarior;
  void registro() {
    Peticioneslogin().crearRegistroEmail(usuario.text, clave.text).then((user) {
      setState(() {
        print(user);
        if (user == '1' || user == '2') {
          usuarior = 'Correo Ya Existe o Contraseña Debil';
        } else {
          usuarior = user.user.email;
        }
      });
    }); // print(resul);
    // print('OBTENER');
  }

  void ingreso() {
    Peticioneslogin().ingresarEmail(usuario.text, clave.text).then((user) {
      setState(() {
        print("adsa" + user);
        if (user == '1' || user == '2') {
          usuarior = 'Correo No Existe o Contraseña Invalida';
        } else {
          usuarior = user.user.email;
        }
      });
    }); // print(resul);
    // print('OBTENER');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: CircleAvatar(
                  child: Image.asset(
                    'img/icono.png',
                    //scale: 1.5,
                  ),
                  radius: 80.0,
                  backgroundColor: Colors.blue.shade400,
                ),
              ),
              TextField(
                controller: usuario,
                decoration: InputDecoration(hintText: "Digite el Usuario"),
              ),
              TextField(
                controller: clave,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Digite la Contraseña",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                inicioOperador()));
                    //ingreso();
                  },
                  icon: Icon(Icons.login),
                  label: Text('Ingresar')),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

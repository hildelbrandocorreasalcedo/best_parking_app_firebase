import 'dart:convert';
//import 'dart:ffi';
import 'package:best_parking_app_firebase/modelos/parqueo.dart';
import 'package:best_parking_app_firebase/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../peticiones/peticionesParqueo.dart';

import 'salidavehiculo.dart';

class detallesParqueo extends StatefulWidget {
  final iddoc;
  final pos;
  final List perfil;
  detallesParqueo({required this.perfil, this.pos, this.iddoc});

  /*final idperfil;
  final List<dynamic> perfil;
  RetirarVehiculo({required this.perfil, this.idperfil});*/

  @override
  _detallesParqueoState createState() => _detallesParqueoState();
}

class _detallesParqueoState extends State<detallesParqueo> {
  TextEditingController controltipo = TextEditingController();
  TextEditingController controlplaca = TextEditingController();
  TextEditingController controlmarca = TextEditingController();
  TextEditingController controlhora_entrada = TextEditingController();
  TextEditingController controlhora_salida = TextEditingController();
  TextEditingController controlestado = TextEditingController();
  TextEditingController controlnumerohoras = TextEditingController();
  TextEditingController controlvalorhora = TextEditingController();
  TextEditingController controltotalpagar = TextEditingController();

  late DateTime? horaentrada;
  late DateTime? horasalida;

  @override
  void initState() {
    controltipo =
        TextEditingController(text: widget.perfil[widget.pos]['tipo']);
    controlplaca =
        TextEditingController(text: widget.perfil[widget.pos]['placa']);
    controlplaca =
        TextEditingController(text: widget.perfil[widget.pos]['placa']);
    controlmarca =
        TextEditingController(text: widget.perfil[widget.pos]['marca']);
    controlhora_entrada =
        TextEditingController(text: widget.perfil[widget.pos]['hora_entrada']);
    controlhora_salida =
        TextEditingController(text: widget.perfil[widget.pos]['hora_salida']);
    controlestado =
        TextEditingController(text: widget.perfil[widget.pos]['estado']);
    controlnumerohoras =
        TextEditingController(text: widget.perfil[widget.pos]['numerohoras']);
    controlvalorhora =
        TextEditingController(text: widget.perfil[widget.pos]['valorhora']);
    controltotalpagar =
        TextEditingController(text: widget.perfil[widget.pos]['totalpagar']);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          /*title: Text(
              'GESTION DE PARQUEOS',
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
              ),
            ),*/
          title: Image.asset('img/Icono.png', scale: 3),
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 40,
                width: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(blurRadius: 7, spreadRadius: 3, color: Colors.white)
                ], shape: BoxShape.circle, color: Colors.white),
                child: IconButton(
                  iconSize: 25,
                  icon: const Icon(Icons.home),
                  color: Colors.blue.shade400,
                  tooltip: 'Salir',
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
              SizedBox(
                width: 26,
              )
            ],
          ),
          centerTitle: true,
          toolbarHeight: 60,
          backgroundColor: Colors.blue.shade400,
          //elevation: 14,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(70),
                  bottomLeft: Radius.circular(70))),
          actions: [
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 7, spreadRadius: 3, color: Colors.white)
                  ], shape: BoxShape.circle, color: Colors.white),
                  child: IconButton(
                    icon: const Icon(Icons.output_outlined),
                    color: Colors.blue.shade400,
                    tooltip: 'Salir',
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Login()));
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 26,
                )
              ],
            ),
          ]),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              "Detalles del Parqueo",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: 'Prompt',
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(35, 10, 35, 0),
            height: 690,
            width: double.maxFinite,
            child: Card(
              elevation: 5,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 20,
                    left: (MediaQuery.of(context).size.width / 2) - 135,
                    child: Container(
                      //
                      height: 60,
                      width: 200,
                      child: Card(
                        elevation: 2,
                        color: Colors.blue[200],
                        child: Center(
                          child: Text(
                            controlplaca.text,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              fontFamily: 'Prompt',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 100),
                          child: Column(
                            children: [
                              Text(
                                'Tipo de vehiculo:\n' + controltipo.text,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                              Text(
                                '\nMarca del vehiculo:\n' + controlmarca.text,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                              Text(
                                '\nFecha de entrada:\n' +
                                    controlhora_entrada.text.substring(0, 10),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                              Text(
                                'Hora de entrada:\n' +
                                    controlhora_entrada.text.substring(11, 16),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                              Text(
                                controlhora_salida.text != ''
                                    ? '\nFecha de salida:\n' +
                                        controlhora_salida.text.substring(0, 10)
                                    : '\nFecha de salida:\n',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                              Text(
                                controlhora_salida.text != ''
                                    ? 'Hora de salida:\n' +
                                        controlhora_salida.text
                                            .substring(11, 16)
                                    : 'Hora de salida:\n',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                              Text(
                                controlnumerohoras != null
                                    ? '\nNumero de horas:\n' +
                                        controlnumerohoras.text
                                    : '',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                              Text(
                                '\nTarifa por hora:\n' + controlvalorhora.text,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                              Text(
                                controltotalpagar != null
                                    ? '\nTotal a pagar:\n' +
                                        controltotalpagar.text
                                    : '',
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: 'Prompt',
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

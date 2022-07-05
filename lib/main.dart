// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/firestore.dart';
import 'pages/Operario/listaParqueosActivos.dart';
import 'pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "95146943460452101354d9a0f5fa25e89d21a0a2", // Your apiKey
      appId: "10c564e51e8037945c0e2c", // Your appId
      messagingSenderId: "185304527173", // Your messagingSenderId
      projectId: "best-parking-app", // Your projectId
    ),
  );
  Get.put(Peticiones2());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Programacion Movil',
      theme: ThemeData.light(),
      home: Login(),
    );
  }
}

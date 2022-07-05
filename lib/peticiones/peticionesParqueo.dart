import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Peticiones {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot> readItems() {
    CollectionReference listado = _db.collection('clientes');

    return listado.snapshots();
  }

  static Future<void> crearcliente(Map<String, dynamic> cliente) async {
    await _db.collection('clientes').doc().set(cliente).catchError((e) {
      print(e);
    });
    //return true;
  }

//'MWPy56bgx9wYBzul88rR'
  static Future<void> actualizarcliente(
      String id, Map<String, dynamic> cliente) async {
    await _db.collection('clientes').doc(id).update(cliente).catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<void> eliminarcliente(String id) async {
    await _db.collection('clientes').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }
}

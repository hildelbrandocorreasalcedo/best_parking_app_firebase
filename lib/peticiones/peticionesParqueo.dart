import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Peticiones {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Stream<QuerySnapshot> readItems() {
    CollectionReference listado = _db.collection('parqueo');

    return listado.snapshots();
  }

  static Future<void> crearcliente(Map<String, dynamic> parqueo) async {
    await _db.collection('parqueo').doc().set(parqueo).catchError((e) {
      print(e);
    });
    //return true;
  }

//'MWPy56bgx9wYBzul88rR'
  static Future<void> actualizarcliente(
      String id, Map<String, dynamic> parqueo) async {
    await _db.collection('parqueo').doc(id).update(parqueo).catchError((e) {
      print(e);
    });
    //return true;
  }

  static Future<void> eliminarcliente(String id) async {
    await _db.collection('parqueo').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }
}

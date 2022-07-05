import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class Peticiones2 extends GetxController {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> readItems() {
    CollectionReference listado = _db.collection('clientes');

    return listado.snapshots();
  }

  Future<void> crearcliente(Map<String, dynamic> cliente) async {
    await _db.collection('estados').doc().set(cliente).catchError((e) {
      print(e);
    });
    //return true;
  }

//'MWPy56bgx9wYBzul88rR'
  Future<void> actualizarcliente(
      String id, Map<String, dynamic> cliente) async {
    await _db.collection('estados').doc(id).update(cliente).catchError((e) {
      print(e);
    });
    //return true;
  }

  Future<void> eliminarcliente(String id) async {
    await _db.collection('estados').doc(id).delete().catchError((e) {
      print(e);
    });
    //return true;
  }
}

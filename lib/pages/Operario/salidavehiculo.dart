import 'package:best_parking_app_firebase/modelos/parqueo.dart';
import 'package:flutter/material.dart';
import 'package:best_parking_app_firebase/pages/Operario/retirarVehiculo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../peticiones/peticionesParqueo.dart';

class ListaMensajeros extends StatefulWidget {
  ListaMensajeros();

  @override
  _ListaMensajerosState createState() => _ListaMensajerosState();
}

class _ListaMensajerosState extends State<ListaMensajeros> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listados Mensajeros'),
        actions: [
          IconButton(
              tooltip: 'Adicionar Mensajero',
              icon: Icon(Icons.add),
              onPressed: () {
                /*
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => AgregarMensajero()));*/
              })
        ],
      ),

      body: getInfo(context),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            getInfo(context);
          });
        },
        tooltip: 'Refrescar',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

Widget getInfo(BuildContext context) {
  return StreamBuilder(
    stream: Peticiones.readItems(),
    /*FirebaseFirestore.instance
        .collection('clientes')
        .snapshots(),*/ //En esta línea colocamos el el objeto Future que estará esperando una respuesta
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      print(snapshot.connectionState);
      switch (snapshot.connectionState) {

        //En este case estamos a la espera de la respuesta, mientras tanto mostraremos el loader
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator());

        case ConnectionState.active:
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          // print(snapshot.data);
          return snapshot.data != null
              ? VistaParqueos(parqueos: snapshot.data!.docs)
              : Text('No hat Datos');

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}

class VistaParqueos extends StatelessWidget {
  //final List<Parqueo> parqueos;
  //const VistaParqueos({Key? key, required this.parqueos}) : super(key: key);

  final List<dynamic> parqueos;

  const VistaParqueos({required this.parqueos});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: parqueos.length == 0 ? 0 : parqueos.length,
        itemBuilder: (context, posicion) {
          print(parqueos[posicion].id);
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 2, color: Colors.cyan)
                  /*boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 8.0,
                    )
                  ]*/
                  ),
              height: 50.0,
              child: ListTile(
                onTap: () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => RetirarVehiculo(
                                perfil: parqueos,
                                idperfil: posicion,
                              )));*/
                },
                leading: Container(
                  padding: EdgeInsets.all(5),
                  width: 50,
                  height: 50,
                  child: Icon(parqueos[posicion]['tipo'] == "CARRO"
                      ? Icons.car_repair
                      : Icons.motorcycle_outlined),
                ),
                title: Text(
                  parqueos[posicion]['placa'],
                  //textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      fontFamily: 'Prompt'),
                ),
                subtitle: Text(
                  parqueos[posicion]['hora_entrada'].substring(11, 16),
                  //textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      fontFamily: 'Prompt'),
                ),
                trailing: Container(
                  width: 20,
                  /*color: Colors.yellow,*/
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor:
                            parqueos[posicion]['estado'] == 'ACTIVO'
                                ? Colors.green
                                : Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

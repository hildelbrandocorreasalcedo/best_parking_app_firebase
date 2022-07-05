import 'package:best_parking_app_firebase/pages/Operario/detallesParqueo.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../peticiones/peticionesParqueo.dart';

class ListarTotalParqueos extends StatefulWidget {
  ListarTotalParqueos();

  @override
  _ListarTotalParqueosState createState() => _ListarTotalParqueosState();
}

class _ListarTotalParqueosState extends State<ListarTotalParqueos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              : Text('Sin Datos');

        /*
             Text(
              snapshot.data != null ?'ID: ${snapshot.data['id']}\nTitle: ${snapshot.data['title']}' : 'Vuelve a intentar', 
              style: TextStyle(color: Colors.black, fontSize: 20),);
            */

        default:
          return Text('Presiona el boton para recargar');
      }
    },
  );
}

class VistaParqueos extends StatelessWidget {
  final List parqueos;

  const VistaParqueos({required this.parqueos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: parqueos.length == 0 ? 0 : parqueos.length,
        itemBuilder: (context, posicion) {
          print(parqueos[posicion].id);
          return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => detallesParqueo(
                            perfil: parqueos,
                            pos: posicion,
                            iddoc: parqueos[posicion].id)));
              },
              leading: Container(
                padding: EdgeInsets.all(5.0),
                width: 50,
                height: 50,
                child: Icon(parqueos[posicion]['tipo'] == "CARRO"
                    ? Icons.car_repair
                    : Icons.motorcycle_outlined),
              ),
              title: Text(
                parqueos[posicion]['placa'],
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'Prompt'),
              ),
              subtitle: Text(
                parqueos[posicion]['tipo'],
                textAlign: TextAlign.center,
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
                      backgroundColor: parqueos[posicion]['estado'] == 'ACTIVO'
                          ? Colors.green
                          : Colors.red,
                    ),
                  ],
                ),
              ));
        });
  }
}

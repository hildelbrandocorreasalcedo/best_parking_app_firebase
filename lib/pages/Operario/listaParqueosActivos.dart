import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../peticiones/peticionesParqueo.dart';

class ListaMensajeros extends StatefulWidget {
  ListaMensajeros({required this.title});
  final String title;

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
              ? Vistamensajeros(mensajeros: snapshot.data!.docs)
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

class Vistamensajeros extends StatelessWidget {
  final List mensajeros;

  const Vistamensajeros({required this.mensajeros});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: mensajeros.length == 0 ? 0 : mensajeros.length,
        itemBuilder: (context, posicion) {
          print(mensajeros[posicion].id);
          return ListTile(
            onTap: () {
              /*Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ModificarMensajero(
                          perfil: mensajeros,
                          pos: posicion,
                          iddoc: mensajeros[posicion].id)));*/
            },
            leading: Container(
              padding: EdgeInsets.all(5.0),
              width: 50,
              height: 50,
              //child: Image.network(mensajeros[posicion]['fotocliente']),
            ),
            title: Text(mensajeros[posicion]['placa']),
            subtitle: Text(mensajeros[posicion]['tipo']),
            trailing: Container(
              width: 80,
              height: 40,
              color: Colors.yellowAccent,
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Text(mensajeros[posicion]['numerohoras']),
            ),
          );
        });
  }
}

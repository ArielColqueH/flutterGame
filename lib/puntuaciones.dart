import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './models/jugador.dart';
import './puntuacionesBloc.dart';

class SecondRoute extends StatefulWidget {
  @override
  _MySecondRoute createState() => _MySecondRoute();
}

class _MySecondRoute extends State<SecondRoute> {
  //variables de inicializacion para mostrar el arreglo de jugadores
  final puntuacionesBloc _puntuacionesBloc = puntuacionesBloc();
  List todos = List();
  final db = Firestore.instance;

  void initState() {
    super.initState();
    //_puntuacionesBloc.cargar();
    //print("imprimio");
  }

  void dispose() {
    super.dispose();
    _puntuacionesBloc.dispose();
    print("salio");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        SizedBox(height: 50),
        Text(
          "SURVIVAL",
          style: new TextStyle(fontSize: 50.0, color: Colors.white),
        ),
        new Text(
          "Top Puntuaciones",
          style: new TextStyle(fontSize: 20.0, color: Colors.white),
        ),

        SizedBox(height: 30),
        //EJEMPLO DE TABLA UTILIZANDO FIREBASE DIRECTAMENTE
        Expanded(
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection("PuntuacionesSurvival")
                  .orderBy('puntuacion', descending: true)
                  .snapshots(),
              builder: (context, snapshots) {
                if (!snapshots.hasData) {
                  return Text(
                    'No Data...',
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshots.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshots.data.documents[index];
                      return Dismissible(
                        key: Key(index.toString()),
                        child: Card(
                          color: Color(0xFF2E9AA6),
                          child: ListTile(
                            leading: Icon(
                              Icons.account_circle,
                              size: 60,
                              color: Color(0xFFFFFFFF),
                            ),
                            title: Text(
                              documentSnapshot["nombre"],
                              style: new TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              documentSnapshot["puntuacion"].toString() +
                                  " Puntos",
                              style: new TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    });
              }),
        ),
        //EJEMPLO DE TABLA UTILIZANDO BLOCK
//        Expanded(
//          child: StreamBuilder<List<Jugador>>(
//              stream: _puntuacionesBloc.jugadorListStream,
//              builder: (context, snapshots) {
//                if (!snapshots.hasData) {
//                  return Text(
//                    'No Data...',
//                  );
//                }
//                return ListView.builder(
//                    shrinkWrap: true,
//                    itemCount: snapshots.data.length,
//                    itemBuilder: (context, index) {
//                      return Dismissible(
//                        key: Key(index.toString()),
//                        child: Card(
//                          color: Color(0xFF2E9AA6),
//                          child: ListTile(
//                            leading: Icon(
//                              Icons.account_circle,
//                              size: 60,
//                              color: Color(0xFFFFFFFF),
//                            ),
//                            title: Text(
//                              snapshots.data[index].nombre,
//                              style: new TextStyle(color: Colors.white),
//                            ),
//                            subtitle: Text(
//                              snapshots.data[index].score.toString() +
//                                  " Puntos",
//                              style: new TextStyle(color: Colors.white),
//                            ),
//                          ),
//                        ),
//                      );
//                    });
//              }),
//        ),
        SizedBox(height: 50),
        //boton para regresar a la pantalla pricipal
        ButtonTheme(
          minWidth: 240.0,
          height: 60.0,
          child: new RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
                side: BorderSide(color: Colors.white)),
            //              splashColor: Color(0xFFBF7EBB),
            color: Color(0xFFBF7EBB),
            child: new Text(
              "Menu Principal",
              style: new TextStyle(fontSize: 20.0, color: Colors.white),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SecondRoute extends StatefulWidget {
  @override
  _MySecondRoute createState() => _MySecondRoute();
}

class _MySecondRoute extends State<SecondRoute> {
  List todos = List();
  String input = "";
  final db = Firestore.instance;
  final _formKey = GlobalKey<FormState>();


  void initState() {
    super.initState();
    todos.add('item1');
    todos.add('item2');
    todos.add('item3');
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
            Expanded(
              child: StreamBuilder(
                  stream: Firestore.instance
                      .collection("PuntuacionesSurvival").orderBy('puntuacion', descending: true)
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
//                          if (snapshots.data == null)
//                            return CircularProgressIndicator();
                          DocumentSnapshot documentSnapshot =
                              snapshots.data.documents[index];
                          return Dismissible(
                            key: Key(index.toString()),
                            child: Card(
                                color: Color(0xFF2E9AA6),
                                child: ListTile(
                                  leading: Icon(Icons.account_circle,size: 60,color: Color(0xFFFFFFFF),),
                                  title: Text(
                                    documentSnapshot["nombre"],
                                    style: new TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Text(documentSnapshot["puntuacion"].toString()+" Puntos",
                                    style: new TextStyle(color: Colors.white),
                                  ),

                                ),
                            ),
                          );
                        });
                    ;
                  }),
            ),
            SizedBox(height: 50),
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
        )

        );
    return Scaffold(
      body: Center(
        child: new Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          child: Text("My Awesome Border"),
        ),
      ),
    );
  }
}

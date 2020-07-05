import 'dart:async';
import './models/jugador.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class puntuacionesBloc {
  //lista de objetos para la table de ejemplo

  final List <Jugador> _jugadorList = [];

  //DocumentSnapshot documentSnapshot =snapshots.data.documents[index];
  //stream Controller
  final _jugadorListaStreamController = StreamController<List<Jugador>>();
  final _jugadorListaCargarStreamController = StreamController<Jugador>();

  //getters :Stream y sink
  Stream <List<Jugador>>get jugadorListStream => _jugadorListaStreamController.stream;
  StreamSink <List<Jugador>>get jugadorListSink => _jugadorListaStreamController.sink;

  StreamSink <Jugador> get jugadorListaCargar =>_jugadorListaCargarStreamController.sink;

  //constructor
  puntuacionesBloc() {
    print("carga");
    //cargar();
    _jugadorListaStreamController.add(_jugadorList);
    _jugadorListaCargarStreamController.stream.listen(cargar);
  }

  //dispose
  void dispose() {
    _jugadorListaStreamController.close();
  }

  cargar (Jugador jugador) async{
    var x = await Firestore.instance.collection("PuntuacionesSurvival").orderBy('puntuacion', descending: true).getDocuments();
      for(var x in x.documents){
        _jugadorList.add(Jugador(x.data["nombre"],x.data["puntuacion"]));
      }
  }
}


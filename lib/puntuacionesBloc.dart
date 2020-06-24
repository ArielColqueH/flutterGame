import 'dart:async';
import './models/jugador.dart';

class puntuacionesBloc {
  //lista de objetos para la table de ejemplo
  List <Jugador> _jugadorList =[
    Jugador("ariel",15),
    Jugador("mariana",14),
    Jugador("luisa",13),
  ];
  //stream Controller
  final _jugadorListaStreamController = StreamController<List<Jugador>>();

  //getters :Stream y sink
  Stream <List<Jugador>>get jugadorListStream => _jugadorListaStreamController.stream;

  //constructor
  puntuacionesBloc() {
    _jugadorListaStreamController.add(_jugadorList);
  }

  //dispose
  void dispose() {
    _jugadorListaStreamController.close();
  }
}


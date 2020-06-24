//import 'dart:async';
//import './components/score_text.dart';
//import './models/jugador.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//class JugadorBloc {
//  //stream Controller
//  final _scoreTextIncrementStreamController = StreamController<ScoreText>();
//
//  //getters :Stream y sink
//  //Stream <ScoreText> get scoreStream => _scoreTextStreamController.stream;
//  StreamSink<ScoreText> get scoreIncrement =>
//      _scoreTextIncrementStreamController.sink;
//  //constructor
//  ScoreTextBloc() {
//    //_scoreTextStreamController.add(event);
//
//  }
//    _incrementarScore(ScoreTextBloc scoreTextBloc){
//
//  }
//
//  //dispose
//  void dispose() {
//    _scoreTextIncrementStreamController.close();
//  }
//}
//

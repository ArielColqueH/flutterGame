import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuego/game_controller.dart';
//clase de la puntuacion
class ScoreText{
  final GameController gameController;
  TextPainter painter;
  Offset position;
//constructor para la construccion
  ScoreText(this.gameController){
    painter = TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr);
    position = Offset.zero;
  }

  //funcion para renderizar la puntuacion
  void render(Canvas c){
    painter.paint(c, position);
  }
  //funcion para actualizar la puntuacion
  void update(double t){
    if((painter.text ?? '')!= gameController.puntos.toString()){
      //texto que se mostrar
      painter.text = TextSpan(text : "Puntos : "+ gameController.puntos.toString(),
      style: TextStyle(color: Colors.white,fontSize: 25.0));// disenio del texto
      painter.layout();
      //position del score
      position = Offset((gameController.screenSize.width/3) - (painter.width/2),(gameController.screenSize.height*0.1) - (painter.height*0.1));
    }
  }
}
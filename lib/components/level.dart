import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuego/game_controller.dart';

//clase de nivel
class Level{
  final GameController gameController;
  TextPainter painter;
  Offset position;
//constructor de nivel
  Level(this.gameController){
    //estilo de texto para el nivel
    painter = TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr);
    //posicion
    position = Offset.zero;
  }

  //funcion de renderizacion
  void render(Canvas c){
    painter.paint(c, position);
  }

  //funcion de actualizacion
  void update(double t){
    if((painter.text ?? '')!= gameController.puntos.toString()){
      //texto que se imprimira
      painter.text = TextSpan(text : "Nivel : "+ gameController.nivelJuego.toString(),
      //estilo
      style: TextStyle(color: Colors.white,fontSize: 25.0));
      painter.layout();
      //posicion
      position = Offset((gameController.screenSize.width/2) + (painter.width/3),(gameController.screenSize.height*0.1) - (painter.height*0.1));
    }
  }
}
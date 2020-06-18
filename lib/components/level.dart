import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuego/game_controller.dart';

class Level{
  final GameController gameController;
  TextPainter painter;
  Offset position;

  Level(this.gameController){
    painter = TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr);
    position = Offset.zero;
  }
  void render(Canvas c){
    painter.paint(c, position);
  }
  void update(double t){
    if((painter.text ?? '')!= gameController.puntos.toString()){
      painter.text = TextSpan(text : "Nivel : "+ gameController.nivelJuego.toString(),
      style: TextStyle(color: Colors.white,fontSize: 25.0));
      painter.layout();
      position = Offset((gameController.screenSize.width/2) + (painter.width/3),(gameController.screenSize.height*0.1) - (painter.height*0.1));
    }
  }
}
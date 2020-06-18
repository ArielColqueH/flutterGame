import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuego/game_controller.dart';

class VidaText{
  final GameController gameController;
  TextPainter painter;
  Offset position;

  VidaText(this.gameController){
    painter = TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr);
    position = Offset.zero;
  }
  void render(Canvas c){
    painter.paint(c, position);
  }
  void update(double t){
    if((painter.text ?? '')!= gameController.puntos.toString()){
      painter.text = TextSpan(text : "Vida " +gameController.porcentajeVida.toString()+" %",
      style: TextStyle(color: Colors.white,fontSize: 30.0));
      painter.layout();
      position = Offset((gameController.screenSize.width/2) - (painter.width/2),(gameController.screenSize.height*0.84) - (painter.height*0.84));
    }
  }
}
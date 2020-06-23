import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuego/game_controller.dart';
//clase de porcentaje de vida
class VidaText{
  final GameController gameController;
  TextPainter painter;
  Offset position;
//constructor de vporcentaje de vida
  VidaText(this.gameController){
    painter = TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr);
    position = Offset.zero;
  }
  //funcion de renderizacion de porcentaje de vida
  void render(Canvas c){
    painter.paint(c, position);
  }
  //funcion de actualizacion de porcentaje de vida
  void update(double t){
    if((painter.text ?? '')!= gameController.puntos.toString()){
      //texto que se mostrara
      painter.text = TextSpan(text : "Vida " +gameController.porcentajeVida.toString()+" %",
      //estilo
      style: TextStyle(color: Colors.white,fontSize: 30.0));
      painter.layout();
      //posicion
      position = Offset((gameController.screenSize.width/2) - (painter.width/2),(gameController.screenSize.height*0.84) - (painter.height*0.84));
    }
  }
}
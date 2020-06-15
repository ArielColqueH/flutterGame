import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuego/game_controller.dart';

class StartText{
  final GameController gameController;
  TextPainter painter;
  Offset position;

  StartText(this.gameController){
    painter = TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr);
    position = Offset.zero;
  }
  void render(Canvas c){
    painter.paint(c, position);
  }
  void update(double t){

    painter.text = TextSpan(text:'Empezar',
        style: TextStyle(color: Colors.white,fontSize: 30.0));
    painter.layout();
    position = Offset((gameController.screenSize.width/2) - (painter.width/2),(gameController.screenSize.height*0.7) - (painter.height/2));

  }
}
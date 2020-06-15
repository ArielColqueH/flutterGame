
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuego/game_controller.dart';

class MenuPrincipalText{
  final GameController gameController;
  TextPainter painter;
  Offset position;
  Rect buttonRect;
  MenuPrincipalText(this.gameController){
    painter = TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr);
    position = Offset.zero;
    buttonRect = Rect.fromLTWH(115,650, gameController.tilesSize*5, gameController.tilesSize*1.5);
  }
  void render(Canvas c){
    Color color=Color(0xFFBF7EBB);
    painter.paint(c, position);
    Paint buttonColor = Paint()..color=color;
    c.drawRect(buttonRect, buttonColor);
  }
  void update(double t){
    painter.text = TextSpan(text:'Menu Pricipal',
        style: TextStyle(color: Colors.white,fontSize: 30.0));
    painter.layout();
    position = Offset((gameController.screenSize.width/2) - (painter.width/2),(gameController.screenSize.height*0.8) - (painter.height/2));
  }
  void onTapDown(){
      print("click on menu principal");
      //Navigator.pop(gameController);
  }
}
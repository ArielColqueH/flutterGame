import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuego/game_controller.dart';

class Player extends CustomPaint{
  final GameController gameController;
  int maxHealt;
  int currentHealth;
  Rect playerRect;
  bool isDead=false;
  Path figura;

  Player(this.gameController){
    maxHealt=currentHealth=300;
    final size = gameController.tilesSize * 1.5;
    //Offset aux = Offset((gameController.screenSize.width/2 - size/2), (gameController.screenSize.height/2));
    playerRect = Rect.fromLTWH(gameController.screenSize.width/2 - size/2, gameController.screenSize.height/2 - size/2, size, size);
    //playerRect = Rect.fromCircle(aux, size);
    //figura = getTrianglePath(size, size, gameController.screenSize.width/2 - size/2,gameController.screenSize.height/2 - size/2);
  }
  void render(Canvas c){
    Paint color = Paint()..color=Color(0xFFBF7EBB);
    c.drawRect(playerRect, color);
    //c.drawPath(figura, color);
  }

  void update(double t){
    //print(currentHealth);
    if(!isDead && currentHealth<=0){
      isDead=true;
      gameController.initialize();
    }
  }
  //disenio
//  void paint(Canvas canvas, Size size) {
//    Paint paint = Paint()
//      ..color = Color(0xFFBF7EBB)
//      ..strokeWidth = 2
//      ..style = PaintingStyle.fill;
//
//    //canvas.drawPath(getTrianglePath(size.width, size.height), paint);
//  }
//  Path getTrianglePath(double x, double y,double ejex , double ejey) {
//    return Path()
////      ..moveTo(0, y)
////      ..lineTo(x / 2, 0)
////      ..lineTo(x, y)
////      ..lineTo(0, y);
//    ..moveTo(ejex, ejey)
//    ..lineTo(ejex+(x / 2), ejey-y)
//    ..lineTo(x+ejex, ejey)
//    ..lineTo(ejex+(x / 2), ejey);
//  }
}



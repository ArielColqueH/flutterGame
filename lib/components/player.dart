import 'dart:ui';

import 'package:flame/sprite.dart';
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

  Sprite playerFrame= Sprite('casa.png');

  Player(this.gameController){
    maxHealt=currentHealth=300;
    final size = gameController.tilesSize * 1.5;
    playerRect = Rect.fromLTWH(gameController.screenSize.width/2 - size/2, gameController.screenSize.height/2 - size/2, size, size);
    //playerRect = Rect.fromCircle(aux, size);

    //figura = getTrianglePath(size, size, gameController.screenSize.width/2 - size/2,gameController.screenSize.height/2 - size/2);
  }
  void render(Canvas c){
    Paint color = Paint()..color=Color(0xFFBF7EBB);
    c.drawRect(playerRect, color);
    final size =gameController.tilesSize *4;
    //playerFrame(c);
    //playerFrame.render(c);
    //playerFrame.render(c);
    //c.drawPath(figura, color);
  }

  void update(double t){
    //print(currentHealth);
    if(!isDead && currentHealth<0){
      isDead=true;
      //gameController.initialize();
    }
    if(currentHealth==0){
      gameController.pausado=true;
    }
  }
}



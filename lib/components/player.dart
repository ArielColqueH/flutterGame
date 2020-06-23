import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuego/game_controller.dart';
//clase de jugador
class Player extends CustomPaint{
  final GameController gameController;
  int maxHealt;
  int currentHealth;
  Rect playerRect;
  bool isDead=false;
  Path figura;
  bool gameFinished =false;

//constructor de jugador
  Player(this.gameController){
    maxHealt=currentHealth=300;//maxima vida
    final size = gameController.tilesSize * 1.5;//tamanio del jugador (cuadrado)
    playerRect = Rect.fromLTWH(gameController.screenSize.width/2 - size/2, gameController.screenSize.height/2 - size/2, size, size);
  }
  void render(Canvas c){
    Paint color = Paint()..color=Color(0x00BF7EBB);//color invisible para poder poner sobre este la imagen
    c.drawRect(playerRect, color);//creacion de color
//    final size =gameController.tilesSize *4;
  }
//actualizar el jugador
  void update(double t){
    if(!isDead && currentHealth<0){
      isDead=true;
    }
    if(currentHealth<=0){
      gameController.alertPuntuacion=true;//cuando la vida sea 0 , entonces se la lanza un trigger para que un alert se pueda activar
      gameController.pausado=true; // bandera para pausar el juego
//      print("vida == 0");
//      print("alert == true");
    }
  }
}



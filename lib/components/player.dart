import 'dart:ui';

import 'package:flutterjuego/game_controller.dart';

class Player{
  final GameController gameController;
  int maxHealt;
  int currentHealth;
  Rect playerRect;
  bool isDead=false;

  Player(this.gameController){
    maxHealt=currentHealth=300;
    final size = gameController.tilesSize * 1.5;
    playerRect = Rect.fromLTWH(gameController.screenSize.width/2 - size/2, gameController.screenSize.height/2 - size/2, size, size);
  }
  void render(Canvas c){
    Paint color = Paint()..color=Color(0xFF0000FF);
    c.drawRect(playerRect, color);
  }
  void update(double t){

  }
}

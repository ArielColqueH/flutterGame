import 'dart:ui';

import 'package:flutterjuego/game_controller.dart';

class HealhtBar{
  final GameController gameController;
  Rect healthBarRect;
  Rect remainingHealtRect;

  HealhtBar(this.gameController){
    double barWidth = gameController.screenSize.width /1.75;
    //healthBarRect = Rect.fromLTWH(gameController.screenSize.width/2 -barWidth/2, gameController.screenSize.height*0.8,barWidth, gameController.tilesSize);
    remainingHealtRect = Rect.fromLTWH(gameController.screenSize.width/2 -barWidth/2, gameController.screenSize.height*0.8,barWidth, gameController.tilesSize);
  }
  void render(Canvas c){
    //Paint healtBarColor = Paint()..color=Color(0xFF2E9AA6);
    Paint remainingBarColor = Paint()..color=Color(0xFFBF7EBB);
    //c.drawRect(healthBarRect, healtBarColor);
    c.drawRect(remainingHealtRect,remainingBarColor);
  }
  void update(double t){
    double barWidth = gameController.screenSize.width / 1.75;
    double percentHealth = gameController.player.currentHealth / gameController.player.maxHealt;
    remainingHealtRect = Rect.fromLTWH(gameController.screenSize.width/2 -barWidth/2, gameController.screenSize.height*0.8,barWidth * percentHealth, gameController.tilesSize);
  }
}

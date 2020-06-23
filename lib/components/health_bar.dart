
import 'dart:ui';

import 'package:flutterjuego/game_controller.dart';
//clase de barra de salud
class HealhtBar{
  final GameController gameController;
  Rect healthBarRect;
  Rect remainingHealtRect;
//constructor
  HealhtBar(this.gameController){
    double barWidth = gameController.screenSize.width /1.75;//tamanio que ocupara la barra de salud
    remainingHealtRect = Rect.fromLTWH(gameController.screenSize.width/2 -barWidth/2, gameController.screenSize.height*0.8,barWidth, gameController.tilesSize);
    //posicion de la bara
  }

  //funcion para renderizacion
  void render(Canvas c){
    //color
    Paint remainingBarColor = Paint()..color=Color(0xFFBF7EBB);
    //impresion en canvas
    c.drawRect(remainingHealtRect,remainingBarColor);
  }

  //funcion de creacion
  void update(double t){
    //tamanio que ocupara la barra de salud
    double barWidth = gameController.screenSize.width / 1.75;
    //porcentaje de la salud
    double percentHealth = gameController.player.currentHealth / gameController.player.maxHealt;
    //posicionar barra de salud
    remainingHealtRect = Rect.fromLTWH(gameController.screenSize.width/2 -barWidth/2, gameController.screenSize.height*0.8,barWidth * percentHealth, gameController.tilesSize);
  }
}

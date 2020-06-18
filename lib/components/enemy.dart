
import 'dart:ui';

import 'package:flutterjuego/game_controller.dart';

class Enemy{
  final GameController gameController;
  int health;
  int damage;
  double speed;
  Rect enemyRect;
  bool isDead =false;
  Path figura ;

  Enemy(this.gameController,double x,double y){
    health = 3;
    damage = 1 ;
    speed = gameController.tilesSize*2;
    enemyRect = Rect.fromLTWH(x, y, gameController.tilesSize*1.2, gameController.tilesSize*1.2);
    //figura = getTrianglePath(size, size, gameController.screenSize.width/2 - size/2,gameController.screenSize.height/2 - size/2);
  }

  void render(Canvas c){
    Color color ;
    switch(health){
      case 1:
        //print("1");
        color = Color(0xFF7DCFD7);
        break;
      case 2:
        //print("2");
        color = Color(0xFF2E9CA6);
        break;
      case 3:
        //print("3");
        color = Color(0xFF056e78);
        break;
      default:
        color = Color(0x00056e78);
        break;
    }
    Paint enemyColor = Paint()..color = color;
    c.drawRect(enemyRect,enemyColor);
  }
  void update(double t){
    if(!isDead){
      double stepDistance = speed * t;
      Offset toPlayer = gameController.player.playerRect.center - enemyRect.center;
      if(stepDistance <= toPlayer.distance - gameController.tilesSize * 1.5){
        Offset stepToPlayer = Offset.fromDirection(toPlayer.direction,stepDistance);
        enemyRect = enemyRect.shift(stepToPlayer);
      }else{
        attack();
      }
    }
  }

  void attack(){
    if(!gameController.player.isDead){
      gameController.player.currentHealth -=damage;
      double porcVida =(gameController.player.currentHealth/300)*100;
      if(porcVida>0) {
        gameController.porcentajeVida =
            ((gameController.player.currentHealth / 300) * 100).toStringAsFixed(
                0);
      }else{
        gameController.porcentajeVida=0.toString();
        print("vida menor a 0");
      }
    }
  }
  void onTapDown(){
    if(!isDead){
      health--;
      if(health<=0){
        isDead =true;
        gameController.score++;
        gameController.puntos++;
        //print(gameController.score);
//        if(gameController.score>(gameController.storage.getInt('highstore')?? 0)){
//          gameController.storage.setInt('highscore', gameController.score);
//        }
      }
    }
  }


}
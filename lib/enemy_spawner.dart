import 'package:flutterjuego/game_controller.dart';
import 'dart:async';
import 'components/enemy.dart';

class EnemySpawner{
  final GameController gameController;
  int maxSpawnInterval = 3000;
  int minSpawnInterval = 700;
  int intervalChange = 3;
  int maxEnemies = 5;
  int currentInterval ;
  int nextSpawn;
  int now;
  EnemySpawner(this.gameController){
    initialize();
  }
  void initialize(){
    killAllEnemies();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }
  void killAllEnemies(){
    gameController.enemies.forEach((Enemy enemy) => enemy.isDead = true);
  }

  void update(double t){
     now = DateTime.now().millisecondsSinceEpoch;
     switch(gameController.nivelJuego){
       case 1:
         maxEnemies=5;
         break;
       case 2:
         maxEnemies=10;
         break;
       case 3:
         maxEnemies=15;
         break;
       default :
         maxEnemies=5;
         break;
     }
    if(gameController.enemies.length < maxEnemies && now >= nextSpawn){
      gameController.spawnEnemy();
      if(currentInterval > minSpawnInterval){
        currentInterval -=intervalChange;
        currentInterval -= (currentInterval*0.1).toInt();
      }
      nextSpawn = now +currentInterval;
      //print("nextspawn :" + nextSpawn.toString());
    }
  }
}
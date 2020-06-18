import 'package:flutterjuego/game_controller.dart';

import 'components/enemy.dart';

class EnemySpawner{
  final GameController gameController;
  int maxSpawnInterval = 3000;
  int minSpawnInterval = 700;
  int intervalChange = 3;
  int maxEnemies = 7;
  int currentInterval ;
  int nextSpawn;
  int now;
  EnemySpawner(this.gameController){
    initialize();
  }
  void initialize(){
    killAllEnemies();
    currentInterval = maxSpawnInterval;
    print("current interval :" +currentInterval.toString());
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }
  void killAllEnemies(){
    gameController.enemies.forEach((Enemy enemy) => enemy.isDead = true);
  }
  void update(double t){
     now = DateTime.now().millisecondsSinceEpoch;
    if(gameController.enemies.length < maxEnemies && now >= nextSpawn){
      gameController.spawnEnemy();
      if(currentInterval > minSpawnInterval){
        currentInterval -=intervalChange;
        currentInterval -= (currentInterval*0.1).toInt();
      }
      nextSpawn = now +currentInterval;
      print("nextspawn :" + nextSpawn.toString());
    }
  }
  void reiniciarSpawner(){
//    maxSpawnInterval=3000;
//    minSpawnInterval=700;
//    currentInterval=0;
//    nextSpawn=0;
//    intervalChange=3;
//    maxEnemies=7;
//    now=0;
    print("reiniciar");
  }
}
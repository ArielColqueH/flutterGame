import 'package:flutterjuego/game_controller.dart';
import 'dart:async';
import 'components/enemy.dart';
// reproduccion de enemigos
class EnemySpawner{
  final GameController gameController;
  int maxSpawnInterval = 3000;//maximo intervalo de distancia entre los enemigos
  int minSpawnInterval = 700;//minimo intervalo de distancia entre enemigos
  int intervalChange = 3; // cantidad minima de enemigos en pantalla
  int maxEnemies = 5; // maxima cantidad de enemigos en pantall
  int currentInterval ;
  int nextSpawn;
  int now;

  //constructor
  EnemySpawner(this.gameController){
    initialize();
  }
  //inicializador
  void initialize(){
    killAllEnemies();
    //se configura el intervalo con el maximo para empezar a disminuirlo y que aceleren al momento de acercase al objeto central
    currentInterval = maxSpawnInterval;
    //en base al tiempo actual que se obtene se le aumenta la cantidad de intervalo maximo que se tiene para acelerar a los enemigos
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }
  void killAllEnemies(){
    //funcion para matar enemigos ,como esta en un arreglo , para cada enemigo producimos
    gameController.enemies.forEach((Enemy enemy) => enemy.isDead = true);
  }

  void update(double t){
     now = DateTime.now().millisecondsSinceEpoch;
     // se obtiene el tiempo en milisegundo se inicio del juego
     // dependiendo al nivel , la maxima cantidad de enemigos puede ir aumentando .
     // en este caso en nivel 1=>5 enemigos,nivel 2 =>10 enemigos , nivel 3=>15 enemigos .
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
      //su la cantidad de enemigo NO sobrepasa a la maxima que se tiene , entonces se va agregando otro enemigo en pantalla
      gameController.spawnEnemy();
      if(currentInterval > minSpawnInterval){
        //mientras se van incrementando el intervalo de distancia se va acordando en tiempo
        currentInterval -=intervalChange;
        currentInterval -= (currentInterval*0.1).toInt();
      }
      //el tiempo de los intervalos se sigue aumentando
      nextSpawn = now +currentInterval;
    }
  }
}
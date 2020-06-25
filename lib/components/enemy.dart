//seccion de creacion del enemigo
import 'dart:ui';
import 'package:flutterjuego/game_controller.dart';
//calse enemigo
class Enemy{
  final GameController gameController;
  int health;
  int damage;
  double speed;
  Rect enemyRect;
  bool isDead =false;
  Path figura ;
  //constructor
  Enemy(this.gameController,double x,double y){
    health = 3;//salud del enemigo
    damage = 1 ;//el danio que causa a nuestro personaje central
    speed = gameController.tilesSize*2;//velocidad
    enemyRect = Rect.fromLTWH(x, y, gameController.tilesSize*1.2, gameController.tilesSize*1.2);//tamanio del cuadrado
  }
  //renderizador
  void render(Canvas c){
    Color color ;
    switch(health){
      case 1:
        switch(gameController.nivelJuego){
        //dependendiendo del nivel del juego(en este caso 3) cambiara el color del enemigo
          case 1:
            color = Color(0xFF7DCFD7);
            break;
          case 2:
            color = Color(0xFFef6459);
            break;
          case 3:
            color = Color(0xFF999999);
            break;
          default:
            color = Color(0xffffffff);
            break;
            //en cada nivel tendra un color principal ,del cual mientras uno
        // trate de eliminarlo ,el color se pondra mas claro dependiendo el toque en el que esta
        }
        //color = Color(0xFF7DCFD7);
        break;
      case 2:
        switch(gameController.nivelJuego){
          case 1:
            color = Color(0xFF2E9CA6);
            break;
          case 2:
            color = Color(0xFFeb3d30);
            break;
          case 3:
            color = Color(0xFF666666);
            break;
          default:
            color = Color(0xffffffff);
            break;
        }
        break;
      case 3:
        color = Color(0x00ffffff);
        switch(gameController.nivelJuego){
          case 1:
            color = Color(0xFF056e78);
            break;
          case 2:
            color = Color(0xFFa52b22);
            break;
          case 3:
            color = Color(0xFF333333);
            break;
          default:
            color = Color(0xffffffff);
            break;
        }
        break;
      default:
        color = Color(0xffffffff);
        break;
    }
    Paint enemyColor = Paint()..color = color;//obtener el color designado
    c.drawRect(enemyRect,enemyColor);//dibujarlo con canvas
  }

  //funcion de actualizacion
  void update(double t){
    if(!isDead){
      //si el enemigo NO esta muerto , la velocidad va en aumento
      double stepDistance = speed * t;
      Offset toPlayer = gameController.player.playerRect.center - enemyRect.center;//aqui se pograma para que el enemigo se acerque a la direccion que se le dio,en este caso el centro
      if(stepDistance <= toPlayer.distance - gameController.tilesSize * 1.5){
        //mientras exista una distacia entre el enmigo y el punto central , estos seguirand avanzando
        Offset stepToPlayer = Offset.fromDirection(toPlayer.direction,stepDistance);
        enemyRect = enemyRect.shift(stepToPlayer);
      }else{
        attack();
      }
    }
  }
//funcion de ataque
  void attack(){
    //mientras que el jugador no este muerto
    if(!gameController.player.isDead){
      gameController.player.currentHealth -=damage;//si un enemigo le hace danio , este le reduce la vida en el ataque que tiene el enemigo
      double porcVida =(gameController.player.currentHealth/300)*100;//la vida es de 300 , y se hace regla de 3 para poder mostrar
      if(porcVida>0) {
        //si la vida es mayor a cero se muestra la impresion en pantalla
        gameController.porcentajeVida =
            ((gameController.player.currentHealth / 300) * 100).toStringAsFixed(
                0);
      }else{
        //si la vida es menor a cero , entonces se setea la variable en 0
        gameController.porcentajeVida=0.toString();
        print("vida menor a 0");
      }
    }
  }
  //funcion cuando se presiona sobre el enemigo
  void onTapDown(){
    if(!isDead){
      //si se presiona, la vida del enemigo se reduce en 1
      health--;
      if(health<=0){
        isDead =true;
        //si sigue vivo , entonces la puntuacion sigue incrementando
        gameController.score++;
        gameController.puntos++;
      }
    }
  }
}
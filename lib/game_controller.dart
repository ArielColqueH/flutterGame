import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuego/components/health_bar.dart';
import 'package:flutterjuego/components/player.dart';
import 'components/enemy.dart';
import 'components/level.dart';
import 'components/score_text.dart';
import 'components/vida_text.dart';
import 'enemy_spawner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

//CONTROLADOR DEL JUEGO
//extiende de GAME , libreria de FLAME para videojuegos
class GameController extends Game {
  //inicializador de variables para tdo el juego
  int maxSpwInt;
  int minSpqInt;
  int nivelJuego;
  String nombreUsuario;
  bool alertPuntuacion = false;
  bool pausado = false;
  bool nuevoJuego = false;
  Random rand;
  Size screenSize;
  double tilesSize;
  Player player;
  List<Enemy> enemies;
  HealhtBar healhtBar;
  EnemySpawner enemySpawner;
  int score;
  ScoreText scoreText;
  Level nivel;
  int puntos;
  String porcentajeVida;
  BuildContext x;
  VidaText vidaText;
  bool juegoTerminado;
  int indexImage = 0;
  GameController(context) {
    initialize();
    this.x = context;
  }
  // inicializar las variables
  void initialize() async {
    resize(await Flame.util.initialDimensions());
    rand = Random();
    player = Player(this);
    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);
    healhtBar = HealhtBar(this);
    score = 0;
    scoreText = ScoreText(this);
    nivel = Level(this);
    puntos = 0;
    nivelJuego = 1;
    porcentajeVida = 100.toString();
    pausado = false;
    vidaText = VidaText(this);
    juegoTerminado = false;
    indexImage = 0;
    tilesSize=0;
  }

  //renderdizar el main de videojuegos
  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);//figura
    Paint backgroundPaint = Paint()..color = Color(0xFF011526);//
    c.drawRect(background, backgroundPaint);//se define el fondo
    player.render(c);//renderizar el jugador
    enemies.forEach((Enemy enemy) => enemy.render(c)); // renderizar enemigos
    scoreText.render(c); // renderizar puntuacion
    nivel.render(c);// renderizar texto de nivel
    healhtBar.render(c);// renderizar barra de salud
    vidaText.render(c); // renderizar texto de vida
  }
  //funcion de renderizacion
  void update(double t) {
    if (pausado == false) {
      enemySpawner.update(t);
      enemies.forEach((Enemy enemy) => enemy.update(t));
      enemies.removeWhere((Enemy enemy) => enemy.isDead);
      player.update(t);
      vidaText.update(t);
      healhtBar.update(t);
      scoreText.update(t);
      nivel.update(t);
      //print("porcetaje vida : "+porcentajeVida.toString());
      int vida = int.parse(porcentajeVida);
      //intercalos de vida , en este caso , cuando cambie de intervalo
      //la imagen del sprite de la casa ira cambiando mientras la vida vaya banjando
      if (vida > 80 && vida <= 100) {
        indexImage = 0;
      } else {
        if (vida > 60 && vida <= 80) {
          indexImage = 1;
        } else {
          if (vida > 40 && vida <= 60) {
            indexImage = 2;
          } else {
            if (vida > 20 && vida <= 40) {
              indexImage = 3;
            } else {
              if (vida > 0 && vida <= 20) {
                indexImage = 4;
              } else {
                indexImage = 4;
              }
            }
          }
        }
      }
      //alerta de puntuacion al acabar el juego cuando la vida llega a 0
      if (alertPuntuacion == true) {
        //print("vida terminada");
        showAlert(x);
      }
      print("nivel juego : " + nivelJuego.toString());
      //alerta de puntuacion al acabar el juego cuando los niveles se acaban
      if (nivelJuego == 4) {
        pausado = true;
        //print("juego terminado");
        showAlert(x);
      }
    }
  }

  void resize(Size size) {
    screenSize = size;
    //print("screenSize:"+screenSize.toString());
    tilesSize = screenSize.width / 10;
  }

  void onTapDown(TapDownDetails d) {
    //print("posicion" + d.globalPosition.toString());
    enemies.forEach((Enemy enemy) {
      if (enemy.enemyRect.contains(d.globalPosition)) {
        print("le diste");
        enemy.onTapDown();
      }
    });
  }

  void spawnEnemy() {
    // en esta funcion es donde se asigan la posicion previa de los enemigo de forma randomica
    //ejes de posicion de enemigo
    double x, y;
    switch (rand.nextInt(4)) {
      case 0: //arriba
        x = rand.nextDouble() * screenSize.width;
        y = -tilesSize * 2.5;
        break;
      case 1:
        //derecha
        x = screenSize.width + tilesSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
      case 2: //abajo
        x = rand.nextDouble() * screenSize.width;
        y = screenSize.height + tilesSize * 2.5;
        break;
      case 3:
        //izquierda
        x = -tilesSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
    }
    //aqui se aumenta los enemigos al arreglo principal
    enemies.add(Enemy(this, x, y));
  }

  //funcion de reiniciar el juego en caso de que se lo desee asi
  void restartGame() {
    //se inicializan las variables una vez mas y tambien el inicializador del juego
    puntos = 0;
    enemies.clear();
    player.currentHealth = player.maxHealt;
    player.isDead = false;
    initialize();
  }

  //widget de dialogo que se muestra al acabar el juego
  void showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        title: Text("Tabla de Puntuaciones"),
        content: TextField(
          onChanged: (String value) {
            nombreUsuario = value;
          },
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              print(nombreUsuario);
              print("puntuacion final : " + puntos.toString());
              //crea al usuario para mandarlo a firebase con su respetivo puntaje
              createTodos();
              Navigator.of(context).pop();
            },
            child: Text(
              "Agregar nombre",
              style: TextStyle(color: Color(0xFF2E9AA6)),
            ),
          )
        ],
      ),
    );
    alertPuntuacion = false;
  }
//funciones para enviar datos a firebase
  createTodos() {
    DocumentReference documentReference = Firestore.instance
        .collection("PuntuacionesSurvival")
        .document(nombreUsuario);
    Map<String, dynamic> todos = {
      "nombre": nombreUsuario,
      "puntuacion": puntos
    };
    documentReference.setData(todos).whenComplete(() {
      print("$nombreUsuario created");
    });
  }
}

import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuego/components/health_bar.dart';
import 'package:flutterjuego/components/highscore_text.dart';
import 'package:flutterjuego/components/player.dart';
import 'package:flutterjuego/components/start_text.dart';
import 'package:flutterjuego/components/menu_principal_text.dart';
import 'package:flutterjuego/state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/enemy.dart';
import 'components/level.dart';
import 'components/score_text.dart';
import 'components/vida_text.dart';
import 'enemy_spawner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

class GameController extends Game {
  Timer _timer;
  int _start = 10;
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
  StateMenu state;
  HighScoreText highScoreText;
  StartText startText;
  MenuPrincipalText menuPrincipalText;
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

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    state = StateMenu.menu;
    rand = Random();
    player = Player(this);
    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);
    healhtBar = HealhtBar(this);
    score = 0;
    scoreText = ScoreText(this);
    nivel = Level(this);
    highScoreText = HighScoreText(this);
    startText = StartText(this);
    menuPrincipalText = MenuPrincipalText(this);
    puntos = 0;
    nivelJuego = 1;
    porcentajeVida = 100.toString();
    pausado = false;
    vidaText = VidaText(this);
    juegoTerminado = false;
    indexImage = 0;
  }

  void render(Canvas c) {
    Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
    Paint backgroundPaint = Paint()..color = Color(0xFF011526);
    c.drawRect(background, backgroundPaint);
    player.render(c);
    enemies.forEach((Enemy enemy) => enemy.render(c));
    scoreText.render(c);
    nivel.render(c);
    healhtBar.render(c);
    vidaText.render(c);
  }

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

      if (alertPuntuacion == true) {
        print("vida terminada");
        showAlert(x);
      }
      print("nivel juego : " + nivelJuego.toString());
      if (nivelJuego == 4) {
        pausado = true;
        print("juego terminado");
        showAlert(x);
      }
    }
  }

  void resize(Size size) {
    screenSize = size;
    tilesSize = screenSize.width / 10;
  }

  void onTapDown(TapDownDetails d) {
    print("posicion" + d.globalPosition.toString());
    enemies.forEach((Enemy enemy) {
      if (enemy.enemyRect.contains(d.globalPosition)) {
        print("le diste");
        enemy.onTapDown();
      }
    });
  }

  void spawnEnemy() {
    double x, y;
    switch (rand.nextInt(4)) {
      case 0: //top
        x = rand.nextDouble() * screenSize.width;
        y = -tilesSize * 2.5;
        break;
      case 1:
        //right
        x = screenSize.width + tilesSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
      case 2: //bottom
        x = rand.nextDouble() * screenSize.width;
        y = screenSize.height + tilesSize * 2.5;
        break;
      case 3:
        //left
        x = -tilesSize * 2.5;
        y = rand.nextDouble() * screenSize.height;
        break;
    }
    enemies.add(Enemy(this, x, y));
  }

  void restartGame() {
    puntos = 0;
    enemies.clear();
    player.currentHealth = player.maxHealt;
    player.isDead = false;
    initialize();
  }

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
//                  setState(() {
              createTodos();
//                  });
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

  createTodos() {
    //final _formKey =GlobalKey<FormState>();
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

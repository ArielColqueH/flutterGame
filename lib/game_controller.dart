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
import 'components/score_text.dart';
import 'enemy_spawner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameController extends Game{
//  final SharedPreferences storage;
  String nombreUsuario;
  bool alertPuntuacion = false;
  bool pausado=false;
  bool nuevoJuego=false;
  Random rand;
  Size screenSize ;
  double tilesSize;
  Player player;
  List<Enemy> enemies ;
  HealhtBar healhtBar;
  EnemySpawner enemySpawner;
  int score;
  ScoreText scoreText;
  StateMenu state ;
  HighScoreText highScoreText;
  StartText startText;
  MenuPrincipalText menuPrincipalText;
  int puntos;
  BuildContext x;
//  Sprite playerFrame= Sprite('casa.png');

  GameController(context){
    initialize();
    this.x=context;
  }

  void initialize() async {
    resize(await Flame.util.initialDimensions());
    state = StateMenu.menu;
    rand = Random();
    player=Player(this);
    enemies = List<Enemy>();
    enemySpawner = EnemySpawner(this);
    healhtBar = HealhtBar(this);
    score = 0;
    scoreText = ScoreText(this);
    highScoreText = HighScoreText(this);
    startText = StartText(this);
    menuPrincipalText = MenuPrincipalText(this);
    puntos =0;
    pausado=false;
    //alertPuntuacion=false;
    print("alerta init: "+alertPuntuacion.toString());
  }

//  void renderAlert ()async{
//    await alertPuntuacion;
//  }
  void render(Canvas c){
//    if(pausado!=true){
      Rect background = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
      Paint backgroundPaint= Paint()..color=Color(0xFF011526);
      c.drawRect(background, backgroundPaint);
      player.render(c);
      enemies.forEach((Enemy enemy)=>enemy.render(c));
      scoreText.render(c);
      healhtBar.render(c);
//    }
  }

  void update(double t){
    if(pausado==false) {
        enemySpawner.update(t);
        enemies.forEach((Enemy enemy)=>enemy.update(t));
        enemies.removeWhere((Enemy enemy)=> enemy.isDead);
        player.update(t);
        healhtBar.update(t);
        scoreText.update(t);
        print("alerta update :"+alertPuntuacion.toString());
        if(alertPuntuacion==true){
          showAlert(x);
        }
    }
  }
  void resize(Size size){
    screenSize=size;
    tilesSize = screenSize.width/10;
  }

  void onTapDown(TapDownDetails d){
    print(d.globalPosition);
      enemies.forEach((Enemy enemy){
        if(enemy.enemyRect.contains(d.globalPosition)){
          enemy.onTapDown();
        }
      });
  }
  void spawnEnemy(){
    double x,y;
    switch(rand.nextInt(4)){
      case 0://top
        x = rand.nextDouble() * screenSize.width;
        y = -tilesSize *2.5;
        break;
      case 1:
        //right
        x=screenSize.width+tilesSize *2.5;
        y=rand.nextDouble()*screenSize.height;
        break;
      case 2://bottom
        x=rand.nextDouble() * screenSize.width;
        y= screenSize.height + tilesSize*2.5;
        break;
      case 3:
        //left
        x = -tilesSize *2.5;
        y= rand.nextDouble() * screenSize.height;
        break;
    }
    enemies.add(Enemy(this,x,y));
  }

  void restartGame(){
    puntos=0;
    enemies.clear();
    player.currentHealth = player.maxHealt;
    player.isDead =false;
  }

  void showAlert(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
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
//                  setState(() {
                    createTodos();
//                  });
                  Navigator.of(context).pop();
                },
                child: Text("Agregar nombre",style: TextStyle(color: Color(0xFF2E9AA6)),),
              )
            ],
          ),
      );
      alertPuntuacion=false;
  }

  createTodos() {
    DocumentReference documentReference =
    Firestore.instance.collection("PuntuacionesSurvival").document(nombreUsuario);
    Map<String, String> todos = {"todoTitle": nombreUsuario};
    documentReference.setData(todos).whenComplete(() {
      print("$nombreUsuario created");
    });
  }

}
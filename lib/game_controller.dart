import 'dart:math';
import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
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

class GameController extends Game{
//  final SharedPreferences storage;
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
//  Sprite playerFrame= Sprite('casa.png');

  GameController(){
    initialize();
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
  }
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
    //enemy.update(t);
    if(pausado==false) {
        enemySpawner.update(t);
        enemies.forEach((Enemy enemy)=>enemy.update(t));
        enemies.removeWhere((Enemy enemy)=> enemy.isDead);
        player.update(t);
        healhtBar.update(t);
        scoreText.update(t);
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
    //print(d.globalPosition);
    //enemy.health--;

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
    player.currentHealth =player.maxHealt;
    player.isDead =false;
  }

}
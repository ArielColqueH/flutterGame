import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterjuego/game_controller.dart';

class HighScoreText{
  final GameController gameController;
  TextPainter painter;
  Offset position;

  HighScoreText(this.gameController){
    painter = TextPainter(textAlign: TextAlign.center,textDirection: TextDirection.ltr);
    position = Offset.zero;
  }
  void render(Canvas c){
    painter.paint(c, position);
  }
  void update(double t){
    int highScore = gameController.storage.getInt('highscore') ?? 0;

      painter.text = TextSpan(text:'Highscore $highScore',
          style: TextStyle(color: Colors.white,fontSize: 40.0));
      painter.layout();
      position = Offset((gameController.screenSize.width/2) - (painter.width/2),(gameController.screenSize.height*0.2) - (painter.height/2));


  }
}
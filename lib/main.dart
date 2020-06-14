import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
//import 'package:shared_preferences/shared_preferences.dart';
//
//import 'game_controller.dart';
//
//void main() async{
//  WidgetsFlutterBinding.ensureInitialized();
//  Util flameUtil = Util();
//  await flameUtil.fullScreen();
//  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
//
//  SharedPreferences storage = await SharedPreferences.getInstance();
//  GameController gameController = GameController(storage);
//
//  //runApp(gameController.widget);
//
//
//  TapGestureRecognizer tapper = TapGestureRecognizer();
//  tapper.onTapDown = gameController.onTapDown;
//  flameUtil.addGestureRecognizer(tapper);
//}

import 'package:flutter/material.dart';
import 'package:flutterjuego/puntuaciones.dart';
import 'package:flutterjuego/inicio.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF011526)),
        home: MyHome()
    );
  }
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

      return Scaffold(
        body: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            new Text(
              "SURVIVAL",
              style: new TextStyle(fontSize: 50.0, color: Colors.white),
            ),
            new Expanded(
              child: Container(),
            ),
            ButtonTheme(
              minWidth: 240.0,
              height: 60.0,
              child: new RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.white)),
                //              splashColor: Color(0xFFBF7EBB),
                color: Color(0xFFBF7EBB),
                child: new Text(
                  "JUGAR",
                  style: new TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onPressed: () {
                  print('Puntuaciones clicked');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => thirdRoute()),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            ButtonTheme(
              minWidth: 240.0,
              height: 60.0,
              child: new RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.white)),
                //              splashColor: Color(0xFFBF7EBB),
                color: Color(0xFFBF7EBB),
                child: new Text(
                  "VER PUNTUACIONES",
                  style: new TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                onPressed: () {
                  print('Puntuaciones clicked');
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondRoute()),
                  );
                },
              ),
            ),
            new Expanded(
              child: Container(),
            ),
          ],
        ),
      );

  }
}

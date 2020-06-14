import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_controller.dart';
import 'package:flutter/material.dart';
//void iniciar() async{
//  WidgetsFlutterBinding.ensureInitialized();
//  Util flameUtil = Util();
//  await flameUtil.fullScreen();
//  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
//
//  SharedPreferences storage = await SharedPreferences.getInstance();
//  GameController gameController = GameController(storage);
//
//  runApp(gameController.widget);
//
//  TapGestureRecognizer tapper = TapGestureRecognizer();
//  tapper.onTapDown = gameController.onTapDown;
//  flameUtil.addGestureRecognizer(tapper);
//}

class thirdRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return route();
  }

}

class route extends State<thirdRoute>{
  //LangawGame game;
  @override
  void iniciar()async{
    WidgetsFlutterBinding.ensureInitialized();
    Util flameUtil = Util();
    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitUp);

    SharedPreferences storage = await SharedPreferences.getInstance();
    GameController gameController = GameController(storage);

    runApp(gameController.widget);

    TapGestureRecognizer tapper = TapGestureRecognizer();
    tapper.onTapDown = gameController.onTapDown;
    flameUtil.addGestureRecognizer(tapper);
  }
  void initState() {
    iniciar();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Text("as"),
    );
  }

//  @override
//  Widget build(BuildContext context) {
//
//    // TODO: implement build
//    Size ScreenSize=MediaQuery.of(context).size;
//    return Scaffold(
//
//    );
//  }
}
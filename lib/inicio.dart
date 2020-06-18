import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_controller.dart';
import 'package:flutter/material.dart';

class thirdRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _route();
  }
}

class _route extends State<thirdRoute> {
  @override
  GameController gameController;
  void iniciar() async {
    print("entro a iniciar");
    WidgetsFlutterBinding.ensureInitialized();
    Util flameUtil = Util();

    gameController = GameController(context);

    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitUp);

    TapGestureRecognizer tapper = TapGestureRecognizer();
    tapper.onTapDown = gameController.onTapDown;
    flameUtil.addGestureRecognizer(tapper);
    //print("gc:" + gameController.alertPuntuacion.toString());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: new Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/virus1.png'),
              fit: BoxFit.cover)),
      child: new Stack(
        children: <Widget>[
          gameController.widget != null ? gameController.widget : Container(),
          Center(
            child: new Image(
              width: 139,
              height: 139,
              image: AssetImage('assets/images/casa.png'),
            ),
          ),
          new RawMaterialButton(
            onPressed: () {
              gameController.pausado = true;
              print('pause');
              showDialog(
                context: context,
                builder: (context) {
                  return Theme(
                      data: Theme.of(context)
                          .copyWith(dialogBackgroundColor: Colors.black12),
                      child: new AlertDialog(
                        title: Center(
                          child: Text(
                            "Pausa",
                            style: TextStyle(
                              color: Colors.purpleAccent,
                              fontSize: 50.0,
                            ),
                          ),
                        ),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            OutlineButton(
                              //splashColor: Colors.lightBlue,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              color: Colors.transparent,
                              child: new Text(
                                "Continuar",
                                style: new TextStyle(
                                    fontSize: 30.0, color: Colors.purpleAccent),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                gameController.pausado = false;
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            OutlineButton(
                              splashColor: Colors.lightBlue,
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              color: Colors.transparent,
                              child: new Text(
                                "Reiniciar",
                                style: new TextStyle(
                                    fontSize: 30.0, color: Colors.purpleAccent),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                                gameController.restartGame();
                                gameController.pausado = false;
                              },
                            ),
                            SizedBox(height: 25),
                            OutlineButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0)),
                              color: Colors.transparent,
                              child: new Text(
                                "Menu Principal",
                                style: new TextStyle(
                                    fontSize: 30.0, color: Colors.purpleAccent),
                              ),
                              onPressed: () {
                                gameController.pausado = true;
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ));
                },
              );
            },
            elevation: 2.0,
            fillColor: Color(0xFF2E9AA6),
            child: new IconTheme(
              data: new IconThemeData(color: Colors.white),
              child: new Icon(Icons.pause),
            ),
            padding: EdgeInsets.all(12.0),
            shape: CircleBorder(),
          ),
        ],
      ),
    ));
  }

  void initState() {
    iniciar();
  }
}

import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_controller.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class thirdRoute extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _route();
  }
}

class _route extends State<thirdRoute> {
  //variables iniciales para la pantalla de inicio de juego
  int maxNiveles = 3; // niveles creados
  Timer _timer; //objeto de tiempo para el timer
  int segloop =
      20; // segundo de duracion de cada nivel estatico para que vez que se reinicia el juego o tiene que hacer otro loop
  int _start = 20; //segundos por default al iniciar cada nivel
  List<String> a = [
    "casa1",
    "casa2",
    "casa3",
    "casa4",
    "casa5"
  ]; //lista de imagenes para el objeto central
  @override
  GameController gameController;

  void iniciar() async {
    WidgetsFlutterBinding.ensureInitialized();
    Util flameUtil = Util();
    gameController = GameController(context);
    await Flame.util.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitUp);
    TapGestureRecognizer tapper = TapGestureRecognizer();
    tapper.onTapDown = gameController.onTapDown;
    flameUtil.addGestureRecognizer(tapper);
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: new Container(
      child: new Stack(
        children: <Widget>[
          gameController.widget != null ? gameController.widget : Container(),
          Center(
            child: new Image(
              width: 139,
              height: 139,
              image: AssetImage(
                  'assets/images/' + a[gameController.indexImage] + ".png"),
            ),
          ),
          //boton de pausar la partida, aqui se podran observar ciertas funciones
          new RawMaterialButton(
            onPressed: () {
              //control de bandera para pausar el juego ya que todas las funciones son asincronas
              gameController.pausado = true;
//              print('pause');
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
                          //botton continuar
                          OutlineButton(
                            //splashColor: Colors.lightBlue,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Colors.transparent,
                            child: new Text(
                              "Continuar",
                              style: new TextStyle(
                                  fontSize: 30.0, color: Colors.purpleAccent),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              //control de bandera para despausar el juego
                              gameController.pausado = false;
                            },
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          //botton reiniciar
                          OutlineButton(
                            splashColor: Colors.lightBlue,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
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
                              _start = segloop;
                              startTimer();
                            },
                          ),
                          SizedBox(height: 25),
                          //botton ir a menu principal
                          OutlineButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Colors.transparent,
                            child: new Text(
                              "Menu Principal",
                              style: new TextStyle(
                                  fontSize: 30.0, color: Colors.purpleAccent),
                            ),
                            onPressed: () {
                              //gameController.pausado = false;
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ),

                        ],
                      ),
                    ),
                  );
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

  //funcion de tiempo
  void startTimer() {
    //print("start :"+_start.toString());
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            print("pasaron " + segloop.toString() + " segundos");
            gameController.nivelJuego++;
            if (gameController.nivelJuego == 4) {
              timer.cancel();
            } else {
              _start = segloop;
            }
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  //funcion de cancelar el timer cuando del juego acabe
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

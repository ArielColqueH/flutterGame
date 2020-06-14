import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
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
          new Text(
            "Top 5 puntuaciones",
            style: new TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          SizedBox(height: 30),
          Container(
              //margin: EdgeInsets.all(5),
              margin: const EdgeInsets.only(left: 25.0, right: 25.0),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFF2E9AA6),
                border: Border.all(
                    color: Colors.white, // set border color
                    width: 3.0), // set border width
                borderRadius: BorderRadius.all(
                    Radius.circular(30.0)), // set rounded corner radius
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Text(
                        "1",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      new Text(
                        "JRG",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      new Text(
                        "300 pts",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Text(
                        "1",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      new Text(
                        "JRG",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      new Text(
                        "300 pts",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Text(
                        "1",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      new Text(
                        "JRG",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      new Text(
                        "300 pts",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Text(
                        "1",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      new Text(
                        "JRG",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      new Text(
                        "300 pts",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      new Text(
                        "1",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      new Text(
                        "JRG",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      new Text(
                        "300 pts",
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              )),
          SizedBox(
            height: 20.0,
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
                "Menu Principal",
                style: new TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          new Expanded(
            child: Container(),
          ),
        ],
      ),
    );
    return Scaffold(
      body: Center(
        child: new Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(3.0),
          decoration:
              BoxDecoration(border: Border.all(color: Colors.blueAccent)),
          child: Text("My Awesome Border"),
        ),
      ),
    );
  }
}

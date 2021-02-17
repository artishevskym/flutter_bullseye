import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bullseye/prompt.dart';
import 'package:flutter_bullseye/control.dart';
import 'package:flutter_bullseye/score.dart';
import 'package:flutter_bullseye/game_model.dart';

void main() => runApp(BullsEyeApp());

/*
TO-DO LIST
+ Add the "Hit Me" button
+ Show a popup when the user taps it
+ Put game info on screen
+ Put slider on screen: 1->100
+ Read value of the slider
- Generate random number
- Calculate and show score
- Add "start over" button
- Reset game if you tap it
- Put app in landscape
- Make it look pretty
 */

class BullsEyeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    return MaterialApp(
      title: 'BullsEye',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GamePage(title: 'BullsEye'),
    );
  }
}

class GamePage extends StatefulWidget {
  GamePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool _alertIsVisible = false;
  GameModel _model;

  @override
  void initState() {
    super.initState();
    _model = GameModel(50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Prompt(targetValue: _model.target),
              Control(model: _model),
              FlatButton(
                onPressed: () {
                  print("Button pressed!");
                  this._alertIsVisible = true;
                  _showAlert(context);
                },
                child: Text(
                  'Hit Me!',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
              Score(
                totalScore: _model.totalScore,
                round: _model.round,
              ),
            ]),
      ),
    );
  }

  void _showAlert(BuildContext context) {
    Widget okButton = FlatButton(
        child: Text("Awesome!"),
        onPressed: () {
          Navigator.of(context).pop();
          this._alertIsVisible = false;
          print("Awesome pressed! $_alertIsVisible");
        });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hello there!"),
          content: Text("The slide's value is ${_model.current}"),
          actions: <Widget>[
            okButton,
          ],
          elevation: 5,
        );
      },
    );
  }
}

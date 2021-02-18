import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bullseye/prompt.dart';
import 'package:flutter_bullseye/control.dart';
import 'package:flutter_bullseye/score.dart';
import 'package:flutter_bullseye/game_model.dart';
import 'dart:math';

void main() => runApp(BullsEyeApp());

/*
TO-DO LIST
+ Add the "Hit Me" button
+ Show a popup when the user taps it
+ Put game info on screen
+ Put slider on screen: 1->100
+ Read value of the slider
+ The Dart Standard Library
+ Writing Methods
+ If/Else Statements
+ Variable Scope
+ Generate random number
+ Calculate and show score
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
    _model = GameModel(Random().nextInt(100) + 1);
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
                  _showAlert(context);
                  this._alertIsVisible = true;
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

  int _sliderValue() => _model.current;

  int _pointsForCurrentRound() {
    var maximumScore = 100;
    return maximumScore - _amountOff();
  }

  int _amountOff() => (_model.target - _sliderValue()).abs();

  void _showAlert(BuildContext context) {
    Widget okButton = FlatButton(
        child: Text("Awesome!"),
        onPressed: () {
          Navigator.of(context).pop();
          this._alertIsVisible = false;
          setState(() {
            _model.totalScore += _pointsForCurrentRound();
            _model.target = Random().nextInt(100) + 1;
            _model.round += 1;
          });
        });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_alertTitle()),
          content: Text("The slide's value is ${_sliderValue()}.\n" +
          "You scored ${_pointsForCurrentRound()} points this round."),
          actions: <Widget>[
            okButton,
          ],
          elevation: 5,
        );
      },
    );
  }

  String _alertTitle() {
    var difference = _amountOff();

    String title;
    if (difference == 0) {
      title = "Perfect";
    } else if (difference < 5) {
      title = "You almost had it!";
    } else if (difference <= 10) {
      title = "Not bad.";
    } else {
      title = "Are you even trying?";
    }

    return title;
  }
}

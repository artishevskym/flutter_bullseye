import 'package:flutter/material.dart';

class Score extends StatelessWidget {
  Score({
    Key key,
    @required this.totalScore,
    @required this.round,
    @required this.onStartOver,
  }) : super(key: key);

  final int totalScore;
  final int round;
  final VoidCallback onStartOver;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FlatButton(
          child: Text("Start Over"),
          onPressed: () {
            onStartOver();
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text("Score: "),
              Text("$totalScore"),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text("Round: "),
              Text("$round"),
            ],
          ),
        ),
        FlatButton(
          child: Text("Info"),
          onPressed: () {},
        ),
      ],
    );
  }
}

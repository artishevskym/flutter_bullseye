import 'package:flutter/material.dart';
import 'package:flutter_bullseye/textstyles.dart';
import 'package:flutter_bullseye/styledbutton.dart';
import 'package:flutter_bullseye/about.dart';

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
        StyledButton(
          icon: Icons.refresh,
          onPressed: () {
            onStartOver();
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Column(
            children: [
              Text(
                "Score: ",
                style: LabelTextStyle.bodyText1(context),
              ),
              Text(
                "$totalScore",
                style: ScoreNumberTextStyle.headline4(context),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Column(
            children: [
              Text(
                "Round: ",
                style: LabelTextStyle.bodyText1(context),
              ),
              Text(
                "$round",
                style: ScoreNumberTextStyle.headline4(context),
              ),
            ],
          ),
        ),
        StyledButton(
          icon: Icons.info,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutPage()),
            );
          },
        ),
      ],
    );
  }
}

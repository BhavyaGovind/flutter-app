import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int finalScore;
  final VoidCallback resetHandler;

  Result(this.finalScore, this.resetHandler);

  String get resultPhrase {
    if (finalScore <= 10) {
      return "You are awesome";
    } else if (finalScore <= 15) {
      return "You are little sacrier";
    } else {
      return "You need counciling";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: <Widget>[
        Text(
          resultPhrase,
          style: TextStyle(
              color: Colors.blue, fontSize: 23, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        TextButton(onPressed: resetHandler, child: Text('Restart Quiz!'))
      ]),
    );
  }
}

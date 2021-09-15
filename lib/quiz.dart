import 'package:flutter/material.dart';

import './answer.dart';
import './question.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  const Quiz(
      {required this.questions,
      required this.questionIndex,
      required this.answerQuestion});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ignore: cast_nullable_to_non_nullable
        Question(questions[questionIndex]['questiontext'] as String),
        // ignore: cast_nullable_to_non_nullable
        ...(questions[questionIndex]['answers'] as List<Map<String,Object>>).map((answer) {
          // ignore: cast_nullable_to_non_nullable
          return Answer(() => answerQuestion(answer['score']), answer['text'] as String);
        }).toList()
      ],
    );
  }
}

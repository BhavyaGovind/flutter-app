// ignore: import_of_legacy_library_into_null_safe
import 'package:appcenter/appcenter.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:appcenter_analytics/appcenter_analytics.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:appcenter_crashes/appcenter_crashes.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import './quiz.dart';
import './result.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String _appSecret = "59106bfc-6cac-425e-97d0-1b00ef267852";
  String _installId = "Unknown";
  bool _areAnalyticsEnabled = false, _areCrashesEnabled = false;

  _MyAppState() {
    final ios = defaultTargetPlatform == TargetPlatform.iOS;
    //_appSecret = ios ? "" : "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {

    
    await AppCenter.start(
        _appSecret, [AppCenterAnalytics.id, AppCenterCrashes.id]);
    if (!mounted) return;
    var installId = await AppCenter.installId;

    var areAnalyticsEnabled = await AppCenterAnalytics.isEnabled;
    var areCrashesEnabled = await AppCenterCrashes.isEnabled;

    setState(() {
      _installId = installId;
      _areAnalyticsEnabled = areAnalyticsEnabled;
      _areCrashesEnabled = areCrashesEnabled;
    });
  }

  final _questions = const [
    {
      'questiontext': 'What is your favorite color?',
      'answers': [
        {'text': 'Yellow', 'score': 10},
        {'text': 'Blue', 'score': 5},
        {'text': 'Black', 'score': 1},
        {'text': 'Red', 'score': 12}
      ]
    },
    {
      'questiontext': 'what is your favourite animal?',
      'answers': [
        {'text': 'Snake', 'score': 15},
        {'text': 'Dog', 'score': 5},
        {'text': 'cat', 'score': 3},
        {'text': 'python', 'score': 20}
      ]
    },
    {
      'questiontext': 'What is your favorite tech stack',
      'answers': [
        {'text': 'Flutter', 'score': 1},
        {'text': 'Vue', 'score': 5},
        {'text': 'React', 'score': 10},
        {'text': 'Javascript', 'score': 15}
      ]
    },
  ];
  var _questionIndex = 0;
  var _totalScore = 0;
  void resetQuiz() {
    setState(() {
      _totalScore = 0;
      _questionIndex = 0;
    });
  }

  void _answerQuestions(int score) {
    setState(() {
      _questionIndex = _questionIndex + 1;
      _totalScore += score;
    });
    // print('Answer Choose');
    if (_questionIndex < _questions.length) {
      // print('We have more questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Simple Quiz App'),
            backgroundColor: Colors.amber,
          ),
          body: (_questionIndex < _questions.length)
              ? Quiz(
                  questions: _questions,
                  questionIndex: _questionIndex,
                  answerQuestion: _answerQuestions)
              : Result(_totalScore, resetQuiz)),
    );
  }
}

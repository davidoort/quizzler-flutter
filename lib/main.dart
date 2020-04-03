import 'package:flutter/material.dart';
import 'question.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static final questions = <QandA>[
    QandA('You can lead a cow down stairs but not up stairs.', false),
    QandA('Approximately one quarter of human bones are in the feet.', true),
    QandA('A slug\'s blood is green.', true),
  ];

  final List<Icon> _scoreKeeper = <Icon>[];
  static final startQuestionIndex = 0;
  int questionIndex = startQuestionIndex;

  void _answerHandle(bool answer) {
    if (answer == questions[questionIndex].answer) {
      setState(() {
        _scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      });
    } else {
      setState(() {
        _scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      });
    }

    setState(() {
      // Increment question index
      questionIndex = (questionIndex + 1) % questions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions[questionIndex].question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              // textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                _answerHandle(true);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                _answerHandle(false);
              },
            ),
          ),
        ),
        Wrap(
          direction: Axis.horizontal,
          children: _scoreKeeper,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

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
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scoreKeeper = [];
  int questionIndex = 1;
  Icon rightAnswer() {
    return Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  Icon wrongAnswer() {
    return Icon(
      Icons.close,
      color: Colors.red,
    );
  }

  Icon getAnswer(bool userAnswer) {
    Icon answer;
    if (quizBrain.getQuestionAnswer() == userAnswer) {
      scoreKeeper.add(answer = rightAnswer());
    } else {
      scoreKeeper.add(answer = wrongAnswer());
    }
    return answer;
  }

  void updateQuestionIndex() {
    questionIndex++;
    if (questionIndex >= quizBrain.getNumberOfQuestions()) {
      questionIndex = 0;
    }
  }

  void restartQuiz() {
    Alert(
      context: context,
      title: "QuizBrain Alert",
      desc: "Quiz Completed!",
    ).show();
    quizBrain.reset();
    scoreKeeper.clear();
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
                quizBrain.getQuestionText(),
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
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green)),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (!quizBrain.isFinished()) {
                    getAnswer(true);
                    quizBrain.nextQuestion();
                  } else {
                    restartQuiz();
                  }
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red)),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  if (!quizBrain.isFinished()) {
                    getAnswer(false);
                    quizBrain.nextQuestion();
                  } else {
                    restartQuiz();
                  }
                });
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/

import 'quiz_brain.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(Padding(
    padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
    child: Quizzler(),
  ));
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
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
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        //Modified for our purposes:
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();
        // reset the questionNumber,
        quizBrain.reset();

        // empty out the scoreKeeper.
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }

        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
        ), //for question
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                //the user picked true;
                checkAnswer(true);
              },
              child: Text(
                'TRUE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ), //for true
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                //the user picked false.
                checkAnswer(false);
              },
              child: Text(
                'FALSE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ), //for false

        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}

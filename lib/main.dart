import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:quiz/quiz_brain.dart';
import 'package:flutter/material.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Quizzler')),
        ),
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: QuizzlerPage(),
          ),
        ),
        backgroundColor: Colors.grey.shade900,
      ),
    );
  }
}

class QuizzlerPage extends StatefulWidget {
  const QuizzlerPage({Key? key}) : super(key: key);

  @override
  State<QuizzlerPage> createState() => _QuizzlerPageState();
}

class _QuizzlerPageState extends State<QuizzlerPage> {
  QuizBrain quizBrain = QuizBrain();
  List<Icon> scoreKeeper = [];

  Icon iconCheck = const Icon(Icons.check, color: Colors.green);
  Icon iconColes = const Icon(Icons.close, color: Colors.red);
  int rightAnswer = 0;
  int wrongAnswer = 0;

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          type: AlertType.none,
          title: "Finished!",
          desc:
          'You\'ve reached the end of the quiz.   you get $rightAnswer from 13',
          buttons: [
            DialogButton(
              onPressed: () => Navigator.pop(context),
              width: 120,
              child: Text(
                "RESTART",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
        rightAnswer = 0;
        quizBrain.reset();
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          quizBrain.nextQuestion();
          rightAnswer++;
          scoreKeeper.add(iconCheck);
        } else {
          quizBrain.nextQuestion();
          wrongAnswer++;
          scoreKeeper.add(iconColes);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                checkAnswer(true);
              },
              child: const Text(
                'True',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                checkAnswer(false);
              },
              child: const Text(
                'False',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
          ),
        ),
        Row(children: scoreKeeper),

        /*  TextButton(onPressed: (){}, child: Container(child: Center(child: Text ('True',style: TextStyle(color: Colors.white),)),width: 300,padding: EdgeInsets.all(25),color: Colors.red),),
      TextButton(onPressed: (){}, child: Text ('False'),),*/
      ],
    );
  }
}

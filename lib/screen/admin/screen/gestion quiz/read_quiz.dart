import 'dart:async';
import 'package:amir/Services/multiple_quiz_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../models/multiple_quiz_model.dart';

class QuizScreen extends StatefulWidget {
  String idquiz;
    QuizScreen({super.key, required this.idquiz});
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionIndex = 0;
  int score = 0;
  int timerDuration = 15;
  bool isLoaded = true;
  MultipleController multipleController = MultipleController();
  getData() async {
    oneQuestion =
        await multipleController.getSpecQuiz(widget.idquiz);
    setState(() {
      isLoaded = false;
      questions = oneQuestion!.questions;
    });
  }

// in seconds
  MultipQuizModel? oneQuestion;
  List<Question> questions = [];

  List<int> selectedOptions = [];
  List<bool> answerResults = [];
  Timer? timer;
  int countdown = 0;

  @override
  void initState() {
    super.initState();
    getData();

    startTimer();
  }

  void startTimer() {
    countdown = timerDuration;
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (countdown == 0) {
        timer.cancel();
        checkAnswer();
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  void checkAnswer() {
    timer?.cancel();

    List correctAnswerIndices = questions[questionIndex].correctAnswerIndices;
    List<int> selectedAnswerIndices = selectedOptions;

    selectedAnswerIndices.sort();
    correctAnswerIndices.sort();

    bool isCorrect = listEquals(selectedAnswerIndices, correctAnswerIndices);

    setState(() {
      answerResults.add(isCorrect);
      if (isCorrect) {
        score++;
      }
    });

    if (questionIndex < questions.length - 1) {
      setState(() {
        questionIndex++;
        selectedOptions = [];
      });
      startTimer();
    } else {
      // Quiz completed, show score and answer results
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Quiz Completed'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Your score: $score/${questions.length}'),
                SizedBox(height: 16.0),
                Text('Answer Results:'),
                SizedBox(height: 8.0),
                ...answerResults.asMap().entries.map((result) {
                  int questionIndex = result.key;
                  bool isCorrect = result.value;
                  Question question = questions[questionIndex];
                  return ListTile(
                    title: Text(
                      question.text,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      isCorrect ? 'Correct' : 'Wrong',
                      style: TextStyle(
                          color: isCorrect ? Colors.green : Colors.red),
                    ),
                  );
                }),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  resetQuiz();
                },
                child: Text('Play Again'),
              ),
            ],
          );
        },
      );
    }
  }

  void resetQuiz() {
    setState(() {
      questionIndex = 0;
      score = 0;
      selectedOptions = [];
      answerResults = [];
    });
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Quiz'),
      ),
      body: isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Question ${questionIndex + 1}/${questions.length}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    questions[questionIndex].text,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 16.0),
                  ...questions[questionIndex].options.asMap().entries.map(
                    (option) {
                      int optionIndex = option.key;
                      String optionText = option.value;
                      bool isSelected = selectedOptions.contains(optionIndex);
                      bool isCorrect = questions[questionIndex]
                          .correctAnswerIndices
                          .contains(optionIndex);
                      return CheckboxListTile(
                        title: Text(optionText),
                        value: isSelected,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null && value) {
                              selectedOptions.add(optionIndex);
                            } else {
                              selectedOptions.remove(optionIndex);
                            }
                          });
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: checkAnswer,
                    child: Text('Submit'),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Time remaining: $countdown seconds',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Score: $score',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

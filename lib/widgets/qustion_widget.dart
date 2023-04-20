import 'dart:async';

import 'package:flutter/material.dart';

import '../models/question_model.dart';
import 'option_widget.dart';
import 'result_page.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({super.key});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late PageController _controller;
  int _questionNumber = 1;
  int _score = 0;
  bool _isLocked = false;
  Timer? timer;
  int start = 5;
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (start < 1) {
        } else {
          start--;
          if (start == 0) {
            if (_questionNumber < questions.length) {
              _controller.nextPage(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInExpo);
              setState(() {
                _questionNumber++;
                _isLocked = false;
              });
            } else {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultPage(score: _score)));
            }
            start = 5;
          }
        }
      });
    });
  }

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Temps : $start',
                  ),
                  Text('Question $_questionNumber/${questions.length}'),
                ],
              ),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Expanded(
                  child: PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: questions.length,
                controller: _controller,
                itemBuilder: (context, index) {
                  final _question = questions[index];
                  return buildQuestion(_question);
                },
              )),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }

  void nextPage() {
    if (_questionNumber < questions.length) {
      _controller.nextPage(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInExpo);
      setState(() {
        _questionNumber++;
        _isLocked = false;
        start = 5;
      });
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => ResultPage(score: _score)));
    }
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
        onPressed: () {
          if (_questionNumber < questions.length) {
            _controller.nextPage(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInExpo);
            setState(() {
              _questionNumber++;
              _isLocked = false;
            });
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultPage(score: _score)));
          }
        },
        child: Text(_questionNumber < questions.length
            ? 'Next Page'
            : "see the Result"));
  }

  Column buildQuestion(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          question.text,
          style: const TextStyle(fontSize: 25),
        ),
        Expanded(
            child: OptionWidget(
          question: question,
          onClickedOption: (option) {
            if (question.isLocked) {
              return;
            } else {
              setState(() {
                question.isLocked = true;
                question.selectedOption = option;
                nextPage();
              });
              _isLocked = question.isLocked;
              if (question.selectedOption!.isCorrect) {
                _score++;
                nextPage();
              }
            }
          },
        ))
      ],
    );
  }
}

import 'package:amir/Services/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../models/question_model.dart';

class QuestionForm extends StatefulWidget {
  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  List<Question> questions = [
    Question(
      text: '',
      options: [],
    )
  ];

  void addQuestion() {
    setState(() {
      questions.add(Question(
        text: '',
        options: [],
      ));
    });
  }

  void removeQuestion(int index) {
    setState(() {
      questions.removeAt(index);
    });
  }

  void addOption(int questionIndex) {
    setState(() {
      questions[questionIndex].options.add(Option(text: '', isCorrect: false));
    });
  }

  void removeOption(int questionIndex, int optionIndex) {
    setState(() {
      questions[questionIndex].options.removeAt(optionIndex);
    });
  }

  QuizController quizController = QuizController();
  TextEditingController nomQuizController = TextEditingController();
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question Form'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Map req = {
                'id_cour': '646e0e83695e6daec7a200be',
                'question': questions,
                "nom_quiz": nomQuizController.text
              };
              quizController.createQuiz(req);
            },
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nom du quiz',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: nomQuizController,
                    decoration: InputDecoration(labelText: 'Nom quiz'),
                  ),
                ]),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, questionIndex) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Question ${questionIndex + 1}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  removeQuestion(questionIndex);
                                },
                              ),
                            ],
                          ),
                          TextFormField(
                            initialValue: questions[questionIndex].text,
                            decoration: InputDecoration(labelText: 'Question'),
                            onChanged: (value) {
                              setState(() {
                                questions[questionIndex].text = value;
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: questions[questionIndex].options.length,
                            itemBuilder: (context, optionIndex) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: questions[questionIndex]
                                          .options[optionIndex]
                                          .text,
                                      decoration:
                                          InputDecoration(labelText: 'Option'),
                                      onChanged: (value) {
                                        setState(() {
                                          questions[questionIndex]
                                              .options[optionIndex]
                                              .text = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Checkbox(
                                    value: questions[questionIndex]
                                        .options[optionIndex]
                                        .isCorrect,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        questions[questionIndex]
                                            .options[optionIndex]
                                            .isCorrect = value!;
                                      });
                                    },
                                  ), //Chec
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      removeOption(questionIndex, optionIndex);
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                addOption(questionIndex);
                              },
                              child: Text('Add Option'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addQuestion();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}


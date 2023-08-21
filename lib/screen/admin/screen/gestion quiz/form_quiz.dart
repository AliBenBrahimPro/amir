import 'package:amir/Services/quiz_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Question {
  String text;
  List<String> options;
  List<int> correctAnswerIndices;
  List<bool> isCorrect;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndices,
    required this.isCorrect,
  });
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'options': options.map((option) => option).toList(),
      'correctAnswerIndices': correctAnswerIndices
          .map((correctAnswerIndice) => correctAnswerIndice)
          .toList(),
    };
  }
}

class QuizBuild extends StatefulWidget {
  String? idcours;
  QuizBuild({super.key, this.idcours});
  @override
  _QuizBuildState createState() => _QuizBuildState();
}

class _QuizBuildState extends State<QuizBuild> {
  List<Question> questions = [
    Question(text: '', options: [], correctAnswerIndices: [], isCorrect: [])
  ];
  List<bool> correct = [false];
  bool isCorrectAnswer = false;
  void addQuestion() {
    setState(() {
      questions.add(Question(
          text: '', options: [], correctAnswerIndices: [], isCorrect: []));
    });
  }

  void removeQuestion(int index) {
    setState(() {
      questions.removeAt(index);
    });
  }

  void addOption(int questionIndex) {
    setState(() {
      questions[questionIndex].options.add("");
      questions[questionIndex].isCorrect.add(false);
    });
  }

  void removeOption(int questionIndex, int optionIndex) {
    setState(() {
      questions[questionIndex].options.removeAt(optionIndex);

      questions[questionIndex].isCorrect.removeAt(optionIndex);
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
              for (var question in questions) {
                print(question.toJson());
              }

              Map req = {
                'id_cour': widget.idcours,
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
                                          .options[optionIndex],
                                      decoration:
                                          InputDecoration(labelText: 'Option'),
                                      onChanged: (value) {
                                        setState(() {
                                          questions[questionIndex]
                                              .options[optionIndex] = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Checkbox(
                                    value: questions[questionIndex]
                                        .isCorrect[optionIndex],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        questions[questionIndex]
                                            .isCorrect[optionIndex] = value!;
                                        questions[questionIndex]
                                                .isCorrect[optionIndex]
                                            ? questions[questionIndex]
                                                .correctAnswerIndices
                                                .add(optionIndex)
                                            : questions[questionIndex]
                                                .correctAnswerIndices
                                                .remove(optionIndex);
                                        questions[questionIndex]
                                            .correctAnswerIndices
                                            .sort();
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

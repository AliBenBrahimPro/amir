import 'package:amir/models/question_model.dart';
import 'package:amir/screen/admin/screen/gestion%20quiz/create_question.dart';
import 'package:flutter/material.dart';

import '../../../../Services/cours_service.dart';
import '../../../../Services/quiz_service.dart';
import '../../../../models/cours_model.dart';
import '../../../../shared/app_colors.dart';
import '../../../../shared/dimensions/dimensions.dart';
import '../../../../theme.dart';
import '../../../../widgets/buttons/action_button.dart';
import '../../../../widgets/inputs/input_field.dart';

class CreateQuiz extends StatefulWidget {
  const CreateQuiz({super.key});

  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  QuizController quizController = QuizController();
  CoursController coursController = CoursController();
  List<Question> questionList = [];
  var idCours;
  @override
  Widget build(BuildContext context) {
    print("----------------");
    return Scaffold(
        appBar: AppBar(
          backgroundColor: pink,
        ),
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        body: Form(
            key: _formkey,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  FutureBuilder<List<Cours>>(
                      future:
                          coursController.getAllCours(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child:
                                Text('somthing went wrong ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData) {
                          final cours = snapshot.data!;

                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: Constants.screenHeight * 0.001,
                                horizontal: Constants.screenWidth * 0.07),
                            child: DropdownButtonFormField<String?>(
                              validator: (value) {
                                if (value == null) {
                                  return 'le cours est oubligatoire';
                                }
                              },
                              hint: const Text("select cours"),
                              decoration: InputDecoration(
                                focusedErrorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                  ),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: pinkColor,
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                      width: 2.0, color: pinkColor),
                                ),
                              ),
                              value: idCours,
                              isDense: true,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: cours.map((map) {
                                return DropdownMenuItem(
                                  value: map.id.toString(),
                                  // value: _mySelection,
                                  child: Text(map.nameCour),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  idCours = newValue;
                                });
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  ActionButton(
                      label: "Suivant",
                      buttonColor: greenColor,
                      labelColor: Colors.white,
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          // Map quiz = {
                          //   "question": questionList,
                          //   "id_cour": "642aceb0a06fcb46ce018da2"
                          // };
                          // quizController.createQuiz(quiz);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateQuestion(
                                      idCours: idCours,
                                    )),
                          );
                        }
                      })
                ],
              ),
            )));
  }
}

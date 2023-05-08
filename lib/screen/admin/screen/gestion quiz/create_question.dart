import 'package:amir/models/question_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Services/cours_service.dart';
import '../../../../Services/quiz_service.dart';
import '../../../../models/cours_model.dart';
import '../../../../shared/app_colors.dart';
import '../../../../shared/dimensions/dimensions.dart';
import '../../../../theme.dart';
import '../../../../widgets/buttons/action_button.dart';
import '../../../../widgets/inputs/input_field.dart';

class CreateQuestion extends StatefulWidget {
  final String idCours;
  const CreateQuestion({super.key, required this.idCours});

  @override
  State<CreateQuestion> createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  final _formkey = GlobalKey<FormState>();
  var isChecked = false;
  TextEditingController questionController = TextEditingController();
  QuizController quizController = QuizController();
  CoursController coursController = CoursController();
  List<Question> questionList = [];
  List<TextEditingController> listController = [TextEditingController()];
  List<TextEditingController> listEtatController = [TextEditingController()];

  var idCours;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pink,
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InputField(
              controller: questionController,
              label: 'Questions',
              textInputType: TextInputType.text,
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            shrinkWrap: true,
            itemCount: listController.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InputField(
                        controller: listController[index],
                        label: 'Options',
                        textInputType: TextInputType.text,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InputField(
                        controller: listEtatController[index],
                        label: 'is correct',
                        textInputType: TextInputType.text,
                      ),
                    ),
                    Expanded(
                      child: Checkbox(
                        checkColor: Colors.white,
                       fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return pink.withOpacity(.32);
    }
    return pink;
  })
,
                        value: isChecked,
                        shape: CircleBorder(),
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    index != 0
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                listController[index].clear();
                                listController[index].dispose();
                                listController.removeAt(index);
                                listEtatController[index].clear();
                                listEtatController[index].dispose();
                                listEtatController.removeAt(index);
                              });
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Color(0xFF6B74D6),
                              size: 35,
                            ),
                          )
                        : const SizedBox()
                  ],
                ),
              );
            },
          ),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                listController.add(TextEditingController());
                listEtatController.add(TextEditingController());
              });
            },
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    color: const Color(0xFF444C60),
                    borderRadius: BorderRadius.circular(10)),
                child: Text("Ajouter autre options",
                    style: GoogleFonts.nunito(color: const Color(0xFFF8F8FF))),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: [
              Expanded(
                child: ActionButton(
                    label: "save",
                    buttonColor: Colors.green,
                    labelColor: Colors.white,
                    onPressed: () {}),
              ),
              Expanded(
                child: ActionButton(
                    label: "Ajouter autre Question",
                    buttonColor: Colors.green,
                    labelColor: Colors.white,
                    onPressed: () {
                      List test = [];
                      List test2 = [];
                      List test3 = [];

                      List.generate(
                          listController.length,
                          (i) => test.add(
                                {
                                  "text": listController[i].text,
                                  "isCorrect": listEtatController[i].text
                                },
                              ));

                      Map creeds = {
                        "question": questionController.text,
                        "option": test
                      };
                      setState(() {
                        test2.add(creeds);
                        print(test2);
                        test.clear();
                        listController.clear();
                        listEtatController.clear();
                        listController.map((e) => e.dispose());
                        listEtatController.map((e) => e.dispose());
                        listController.map((e) => e.clear());
                        listEtatController.map((e) => e.clear());
                        questionController.text = "";
                        listController.add(TextEditingController());
                        listEtatController.add(TextEditingController());
                      });
                    }),
              ),
            ],
          )
        ],
      )),
    );
  }
}

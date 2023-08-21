import 'package:amir/models/cours_model.dart';
import 'package:flutter/material.dart';

import '../../../../Services/cours_service.dart';
import '../../../../shared/app_colors.dart';
import '../../../../shared/dimensions/dimensions.dart';
import '../../../../widgets/buttons/action_button.dart';
import 'form_quiz.dart';

class SelectCours extends StatefulWidget {
  const SelectCours({super.key});

  @override
  State<SelectCours> createState() => _SelectCoursState();
}

class _SelectCoursState extends State<SelectCours> {
  CoursController coursController = CoursController();
  @override
  void initState() {
    super.initState();
    getData();
  }

  List<Cours> cours = [];
  bool isLoaded = true;
  getData() async {
    cours = await coursController.getAllCours();
    setState(() {
      isLoaded = false;
    });
  }

  String? idCours;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: isLoaded
            ? CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Constants.screenHeight * 0.001,
                            horizontal: Constants.screenWidth * 0.07),
                        child: Text(
                          "Selectionner cours",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Constants.screenHeight * 0.001,
                            horizontal: Constants.screenWidth * 0.07),
                        child: DropdownButtonFormField<String?>(
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
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  ElevatedButton(
                      onPressed: idCours == null ? null : () {
                        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  QuizBuild(idcours:idCours ,)),
  );
                      },
                      child: Text('Suivant'))
                ],
              ),
      ),
    );
  }
}

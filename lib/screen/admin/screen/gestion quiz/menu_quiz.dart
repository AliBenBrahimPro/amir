import 'package:amir/models/quiz_model.dart';
import 'package:amir/screen/admin/screen/gestion%20quiz/read_quiz.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../Services/multiple_quiz_service.dart';
import '../../../../Services/quiz_service.dart';
import '../../../../models/multiple_quiz_model.dart';
import '../../../../widgets/feature_item.dart';
import '../../../../widgets/quiz_item.dart';

class MenuQuiz extends StatefulWidget {
  const MenuQuiz({super.key});

  @override
  State<MenuQuiz> createState() => _MenuQuizState();
}

class _MenuQuizState extends State<MenuQuiz> {
  List<MultipQuizModel> quiz = [];
  bool isLoaded = true;
  MultipleController quizController = MultipleController();
  getData() async {
    quiz = await quizController.getAllQuiz();
    setState(() {
      isLoaded = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          :ListView(children:  List.generate(
        quiz.length, (index) => QuizItem(onTap: () {
           Navigator.push(
    context,
    MaterialPageRoute(builder: (context) =>  QuizScreen(idquiz:quiz[index].id ,)),
  );
        }, data: quiz[index]))),
    );
  }
}

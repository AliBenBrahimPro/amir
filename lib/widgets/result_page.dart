import 'package:amir/models/question_model.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key,required this.score});
  final int score;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('You got $score')),);
  }
}

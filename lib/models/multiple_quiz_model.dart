    import 'dart:convert';

List<Question> questionFromJson(dynamic str) =>
    List<Question>.from((str).map((x) => Question.fromJson(x)));


MultipQuizModel mapFromJson(String str) => MultipQuizModel.fromJson(
  jsonDecode(str)
  );


class Question {
  String text;
  List<dynamic> options;
  List<dynamic> correctAnswerIndices;

  Question({
    required this.text,
    required this.options,
    required this.correctAnswerIndices,
  });

      factory Question.fromJson(Map<String, dynamic> json) => Question(
        text:json["text"] ,
        options:json["options"] ,
        correctAnswerIndices: json["correctAnswerIndices"],
        
        
       
    );
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
////////////////////////////
///
List<MultipQuizModel> multipQuizFromJson(dynamic str) =>
    List<MultipQuizModel>.from((str).map((x) => MultipQuizModel.fromJson(x)));
class MultipQuizModel {
  String id;
  String quizName;
  List<Question> questions;
  String courseId;
  String createdAt;
  String updatedAt;
  int v;

  MultipQuizModel({
    required this.id,
    required this.quizName,
    required this.questions,
    required this.courseId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory MultipQuizModel.fromJson(Map<String, dynamic> json) {
    return MultipQuizModel(
      id: json['_id'],
      quizName: json['nom_quiz'],
      questions: List<Question>.from(json['question'].map((x) => Question.fromJson(x))),
      courseId: json['id_cour'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}



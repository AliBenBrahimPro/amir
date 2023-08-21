List<QuizModel> quizFromJson(dynamic str) =>
    List<QuizModel>.from((str).map((x) => QuizModel.fromJson(x)));
class QuizModel {
  String id;
  String quizName;
  List<QuestionModel> questions;
  String courseId;
  String createdAt;
  String updatedAt;
  int v;

  QuizModel({
    required this.id,
    required this.quizName,
    required this.questions,
    required this.courseId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['_id'],
      quizName: json['nom_quiz'],
      questions: List<QuestionModel>.from(json['question'].map((x) => QuestionModel.fromJson(x))),
      courseId: json['id_cour'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class QuestionModel {
  String text;
  List<OptionModel> options;
  bool isLocked;
  OptionModel? selectedOption;

  QuestionModel({
    required this.text,
    required this.options,
    required this.isLocked,
    this.selectedOption,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      text: json['text'],
      options: List<OptionModel>.from(json['options'].map((x) => OptionModel.fromJson(x))),
      isLocked: json['isLocked'],
      selectedOption: json['selectedOption'] != null ? OptionModel.fromJson(json['selectedOption']) : null,
    );
  }
}

class OptionModel {
  String text;
  bool isCorrect;

  OptionModel({
    required this.text,
    required this.isCorrect,
  });

  factory OptionModel.fromJson(Map<String, dynamic> json) {
    return OptionModel(
      text: json['text'],
      isCorrect: json['isCorrect'],
    );
  }
}

List<Quiz> quizFromJson(dynamic str) =>
    List<Quiz>.from((str).map((x) => Quiz.fromJson(x)));

class Quiz {
    String id;
    Question question;
    String idCour;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Quiz({
        required this.id,
        required this.question,
        required this.idCour,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        id: json["_id"],
        question: Question.fromJson(json["question"]),
        idCour: json["id_cour"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "question": question.toJson(),
        "id_cour": idCour,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class Question {
    String text;
    List<Option> option;

    Question({
        required this.text,
        required this.option,
    });

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        text: json["text"],
        option: List<Option>.from(json["option"].map((x) => Option.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "option": List<dynamic>.from(option.map((x) => x.toJson())),
    };
}

class Option {
    String text;
    bool isCorrect;

    Option({
        required this.text,
        required this.isCorrect,
    });

    factory Option.fromJson(Map<String, dynamic> json) => Option(
        text: json["text"],
        isCorrect: json["isCorrect"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "isCorrect": isCorrect,
    };
}

class Question {
  String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;
  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedOption,
  });
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'options': options.map((option) => option.toJson()).toList(),
      'isLocked': isLocked,
      'selectedOption': selectedOption?.toJson(),
    };
  }
}

class Option {
  String text;
  bool isCorrect;
  Option({required this.text, required this.isCorrect});
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isCorrect': isCorrect,
    };
  }
}

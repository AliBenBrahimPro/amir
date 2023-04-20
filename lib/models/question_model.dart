class Question {
  final String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;
  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedOption,
  });
}

class Option {
  final String text;
  final bool isCorrect;
  const Option({required this.text, required this.isCorrect});
}

final questions = [
  Question(text: 'what is actually electricity?', options: [
    const Option(text: 'A flow of water', isCorrect: false),
    const Option(text: 'A flow of air', isCorrect: false),
    const Option(text: 'A flow of electrons', isCorrect: true),
    const Option(text: 'A flow of atom', isCorrect: false),
]),
 Question(text: 'What is the scientific name of a butterfly?', options: [
    const Option(text: 'Apis', isCorrect: false),
    const Option(text: 'Coleoptera', isCorrect: false),
    const Option(text: 'Formicidae', isCorrect: false),
    const Option(text: 'Rhopalocera', isCorrect: true),
]),
 Question(text: 'How hot is the surface of the sun?', options: [
    const Option(text: '1,233 K', isCorrect: false),
    const Option(text: '5,778 K', isCorrect: true),
    const Option(text: '12,130 K', isCorrect: false),
    const Option(text: '101,300 K', isCorrect: false),
]),
 Question(text: 'What is the capital of Spain?', options: [
    const Option(text: 'Berlin', isCorrect: false),
    const Option(text: 'Buenos Aires', isCorrect: false),
    const Option(text: 'Madrid', isCorrect: true),
    const Option(text: 'San Juan', isCorrect: false),
]),
 Question(text: 'Who are the actors in The Internship?', options: [
    const Option(text: 'Ben Stiller, Jonah Hill', isCorrect: false),
    const Option(text: 'Courteney Cox, Matt LeBlanc', isCorrect: false),
    const Option(text: 'Kaley Cuoco, Jim Parsons', isCorrect: false),
    const Option(text: 'Vince Vaughn, Owen Wilson', isCorrect: true),
]),
 Question(text: 'What are the school colors of the University of Texas at Austin?', options: [
    const Option(text: 'Black, Red', isCorrect: false),
    const Option(text: 'Blue, Orange', isCorrect: false),
    const Option(text: 'White, Burnt Orange', isCorrect: true),
    const Option(text: 'White, Old gold, Gold', isCorrect: false),
]),
 Question(text: 'What is 70 degrees Fahrenheit in Celsius?', options: [
    const Option(text: '18.8889', isCorrect: false),
    const Option(text: '20', isCorrect: false),
    const Option(text: '21.1111', isCorrect: true),
    const Option(text: '158', isCorrect: false),
]),
 Question(text: 'When was Mahatma Gandhi born?', options: [
    const Option(text: 'October 2, 1869', isCorrect: true),
    const Option(text: 'December 15, 1872', isCorrect: false),
    const Option(text: 'uly 18, 1918', isCorrect: false),
    const Option(text: 'January 15, 1929', isCorrect: false),
]),
 Question(text: 'How far is the moon from Earth?', options: [
    const Option(text: '7,918 miles (12,742 km)', isCorrect: false),
    const Option(text: '86,881 miles (139,822 km)', isCorrect: false),
    const Option(text: '238,400 miles (384,400 km)', isCorrect: true),
    const Option(text: '35,980,000 miles (57,910,000 km)', isCorrect: false),
]),
 Question(text: 'How tall is Mount Everest?', options: [
    const Option(text: '6,683 ft (2,037 m)', isCorrect: false),
    const Option(text: '7,918 ft (2,413 m)', isCorrect: false),
    const Option(text: '19,341 ft (5,895 m)', isCorrect: false),
    const Option(text: '29,029 ft (8,847 m)', isCorrect: true),
]),

];

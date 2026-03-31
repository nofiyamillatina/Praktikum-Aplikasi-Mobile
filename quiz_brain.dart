// ignore_for_file: unused_field

import 'package:quiz/question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question(
      q: "Jika perut sudah bunyi karena lapar, kita bisa mengubahnya ke 'mode getar' agar tidak berisik",
      a: false,
    ),
    Question(
      q: "Alasan lari pagi sangat melelahkan adalah karena makan mie instan pakai nasi tadi malam",
      a: true,
    ),
    Question(q: "Darah warnanya neon", a: false),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }
}

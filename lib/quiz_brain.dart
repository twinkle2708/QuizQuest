import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('A for Apple', true),
    Question('T for Twinkle', true),
    Question('C for Dog', false),
    Question('I for Car', false),
    Question('B for Inkpot ', false),
    Question('W for Watch', true),
    Question('Z for Zebra', true)
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

  bool isFinished() {
    if (_questionNumber >= _questionBank.length - 1) {
      print('now returning true');
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}

import 'package:quebra_cabecas/games/adivinhe_palavra/domain/question_char.dart';

class Question {
  String question;
  String pathImage;
  String answer;
  String info;
  bool isDone = false;
  bool isFull = false;
  List<QuestionChar> puzzles = [];
  List<String>? arrayBtns = [];

  Question({
    required this.question,
    required this.pathImage,
    required this.answer,
    required this.info,
    this.arrayBtns,
  });

  void setQuestionChar(List<QuestionChar> puzzles) => this.puzzles = puzzles;

  void setIsDone() => isDone = true;
  
  bool fieldCompleteCorrect(){
    bool complete = puzzles.where((puzzle) => puzzle.currentValue == null).length == 0;
    if(!complete){
      //não completo ainda
      isFull = false;
      return complete;
    }
    //Se completo, confere se está certo
    isFull = true;

    String answeredString = puzzles.map((puzzle) => puzzle.currentValue).join("");
    //Se correto, retorna true;
    return answeredString == answer;
  }

  Question clone(){
    return Question(question: question,info: info, pathImage: pathImage, answer: answer);
  }
}

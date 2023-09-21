class QuestionChar {
  String? currentValue;
  int? currentIndex;
  String? correctValue;
  bool hintShow;

  QuestionChar({
    this.hintShow = false,
    this.correctValue,
    this.currentIndex,
    this.currentValue,
  });

  getCurrentValue(){
    if(currentValue != null) {
      return currentValue;
    } else if (hintShow) {
      return correctValue;
    }
  }

  void clearValue(){
    this.currentValue = null;
    this.currentIndex = null;
  }
}

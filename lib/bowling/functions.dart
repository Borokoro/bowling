class Functions{
  bool isSumGreaterThan10(int firstShot, int secondShot, int thirdShot){
    return firstShot + secondShot + thirdShot > 10;
  }
  bool isStrike(int Shot){
    return Shot == 10;
  }
  int countPoints(int firstShot, int secondShot, int thirdShot, bool isFirstStrike,bool amIStrike, int nextThrow, int secondNextThrow){
    return firstShot+secondShot+thirdShot;
  }
  bool isNumberGreaterThan1(int number){
    return number>1;
  }
  int sumPreviousShot(int value){
    return value;
  }
}
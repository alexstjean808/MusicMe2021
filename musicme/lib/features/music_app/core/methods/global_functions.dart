import 'dart:math';

dynamic getRandomFromList(List myList) {
  var myListLength = myList.length;
  var randomIndex = Random().nextInt(myListLength);
  var listItem = myList[randomIndex];
  return listItem;
}

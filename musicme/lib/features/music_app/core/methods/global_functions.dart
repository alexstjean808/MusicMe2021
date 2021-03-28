import 'dart:math';

import 'package:musicme/features/music_app/data/data_provider/dont_look_at_me.dart';

dynamic getRandomFromList(List myList) {
  if (myList.length == 0) return [];
  var myListLength = myList.length;
  var randomIndex = Random().nextInt(myListLength);
  var listItem = myList[randomIndex];
  return listItem;
}

//filters the list of genres from user input
String filterToQueryGenre(List userGenreInput) {
  if (userGenreInput.length == 0) {
    return "";
  }
  //picks one of the user input genres
  String randomUserGenre = getRandomFromList(userGenreInput);
  //picks a random micro genre from the genresFromArray
  String randomQueryGenre = getRandomFromList(genresFromArray[randomUserGenre]);

  return randomQueryGenre;
}

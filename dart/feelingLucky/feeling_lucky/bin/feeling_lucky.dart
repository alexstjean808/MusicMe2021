import 'dart:math';

void main() async {
  print(feelingLucky(testList));
}

var testList = ['one', 'two', 'three', 'four', 'five', 'six', 'seven'];

String feelingLucky(trackList) {
  var range = trackList.length;
  var randomNumber = Random().nextInt(range);

  var randomTrackId = trackList[randomNumber];
  return (randomTrackId);
}

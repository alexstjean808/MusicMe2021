import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';

void main() async {
  print(await feelingLucky());
}

Future<String> feelingLucky() async {
  var range = 15000;
  var randomNumber = Random().nextInt(range);

  //parameters are key for the firebase and a random number between 0 and the length of the database that we hardcoded
  //code taken mostly from https://curl.trillworks.com/#dart
  var params = {
    'orderBy': r'%22$key%22',
    'equalTo': '%22' + randomNumber.toString() + '%22',
  };
  var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

  var res = await http.get(
      'https://musicme-fd43b-default-rtdb.firebaseio.com/tracks.json?$query');
  if (res.statusCode != 200) {
    throw Exception('http.get error: statusCode= ${res.statusCode}');
  }
  //end code from curl.trillworks.com

  var returnJSON = convert.jsonDecode(res.body); //convert http response to JSON
  var trueSongNumber = returnJSON.keys.toList()[0];

  var randomSongId = returnJSON[trueSongNumber]['id'];

  return randomSongId;
}

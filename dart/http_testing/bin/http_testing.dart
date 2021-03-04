import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main(List<String> arguments) async {
  //the url will soon have to be a string where we insert what to order by and start / end limits which will come from the database

  // //READING PREFERENCES FROM THE USER PORTION OF THE DATABASE
  // var userUrl = 'https://musicme-fd43b-default-rtdb.firebaseio.com/users.json';
  // var response1 = await http.get(userUrl);
  // if (response1.statusCode == 200) {
  //   var jsonResponse1 = convert.jsonDecode(response1.body);
  //   var itemCount1 = jsonResponse1[
  //       'totalItems']; //ngl I didn't write this part, stolen straight from stackoverflow or somethin
  //   print('Reponse from http: $itemCount1.');
  // } else {
  //   print('Request failed with status: ${response1.statusCode}');
  // }
  // var returnJSON1 =
  //     convert.jsonDecode(response1.body); //convert http response to JSON
  // var userKeysList = returnJSON1.keys
  //     .toList(); //this should stay 1 while we only have one user... we are going to have to change the logic to account for more users later on
  // var userKeysHappy = returnJSON1[userKeysList[0]]['happy'].keys;
  // var userKeysSad = returnJSON1[userKeysList[0]]['sad'].keys;
  // var userKeysAngry = returnJSON1[userKeysList[0]]['angry'].keys;
  // var userKeysHappyList = userKeysHappy.toList();
  // var userKeysSadList = userKeysSad.toList();
  // var userKeysAngryList = userKeysAngry.toList();

  // print('This is the user JSON: $returnJSON1');
  // print('happy: $userKeysHappy, sad: $userKeysSad, angry: $userKeysAngry');
  //GETTING TRACK INFORMATION FROM THE DATABASE AFTER FIGURING OUT USER PREFERENCES
  var tracksUrl =
      'https://musicme-fd43b-default-rtdb.firebaseio.com/tracks.json?orderBy=%22energy%22&startAt=0.2&endAt=0.5&limitToLast=10&print=pretty';
  var response = await http.get(tracksUrl);
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    var itemCount = jsonResponse[
        'totalItems']; //ngl I didn't write this part, stolen straight from stackoverflow or somethin
    print('Reponse from http: $itemCount.');
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
  var returnJSON =
      convert.jsonDecode(response.body); //convert http response to JSON
  var songKeyList = returnJSON.keys.toList();
  var firstTrackKey = songKeyList[0];
  var firstTrackID = returnJSON[firstTrackKey]['id'];
  print(
      'Response body: ${firstTrackID}'); //retrieve known id from known id in database... obv we'll need to make this work a different way
  //storage: returnJSON['17291']['id'], returnJSON.keys (returns keys), returnJSON.keys.toList()[0] (converts keys to a list and allows you to access integer indeces)

  List filterTrackAttributes(
      double lowRange, double highRange, String trackAttb) {
    //allows you to filter tracks based on a JSON key in the song... must be one of the attributes that is in doubles
    // ignore: omit_local_variable_types
    List suitableTracks = [];
    var startIndex = 0;
    for (var i = startIndex; i < songKeyList.length; i++) {
      var currentSongKey = songKeyList[
          i]; //currentSongKey is the highest identifier of a song from the database
      var currentSong =
          returnJSON['${currentSongKey}']; //JSON object of one song in the loop
      var currentSpotifyID = currentSong['id']; //spotify ID
      var currentAttribute =
          currentSong[trackAttb]; //danceability, energy, etc.
      var cont = (currentAttribute >= lowRange) &&
          (currentAttribute <=
              highRange); //returns true when the track attribute fits in the range
      if (cont) {
        suitableTracks.add(currentSpotifyID);
      }
    }
    return suitableTracks;
  }

  // String getSong(String mood) { //this will eventually be used to get a songID from a mood
  //   //mood is happy, sad or angry
  //   var userKeysMoodList = returnJSON1[userKeysList[0]][mood].keys.toList();

  //   return songID;
  // }

  // ignore: omit_local_variable_types
  List playOneOfThese = filterTrackAttributes(.1, .9, 'danceability');
  print('List of songs that are suited: $playOneOfThese');
}

import 'dart:convert';
import 'dart:io';
import 'dart:web_audio';
import 'package:http/http.dart' as http;
import 'moodDataProvider.dart';
import 'sampleEntityIbmData.dart';
import 'dart:async';
import 'dart:math';

/* trackDataProvider.dart
Request track from Firebase
Input void
Output track_ID
*/

class TrackDataProvider extends MoodDataProvider {
  Future<IbmData> readData() async {
    //need to authenticate this from Firebase
    var uname = '';
    var pword = '';
    var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));
    var sentence = 'I hate the world I hate you';
    var params = {
      'version': '2017-09-21',
      'text': sentence,
    };

    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');
    print(query);
    var response = await http.get(
      'https://api.us-south.tone-analyzer.watson.cloud.ibm.com/instances/a8625766-fb0f-46f1-baa3-4cca671d6961/v3/tone?$query?sentences=true',
      headers: {'Authorization': authn},
    );

    var ibmData;
    if (response.statusCode == 200) {
      var ibmDataInJson = json.decode(response.body);
      ibmData = IbmData.fromJson(ibmDataInJson);
      print('Sucessfully got data from Ibm');
    } else {
      print(response.statusCode);
      assert(response.statusCode == 200);
    }
    return ibmData;
  }
}

// returns a random emotion
String getRandomMood() {
  var moods = ['joy', 'anger', 'sad'];
  return moods[Random().nextInt(3)];
}

Future<void> main() async {
  //random number between 0-2
  var random = Random();
  // ignore: unused_local_variable
  var randomNumber = random.nextInt(3);
  // ignore: unused_local_variable
  var songKey, major, danceability, energy, acousticness;
  var mood = 'joy';
//if we get a mood from IBM, then print the mood
  switch (mood) {
    case 'joy':
      {
        songKey = {'C', 'D', 'A', 'BB'};
        major = 1;
        danceability = [0.5, 1];
        energy = [0.6, 1];
      }
      break;

    case 'sad':
      {
        songKey = {'C', 'C#', 'DB', 'D', 'D#', 'F', 'F#', 'BB', 'B'};
        major = 0;
        danceability = [0, 0.4];
        energy = [0, 0.6];
      }
      break;

    case 'anger':
      {
        songKey = {'C#', 'D', 'D#', 'EB', 'E', 'F', 'F#', 'G', 'AB', 'B'};
        major = {0, 1};
        acousticness = [0, 0.6];
        energy = [0.6, 1];
      }
      break;

    //else, give it a random mood
    default:
      {
        getRandomMood(); // define above, just gets a random emotion.
      }
      break;
  }
}

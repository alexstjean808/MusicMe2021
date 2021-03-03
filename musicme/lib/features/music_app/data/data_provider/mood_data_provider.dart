import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:musicme/features/music_app/data/entities/ibm_data.dart';

/* moodDataProvider.dart
This is code to talk to IBM's API.
You input a sentence into the DataProvider and it outputs an IBMData object
which is a map of values and can be furthered simplified later.
Returns the main mood from each sentence
*/

class MoodDataProvider {
  Future<IbmData> readData(String sentence) async {
    var uname = 'apikey';
    var pword = 'cceOakkS6lzRHF4ukgmV0zuQn_eQZrgEPr_mwPnTJMWH';
    var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

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
      print(response.body);
      ibmData = IbmData.fromJson(ibmDataInJson);
      print('Sucessfully got data from IBM');
    } else {
      print(response.statusCode);
      assert(response.statusCode == 200);
    }
    return ibmData;
  }
}
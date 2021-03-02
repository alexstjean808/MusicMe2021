import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'sampleEntityIbmData.dart';
import 'dart:async';

/* trackDataProvider.dart
Request track from Firebase
Input void
Output track_ID
*/

class DataProvider {
  Future<IbmData> readData() async {
    //need to authenticate this from Firebase
    var uname = '';
    var pword = '';
    //var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

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

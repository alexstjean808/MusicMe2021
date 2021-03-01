import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'sampleEntityIbmData.dart';
import 'dart:async';

// this is code to talk to ibm's api
// TODO: make it so the sentence gets passees into the URL variable.

class DataProvider {
  Future<IbmData> readData() async {
    var map = new Map<String, String>();
    map['apikey'] = 'cceOakkS6lzRHF4ukgmV0zuQn_eQZrgEPr_mwPnTJMWH';

    var sentence =
        'I%20know%20that%20times%20are%20tough'; // this is the sentence with spaces converted to %
    // TODO: make it general so any sentance inputted is converted to that format and can query the IBM thing.

    var url =
        'https://api.us-south.tone-analyzer.watson.cloud.ibm.com/instances/a8625766-fb0f-46f1-baa3-4cca671d6961/v3/tone?version=2017-09-21&text=Team%2C%20I%20know%20that%20times%20are%20tough%21%20Product%20sales%20have%20been%20disappointing%20for%20the%20past%20three%20quarters.%20We%20have%20a%20competitive%20product%2C%20but%20we%20need%20to%20do%20a%20better%20job%20of%20selling%20it%21?sentences=true';
    var response = await http.get(url, headers: {
      'apikey': 'cceOakkS6lzRHF4ukgmV0zuQn_eQZrgEPr_mwPnTJMWH'
    }); // TODO: figure out how to properly send API key for authentication
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

// trying to use it and print the result from the query
void main() {
  var ibmData = DataProvider();

  var data = ibmData.readData();

  print(data);
}

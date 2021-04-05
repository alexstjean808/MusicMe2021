// this interacts with the input log and stores all the text entries
// from the user.
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicme/features/music_app/data/entities/user.dart';

class InputLogProvider {
  // INPUt: nothing
  // contents: reads the data from the log from input_log.json
  // OUTPUT: returns a Inputlog object model from input_log.dart
  // // DEPRICATED:
  /*Future<List> readLogData(User user) async {
    print('he users email is ${user.email}');
    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/inputLog/${user.email}.json');
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    var jsonObject = JsonDecoder().convert(res.body);
    print(res.body);
    var logList = jsonObject["inputs"];
    return (logList);
  }*/

  //INPUT: text the user entered
  //CONTNENTS: updates the data to the input_log.json list
  // OUTPUTS: returns nothing.
  updateLogData(String logInput, User user) async {
    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/inputLog/${user.email}.json');
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    // we will get the string response null. 'null'
    //
    var jsonObject;
    Map logMap = {"inputs": []};
    if (res.body == 'null') {
      // create new loglist with the first value
      logMap["inputs"].add(logInput);
      jsonObject = logMap;
    } else {
      // if it exists then decode it
      jsonObject = JsonDecoder().convert(res.body);
      jsonObject['inputs'] ??= [];
      jsonObject['inputs'].add(logInput);
      // writing the appended file.
    }
    var jsonString = JsonEncoder().convert(jsonObject);
    res = await http.put(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/inputLog/${user.email}.json',
        body: jsonString);
  }
}

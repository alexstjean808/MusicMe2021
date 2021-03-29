// this interacts with the input log and stores all the text entries
// from the user.
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InputLogProvider {
  // INPUt: nothing
  // contents: reads the data from the log from input_log.json
  // OUTPUT: returns a Inputlog object model from input_log.dart
  Future<List> readLogData([String user = 'musicme']) async {
    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/inputLog/${user}.json');
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    var jsonObject = JsonDecoder().convert(res.body);
    print(res.body);
    var logList = jsonObject["inputs"];
    return (logList);
  }

  //INPUT: text the user entered
  //CONTNENTS: updates the data to the input_log.json list
  // OUTPUTS: returns nothing.
  updateLogData(String logInput, [var user = 'musicme']) async {
    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/inputLog/${user}.json');
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    print(res.body);
    var jsonObject = JsonDecoder().convert(res.body);
    // adding the genre to the existing list of genres in track_query_params.json
    // it only adds the genre if it doesnt exist already in the array.

    if (!(jsonObject['inputs'].contains(logInput))) {
      jsonObject['inputs'].add(logInput);
      // writing the appended file.
      var jsonString = JsonEncoder().convert(jsonObject);

      res = await http.put(
          'https://musicme-fd43b-default-rtdb.firebaseio.com/inputLog/${user}.json',
          body: jsonString);
    }
  }
}

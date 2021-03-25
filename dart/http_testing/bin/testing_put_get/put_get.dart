import 'dart:convert';
import 'dart:io';

void main() async {
  // wow this works. I am so happy!
  var filePath = 'bin/testing_put_get/sample.json';

  print('Put_get is working');
  print(Directory.current);
  var input = await File(filePath).readAsString();
  var jsonFile = JsonDecoder().convert(input);
  // this outputs the json as a hashmap
  print(jsonFile);
  // WOW HOLY THIS WORKS! I CANT BELIEVE IT THIS IS SWEET.
  /*var dataToWrite = {'data': 'Wow I can write data to a file'};
  var jsonFileOutPut = JsonEncoder().convert(dataToWrite);

  var output = await File(filePath).writeAsString(jsonFileOutPut);

  print(output);*/
  // now lets try to write to the file!
}

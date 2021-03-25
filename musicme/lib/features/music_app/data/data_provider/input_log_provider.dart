// this interacts with the input log and stores all the text entries
// from the user.
import 'dart:async';

import 'package:musicme/features/music_app/data/entities/input_log.dart';

class InputLogProvider {
  //INPUT: text the user entered
  //CONTNENTS: updates the data to the input_log.json list
  // OUTPUTS: returns nothing.
  updateLogData(String textToLog) async {
    //TODO: impliment contents
  }
  // INPUt: nothing
  // contents: reads the data from the log from input_log.json
  // OUTPUT: returns a Inputlog object model from input_log.dart
  Future<InputLog> readLogData() async {
    //TODO: impliment contents
  }
}

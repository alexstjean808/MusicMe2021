import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/data/data_provider/input_log_provider.dart';

void main() {
  // Tests the readLogData() method of InputLogProvider class to read inputs from database
  test('Input Log data correctly read from database', () async {
    // ARRANGE
    var inputLogProvider = InputLogProvider();
    //ACT
    List inputLogList = await inputLogProvider.readLogData();
    //ASSERT
    expect(inputLogList[0], "test1");
  });

  // Tests the updateLogData method to the InputLogProvider class
  test('Update Log data correctly updates database', () async {
    // ARRANGE
    var inputLogProvider = InputLogProvider();
    //ACT
    await inputLogProvider.updateLogData("I added this", "musicme");
    List inputLogList = await inputLogProvider.readLogData("musicme");
    //ASSERT
    expect(inputLogList[inputLogList.length - 1], "I added this");
  });
}

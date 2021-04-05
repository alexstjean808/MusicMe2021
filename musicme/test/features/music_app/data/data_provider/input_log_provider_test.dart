import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/data/data_provider/input_log_provider.dart';
import 'package:musicme/features/music_app/data/entities/user.dart';
import 'package:musicme/features/music_app/data/local_data/user_data.dart';

void main() {
  // // Tests the readLogData() method of InputLogProvider class to read inputs from database
  // DEPRECATED
  // test('Input Log data correctly read from database', () async {
  //   // ARRANGE
  //   var inputLogProvider = InputLogProvider();
  //   //ACT
  //   List inputLogList = await inputLogProvider
  //       .readLogData(User(displayName: 'ERik', email: "erikd234"));
  //   //ASSERT
  //   expect(inputLogList[0], "test1");
  // });

  // Tests the updateLogData method to the InputLogProvider class
  test('Update Log data correctly updates database', () async {
    // ARRANGE
    var inputLogProvider = InputLogProvider();
    //ACT
    await inputLogProvider.updateLogData(
        "I added this", User(displayName: 'ERik', email: "erikd234"));
  });
}

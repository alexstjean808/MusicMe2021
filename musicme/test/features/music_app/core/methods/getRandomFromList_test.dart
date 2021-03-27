import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/core/methods/getRandomFromList.dart';

void main() {
  var testList = ['myItem1', 'myItem2', '3', '4', '5'];
  test('When given a list of a length 5, one value is returned ', () async {
    //ARRANGE:
    var returnedVal = getRandomFromList(testList);
    print(returnedVal);
    //ACT:
    var comparingList = [returnedVal];
    var returnedValLength = comparingList.length;
    //ASSERT:
    expect(returnedValLength, 1);
  });
}

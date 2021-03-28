import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/core/methods/global_functions.dart';
import 'package:musicme/features/music_app/data/data_provider/dont_look_at_me.dart';

void main() {
  test('When given a list of a length , one value is returned ', () async {
    //ARRANGE:
    var returnedVal = getRandomFromList(genresFromArray['Pop']);
    print(returnedVal);
    //ACT:
    var comparingList = [returnedVal];
    var returnedValLength = comparingList.length;
    //ASSERT:
    expect(returnedValLength, 1);
  });
}

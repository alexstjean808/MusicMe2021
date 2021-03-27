import 'package:flutter_test/flutter_test.dart';
import 'package:musicme/features/music_app/data/data_provider/query_params_provider.dart';

void main() {
// These tests below
  test('when testMethod is called then it return 1', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    // ACT
    var output = testQueryParam.testMethod();
    // ASSERT
    expect(output, 1);
  });
  test('when testMethod is called then it return 1', () async {
    // ARRANGE
    var testQueryParam = QueryParamsProvider();
    // ACT
    var output = testQueryParam.testMethod();
    // ASSERT
    expect(output, 0); // this will fail in this case
  });
}

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('User correcxtly will remove special characters from an email.',
      () async {
    String email = "sajida.chowdhury.edmonds@gmail.com";
    String output = email
        .substring(0, email.indexOf('@'))
        .replaceAll(new RegExp(r'[^\w\s]+'), '_');
    expect(output, "sajida_chowdhury_edmonds");
  });
  test('User correcxtly will remove non letter characters from an email.',
      () async {
    String email =
        "sajida.chowdhury-------?/';:|}]{[+=_-~#*()edmonds@gmail.com";
    String output = email
        .substring(0, email.indexOf('@'))
        .replaceAll(new RegExp(r'[^\w\s]+'), '_');
    expect(output, "sajida_chowdhury________________________edmonds");
  });
}

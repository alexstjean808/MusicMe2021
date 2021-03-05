// ignore: always_declare_return_types
main() {
  var params = {
    'version': '2017-09-21',
    'text': 'This is a test',
  };
  var query = params.entries.map((p) {
    print('key is : ${p.key}');
    print('value is : ${p.value}');
    '${p.key}=${p.value}';
  }).join('&');

  print(query);
}

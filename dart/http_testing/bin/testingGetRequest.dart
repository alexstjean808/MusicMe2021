import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  // this is from curl.trillworks.com translator. They do everything for us
  // they convert Curl commands to a list of different languages.
  var uname = 'apikey';
  var pword = 'cceOakkS6lzRHF4ukgmV0zuQn_eQZrgEPr_mwPnTJMWH';
  var authn = 'Basic ' + base64Encode(utf8.encode('$uname:$pword'));

  var params = {
    'version': '2017-09-21',
    'text':
        'Team, I know that times are tough! Product sales have been disappointing for the past three quarters. We have a competitive product, but we need to do a better job of selling it!?sentences=true',
  };
  var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

  var res = await http.get(
      'https://api.us-south.tone-analyzer.watson.cloud.ibm.com/instances/a8625766-fb0f-46f1-baa3-4cca671d6961/v3/tone?$query',
      headers: {'Authorization': authn});
  if (res.statusCode != 200)
    throw Exception('http.get error: statusCode= ${res.statusCode}');
  print(res.body);
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicme/features/music_app/data/entities/user.dart';

Future<User> getUserEmail(String authToken) async {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $authToken',
  };
  var res = await http.get('https://api.spotify.com/v1/me', headers: headers);
  if (res.statusCode != 200)
    throw Exception('http.get error: statusCode= ${res.statusCode}');
  print(res.body);

  Map userMap = JsonDecoder().convert(res.body);

  // converting user to a user dart object
  User user = User.fromJson(userMap);

  return user;
}

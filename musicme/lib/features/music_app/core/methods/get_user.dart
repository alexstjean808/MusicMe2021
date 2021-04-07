import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:musicme/features/music_app/data/entities/user.dart';
import 'package:musicme/features/music_app/data/local_data/user_data.dart';

// flow -. get user data after we have an auth token, check if user exitst,
Future<User> getUserData(String authToken) async {
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

//  checks to see if a new user exists already
//  and returns the user object, and sets the global variable.
Future<User> userValidation(User user) async {
  // tests to see if data already exists for the user.
  var res = await http.get(
      'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/${user.email}.json');
  if (res.statusCode != 200) {
    throw Exception('http.get error: statusCode= ${res.statusCode}');
  }

  if (res.body == 'null') {
    await initializeNewUser(user);
  } else {
    print("User exists.");
  }

  userGLOBAL = user;
  return user;
}

initializeNewUser(User user) async {
  User newUser = user;
  // set the
  var initialQueryMap = {
    "track_mood_ranges": {
      "anger_params": {
        "acousticness": [0, 0.6],
        "danceability": [0],
        "energy": [0.6, 1],
        "major": 1
      },
      "joy_params": {
        "acousticness": [0],
        "danceability": [0.5, 1],
        "energy": [0.6, 1],
        "major": 1
      },
      "sadness_params": {
        "acousticness": [0],
        "danceability": [0, 0.4],
        "energy": [0, 0.6],
        "major": 1
      }
    }
  };

  var jsonString = JsonEncoder().convert(initialQueryMap);

  var res = await http.put(
      'https://musicme-fd43b-default-rtdb.firebaseio.com/queryParams/${newUser.email}.json',
      body: jsonString);
  print("put response is $res");
  print('newUser email: ${newUser.email}');
}

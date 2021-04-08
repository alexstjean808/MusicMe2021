import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:musicme/features/music_app/core/methods/get_user.dart';
import 'package:musicme/features/music_app/data/entities/spotify_image.dart';
import 'package:musicme/features/music_app/data/entities/user.dart';
import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:http/http.dart' as http;
// CARE GLOBAL VARIABLE STORED AUTH TOKEN
import '../../data/local_data/auth_token.dart';

Future<User> connectToSpotify() async {
  var redirectUrl =
      "https://erikdahl.ca/spotifycallback"; // for launcing on mobile use "spotify-ios-quick-start://spotify-login-callback"
  // for launching on the WEB use "https://erikdahl.ca/spotifycallback"
  var authenticationToken;
  try {
    authenticationToken = await SpotifySdk.getAuthenticationToken(
        clientId: "47a74f6401d343debec2c0f6634e0aeb",
        redirectUrl: redirectUrl,
        scope: 'user-read-email, '
            'user-read-private, ');
    print(authenticationToken);

    await SpotifySdk.connectToSpotifyRemote(
        clientId: '47a74f6401d343debec2c0f6634e0aeb',
        redirectUrl: redirectUrl,
        accessToken: authenticationToken);
    print("connected");
  } on PlatformException catch (e) {
    print(e.message);
  } on MissingPluginException {
    print("not implemented");
  }
  authTokenGLOBAL = authenticationToken; // storing global variable for use
  User user = await getUserData(authenticationToken);
  User userOut = await userValidation(user);
  return userOut;
}

// function that returns an image url for a song the authentication token must be activated before this function will work.
// All liked songs should have a image already.
Future<SongImage> getSongImageUrl(String trackId) async {
  try {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authTokenGLOBAL',
    };

    var res = await http.get('https://api.spotify.com/v1/tracks/${trackId}',
        headers: headers);
    if (res.statusCode != 200)
      throw Exception('http.get error: statusCode= ${res.statusCode}');

    var jsonMap = JsonDecoder().convert(res.body);

    SongImages songImages = SongImages.fromJson(jsonMap['album']);

    return songImages.images[0]; // return the first image.
  } catch (e) {
    // if theres an error then print the error and display the bearded man image.
    print('Failed to get the song image: $e');
    return SongImage('initial');
  }
}

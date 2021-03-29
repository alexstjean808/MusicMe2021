import 'package:flutter/services.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

Future<void> connectToSpotify() async {
  try {
    var authenticationToken = await SpotifySdk.getAuthenticationToken(
        clientId: "47a74f6401d343debec2c0f6634e0aeb",
        redirectUrl: "https://erikdahl.ca/spotifycallback");
    print(authenticationToken);

    await SpotifySdk.connectToSpotifyRemote(
        clientId: '47a74f6401d343debec2c0f6634e0aeb',
        redirectUrl: 'https://erikdahl.ca/spotifycallback',
        accessToken: authenticationToken);
    print("connected");
  } on PlatformException catch (e) {
    print(e.message);
  } on MissingPluginException {
    print("not implemented");
  }
  //SpotifySdk.pause();
}

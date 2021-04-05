import 'package:flutter/services.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

Future<void> connectToSpotify() async {
  var redirectUrl =
      "https://erikdahl.ca/spotifycallback"; // for launcing on mobile use "spotify-ios-quick-start://spotify-login-callback"
  // for launching on the WEB use "https://erikdahl.ca/spotifycallback"
  try {
    var authenticationToken = await SpotifySdk.getAuthenticationToken(
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
  SpotifySdk.pause();
}

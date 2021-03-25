import 'package:flutter/services.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

Future<void> connectToSpotify() async {
  try {
    await SpotifySdk.connectToSpotifyRemote(
      clientId: '47a74f6401d343debec2c0f6634e0aeb',
      redirectUrl: 'http://localhost:63389',
    );
    print("connected");
  } on PlatformException catch (e) {
    print(e.message);
  } on MissingPluginException {
    print("not implemented");
  }
  SpotifySdk.pause();
}

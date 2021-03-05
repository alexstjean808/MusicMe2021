import 'package:spotify_sdk/models/track.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

Future<Track> getPlayerState() async {
  var playerState = await SpotifySdk.getPlayerState();
  print(
      "The current track from getPlayerState() is : ${playerState.track.name}");

  print('  ');
  print('-----------------------------------------------');
  print('  ');
  return playerState.track;
}

import 'package:spotify_sdk/spotify_sdk.dart';

Future<void> getSongImage() async {
  var playerState = await SpotifySdk.getPlayerState();
  print('seeing what the image URI thingy does');
  print(SpotifySdk.getImage(imageUri: playerState.track.imageUri));
}

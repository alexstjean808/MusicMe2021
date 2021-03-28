// this may become obsolete if the track_mood_ranges will do the same thing

class TrackData {
  final trackId;
  String name;
  String artist;
  // not final because this is initialized later when player is active and changes

  TrackData({this.trackId});
}

// this may become obsolete if the track_mood_ranges will do the same thing

class TrackData {
  final trackId;
  String name;
  String artist;
  // not final because this is initialized later when player is active and changes

  TrackData({this.trackId});
}

class TrackQueryParams {
  String mood;
  int major;
  List<double> danceability; // low is 0 high is 1, just like binary.
  List<double> energy;
  List<double> acousticness;
}

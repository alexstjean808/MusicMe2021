class Track {
  final trackId;

  Track({this.trackId});
}

class TrackQueryParams {
  String mood;
  int major;
  List<double> danceability; // low is 0 high is 1, just like binary.
  List<double> energy;
  List<double> acousticness;
}

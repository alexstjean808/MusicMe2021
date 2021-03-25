// a model for Track mood ranges this information will eventually
// come from track_mood_ranges.json

class TrackMoodRanges {
  final Params joyParams;
  final Params sadnessParams;
  final Params angerParams;

  TrackMoodRanges({this.joyParams, this.sadnessParams, this.angerParams});
}

class Params {
  final bool major;
  final List<int> danceability; // does not exist for anger
  final List<int> energy;
  final List<int> acousticness; // only exists anger

  Params({this.major, this.danceability, this.energy, this.acousticness});
}

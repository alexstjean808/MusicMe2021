// a model for Track mood ranges this information will eventually
// come from track_query_params.json

// this may need to be gotten rid of later we will see. -Erik
class TrackQueryParams {
  String mood;
  final TrackMoodRanges trackMoodRanges;
  final List<String> genres;

  TrackQueryParams(this.trackMoodRanges, this.genres);
  TrackQueryParams.fromJson(Map<String, dynamic> json)
      : trackMoodRanges = TrackMoodRanges.fromJson(json['track_mood_ranges']),
        genres = json["genres"];
}

class TrackMoodRanges {
  final Params joyParams;
  final Params sadnessParams;
  final Params angerParams;

  TrackMoodRanges({this.joyParams, this.sadnessParams, this.angerParams});
  TrackMoodRanges.fromJson(Map<String, dynamic> json)
      : joyParams = Params.fromJson(json['joy_params']),
        sadnessParams = Params.fromJson(json['sadness_params']),
        angerParams = Params.fromJson(json['anger_params']);
}

class Params {
  final bool major;
  final List<int> danceability; // does not exist for anger
  final List<int> energy;
  final List<int> acousticness; // only exists anger

  Params({this.major, this.danceability, this.energy, this.acousticness});
  Params.fromJson(Map<String, dynamic> json)
      : major = json['major'],
        danceability = json['danceability'],
        energy = json['energy'],
        acousticness = json['acousticness'];
}

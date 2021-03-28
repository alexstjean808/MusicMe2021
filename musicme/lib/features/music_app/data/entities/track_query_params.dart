// a model for Track mood ranges this information will eventually
// come from track_query_params.json

// this may need to be gotten rid of later we will see. -Erik
class TrackQueryParams {
  String mood;
  final TrackMoodRanges trackMoodRanges;
  final List genres;

  TrackQueryParams(this.trackMoodRanges, this.genres);
  TrackQueryParams.fromJson(Map<String, dynamic> json)
      : trackMoodRanges = TrackMoodRanges.fromJson(json['track_mood_ranges']),
        genres = json["genres"];
}

class TrackMoodRanges {
  final Ranges joyParams;
  final Ranges sadnessParams;
  final Ranges angerParams;

  TrackMoodRanges({this.joyParams, this.sadnessParams, this.angerParams});
  TrackMoodRanges.fromJson(Map<String, dynamic> json)
      : joyParams = Ranges.fromJson(json['joy_params']),
        sadnessParams = Ranges.fromJson(json['sadness_params']),
        angerParams = Ranges.fromJson(json['anger_params']);
}

class Ranges {
  final int major;
  final List danceability; // does not exist for anger
  final List energy;
  final List acousticness; // only exists anger

  Ranges({this.major, this.danceability, this.energy, this.acousticness});
  Ranges.fromJson(Map<String, dynamic> json)
      : major = json['major'],
        danceability = json['danceability'],
        energy = json['energy'],
        acousticness = json['acousticness'];
}

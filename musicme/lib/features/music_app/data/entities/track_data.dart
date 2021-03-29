// this may become obsolete if the track_mood_ranges will do the same thing

import 'package:flutter/cupertino.dart';

class TrackData {
  final String trackId;
  String name;
  String artist;
  final String mood;
  // not final because this is initialized later when player is active and changes

  TrackData({@required this.mood, this.trackId});
}

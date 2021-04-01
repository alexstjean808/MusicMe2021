// this may become obsolete if the track_mood_ranges will do the same thing

import 'package:flutter/cupertino.dart';

class LikedSongList {
  final List<TrackData> songs;

  LikedSongList({this.songs});
  factory LikedSongList.fromJson(Map<String, dynamic> json) {
    var dynamicList = json['likedTracks'] as List;

    // ignore: omit_local_variable_types
    List<TrackData> songs =
        dynamicList.map((i) => TrackData.fromJson(i)).toList();
    return LikedSongList(songs: songs);
  }
}

class TrackData {
  final String trackId;
  String name;
  String artist;
  final String mood;
  // not final because this is initialized later when player is active and changes

  TrackData({@required this.mood, this.trackId, this.name, this.artist});
  TrackData.fromJson(Map<String, dynamic> json)
      : trackId = json["id"] ??= [],
        mood = json["mood"] ??= [],
        name = json["name"] ??= [],
        artist = json["artist"] ??= [];
}

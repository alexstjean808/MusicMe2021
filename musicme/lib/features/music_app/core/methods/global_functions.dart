import 'dart:math';

import 'package:musicme/features/music_app/data/data_provider/dont_look_at_me.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';

dynamic getRandomFromList(List myList) {
  if (myList == null || myList.length == 0) return [];
  var myListLength = myList.length;
  var randomIndex = Random().nextInt(myListLength);
  var listItem = myList[randomIndex];
  return listItem;
}

//filters the list of genres from user input
String filterToQueryGenre(List userGenreInput) {
  if (userGenreInput.length == 0) {
    return "";
  }
  //picks one of the user input genres
  String randomUserGenre = getRandomFromList(userGenreInput);
  //picks a random micro genre from the genresFromArray
  String randomQueryGenre = getRandomFromList(genresFromArray[randomUserGenre]);

  return randomQueryGenre;
}

// converts the List of TrackData objects into a list of Map objects so that json_encoder() works
// to send the information to the database
List<Map> convertTrackDataToMapAndAdd(
    List<TrackData> trackList, TrackData addedTrack) {
  var listLength = trackList.length;
  Map trackMap = {};
  List<Map> trackMapList = [];
  TrackData track;
  List songIds = [];
  for (var i = 0; i < listLength; i++) {
    track = trackList[i];
    trackMap = {
      "id": track.trackId,
      "name": track.name,
      "artist": track.artist,
      "mood": track.mood
    };

    songIds.add(track.trackId);
    trackMapList.add(trackMap);
  }
  Map trackToAdd = {
    "id": addedTrack.trackId,
    "name": addedTrack.name,
    "artist": addedTrack.artist,
    "mood": addedTrack.mood
  };

  if (!(songIds.contains(trackToAdd["id"]))) {
    trackMapList.add(trackToAdd);
  }

  return trackMapList;
}

List<Map> convertTrackDataToMapRemove(
    List<TrackData> trackList, TrackData removedTrack) {
  var listLength = trackList.length;
  Map trackMap = {};
  List<Map> trackMapList = [];
  TrackData track;

  Map trackToRemove = {
    "id": removedTrack.trackId,
    "name": removedTrack.name,
    "artist": removedTrack.artist,
    "mood": removedTrack.mood
  };

  for (var i = 0; i < listLength; i++) {
    track = trackList[i];
    trackMap = {
      "id": track.trackId,
      "name": track.name,
      "artist": track.artist,
      "mood": track.mood
    };

    if (trackToRemove["id"] == track.trackId) {
      // wont add the track we want to remove.
      continue;
    }
    trackMapList.add(trackMap);
  }
  return trackMapList;
}

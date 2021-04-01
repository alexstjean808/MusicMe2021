import 'dart:async';
import 'dart:convert';

import 'package:musicme/features/music_app/core/methods/global_functions.dart';
import 'package:musicme/features/music_app/data/entities/track_data.dart';
import 'package:http/http.dart' as http;

class LikedSongsProvider {
  // When the user removes a song this method will be called to remove that song
  // to the local storage liked_songs.json
  // INPUT: the method takes in a likedSong from the user that they want to remove (see track_data.dart)
  // CONTENT: removes the songs from the List(or Touple) in the liked_songs.json
  // OUTPUT: nothing
  // The liked Song should always already be in the list of songs but we should have a check to make sure it is there.
  // this function will most likely call on the readData function to see what is already there.
  removeLikedSong(TrackData likedSong, String user) async {
    List<TrackData> likedTracksList = await readLikedTracks("musicme");
    // adding the genre to the existing list of genres in track_query_params.json
    // it only adds the genre if it doesnt exist already in the array.
    List<Map> likedMapList =
        convertTrackDataToMapRemove(likedTracksList, likedSong);
    // writing the appended file.
    var jsonString = JsonEncoder().convert(likedMapList);
    print(jsonString);
    await http.put(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/likedTracks/$user/likedTracks.json',
        body: jsonString);
  }

  // this method will read whatever songs have been liked by the user
  // in liked_songs.json.
  // INPUT: nothing
  // CONTENT: take info from liked_songs.json
  // OUTPUT: A list of TrackData objects to display on the User interface
  Future<List<TrackData>> readLikedTracks([String user = 'musicme']) async {
    String query = user;
    var res = await http.get(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/likedTracks/${query}.json');
    if (res.statusCode != 200) {
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    }
    print(res.body);
    var mapResponse = JsonDecoder().convert(res.body);
    mapResponse ??= {"likedTracks": []};
    // adding the genre to the existing list of genres in track_query_params.json
    // it only adds the genre if it doesnt exist already in the array.
    var likedTracksList = LikedSongList.fromJson(mapResponse);

    return likedTracksList.songs;
  }

  // When the user liked a song this method will be called to update that song
// to the local storage liked_songs.json
// INPUT: the method takes in a likedSong from the user (see track_data.dart)
// CONTENT: Adds the songs to the List(or Touple) in the liked_songs.json
// OUTPUT: nothing
// this function will most likely call on the readData function to see what is already there.
  addLikedSong(TrackData likedSong, [String user = 'musicme']) async {
    List<TrackData> likedTracksList = await readLikedTracks("musicme");
    // adding the genre to the existing list of genres in track_query_params.json
    // it only adds the genre if it doesnt exist already in the array.
    List<Map> likedMapList = convertTrackDataToMap(likedTracksList, likedSong);
    // writing the appended file.
    var jsonString = JsonEncoder().convert(likedMapList);
    print(jsonString);
    await http.put(
        'https://musicme-fd43b-default-rtdb.firebaseio.com/likedTracks/$user/likedTracks.json',
        body: jsonString);
  }
}

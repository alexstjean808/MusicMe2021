import 'dart:convert' as convert;
import 'dart:async';
import 'package:musicme/features/music_app/data/entities/track_data.dart';

class LikedSongsProvider {
  // When the user removes a song this method will be called to remove that song
  // to the local storage liked_songs.json
  // INPUT: the method takes in a likedSong from the user that they want to remove (see track_data.dart)
  // CONTENT: removes the songs from the List(or Touple) in the liked_songs.json
  // OUTPUT: nothing
  // The liked Song should always already be in the list of songs but we should have a check to make sure it is there.
  // this function will most likely call on the readData function to see what is already there.
  removeData(TrackData likedSong) async {
    //TODO impliment method!
    print('Hello Faith ');
    return "salmon";
  }

  // When the user liked a song this method will be called to update that song
  // to the local storage liked_songs.json
  // INPUT: the method takes in a likedSong from the user (see track_data.dart)
  // CONTENT: Adds the songs to the List(or Touple) in the liked_songs.json
  // OUTPUT: nothing
  // this function will most likely call on the readData function to see what is already there.
  addData(TrackData likedSong) async {
    //TODO impliment method!
  }

  test(String something) async {
    print("pls work");
  }

  // this method will read whatever songs have been liked by the user
  // in liked_songs.json.
  // INPUT: nothing
  // CONTENT: take info from liked_songs.json
  // OUTPUT: A list of TrackData objects to display on the User interface
  Future<List<TrackData>> readData() async {
    //TODO impliment method!
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicme/features/music_app/data/data_provider/query_params_provider.dart';
import 'package:musicme/features/music_app/presentation/bloc/genre_block.dart';
import 'package:musicme/features/music_app/presentation/bloc/genre_event.dart';

class GenrePage extends StatelessWidget {
  final List _genres = [
    // list of genres we want to display
    ['Pop', 'Rock'],
    ['Hip-Hop / Rap', 'Electronic'],
    ['Alternative', 'Indie'],
    ['Metal', 'Punk'],
    ['Post-Punk', 'Folk'],
    ['Country', 'Ambient'],
    ['Rhythm and Blues', 'Jazz'],
    ['Classical', 'Spiritual'],
    ['Traditional Music', 'Wack']
  ];
  // these are colors but will be image URI's when we find images we want
  final List _imageAssets = [
    ['assets/images/Pop.jpg', 'assets/images/Rock.jpg'],
    ['assets/images/Rap.jpg', 'assets/images/Electronic.jpg'],
    ['assets/images/Alternative.png', 'assets/images/Indie.jpg'],
    ['assets/images/Metal.jpg', 'assets/images/Punk.jpg'],
    ['assets/images/Post-Punk.png', 'assets/images/Folk.jpg'],
    ['assets/images/Country.jpg', 'assets/images/Ambient.jpg'],
    ['assets/images/RnB.jpg', 'assets/images/Jazz.jpg'],
    ['assets/images/Classical.jpg', 'assets/images/Spiritual.jpg'],
    ['assets/images/Traditional.jpg', 'assets/images/Wack.png']
  ]; // this will be images later
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GenreBloc([], QueryParamsProvider())..add(LoadGenreEvent()),
      child: Scaffold(
        appBar: AppBar(
          leading: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: _genres.length,
            itemBuilder: (BuildContext context, int index) {
              return GenreRow(
                imageAssets: _imageAssets[index],
                tileSpacing: 0,
                genreNames: _genres[index],
              );
            },
          ),
        ),
      ),
    );
  }
}

class GenreRow extends StatelessWidget {
  final List<String> imageAssets; // max size is 2 for now
  final List<String> genreNames; // max size is 2 now
  final double tileSpacing;
  GenreRow({this.imageAssets, this.genreNames, this.tileSpacing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GenreBox(
          imageAsset: imageAssets[0],
          genreName: genreNames[0],
        ),
        SizedBox(
          width: tileSpacing,
        ),
        GenreBox(
          imageAsset: imageAssets[1],
          genreName: genreNames[1],
        ),
      ],
    );
  }
}

class GenreBox extends StatelessWidget {
  // for now showing color but it will display an image later
  final String imageAsset;
  final String genreName;

  GenreBox({this.imageAsset, this.genreName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreBloc, List>(
      builder: (context, genres) {
        if (genres.contains(genreName)) {
          return SelectedGenreBox(imageAsset: imageAsset, genreName: genreName);
        } else {
          return NotSelectedGenreBox(
              imageAsset: imageAsset, genreName: genreName);
        }
      },
    );
  }
}

class NotSelectedGenreBox extends StatelessWidget {
  const NotSelectedGenreBox({
    Key key,
    @required this.imageAsset,
    @required this.genreName,
  }) : super(key: key);

  final String imageAsset;
  final String genreName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<GenreBloc>(context)
                  .add(AddGenreEvent(genreInput: this.genreName));
            },
            child: SizedBox(
                width: 175, height: 175, child: Image.asset(imageAsset)),
          ),
          SizedBox(height: 5),
          Text(
            genreName,
            style: BoxCaption(),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}

TextStyle BoxCaption() {
  return TextStyle(
      fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold);
}

class SelectedGenreBox extends StatelessWidget {
  const SelectedGenreBox({
    Key key,
    @required this.imageAsset,
    @required this.genreName,
  }) : super(key: key);

  final String imageAsset;
  final String genreName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<GenreBloc>(context)
                  .add(RemoveGenreEvent(genreInput: this.genreName));
            },
            child: Stack(
              children: [
                SizedBox(
                  width: 175,
                  height: 175,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(imageAsset)),
                      border: Border.all(width: 8, color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                ),
                Icon(Icons.check_circle),
              ],
            ),
          ),
          SizedBox(height: 5),
          Text(genreName, style: BoxCaption()),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}

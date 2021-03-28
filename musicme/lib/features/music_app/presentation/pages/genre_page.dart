import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicme/features/music_app/data/data_provider/query_params_provider.dart';
import 'package:musicme/features/music_app/presentation/bloc/genre_block.dart';
import 'package:musicme/features/music_app/presentation/bloc/genre_event.dart';

class GenrePage extends StatelessWidget {
  final List _genres = [
    // list of genres we want to display
    ['Pop', 'Rock'],
    ['Hip-hop / Rap', 'Electronic'],
    ['Alternative', 'Indie'],
    ['Metal', 'Punk'],
    ['Post-Punk', 'Folk'],
    ['Country', 'Ambient'],
    ['Rhythm and Blues', 'Jazz'],
    ['Classical', 'Spiritual'],
    ['Traditional Music', 'Wack']
  ];
  // these are colors but will be image URI's when we find images we want
  final List _colors = [
    [Colors.amber, Colors.blue],
    [Colors.red, Colors.green],
    [Colors.green, Colors.amber],
    [Colors.green, Colors.yellow],
    [Colors.blue, Colors.amber],
    [Colors.purple, Colors.yellow],
    [Colors.amber, Colors.amber],
    [Colors.yellow, Colors.yellow],
    [Colors.amber, Colors.amber]
  ]; // this will be images later
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GenreBloc([], QueryParamsProvider()),
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
                  BlocProvider.of<GenreBloc>(context).add(LoadGenreEvent());
                  return GenreRow(
                    colors: _colors[index],
                    tileSpacing: 0,
                    genreNames: _genres[index],
                  );
                }),
          )),
    );
  }
}

class GenreRow extends StatelessWidget {
  final List<Color> colors; // max size is 2 for now
  final List<String> genreNames; // max size is 2 now
  final double tileSpacing;
  GenreRow({this.colors, this.genreNames, this.tileSpacing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GenreBox(
          color: colors[0],
          genreName: genreNames[0],
        ),
        SizedBox(
          width: tileSpacing,
        ),
        GenreBox(
          color: colors[1],
          genreName: genreNames[1],
        ),
      ],
    );
  }
}

class GenreBox extends StatelessWidget {
  // for now showing color but it will display an image later
  final Color color;
  final String genreName;

  GenreBox({this.color, this.genreName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenreBloc, List>(
      builder: (context, genres) {
        if (genres.contains(genreName)) {
          return SelectedGenreBox(color: color, genreName: genreName);
        } else {
          return NotSelectedGenreBox(color: color, genreName: genreName);
        }
      },
    );
  }
}

class NotSelectedGenreBox extends StatelessWidget {
  const NotSelectedGenreBox({
    Key key,
    @required this.color,
    @required this.genreName,
  }) : super(key: key);

  final Color color;
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
              width: 175,
              height: 175,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
                child: Center(
                  child: Text(genreName),
                ),
              ),
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}

class SelectedGenreBox extends StatelessWidget {
  const SelectedGenreBox({
    Key key,
    @required this.color,
    @required this.genreName,
  }) : super(key: key);

  final Color color;
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
                      color: color,
                      border: Border.all(width: 8, color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Center(
                      child: Text(genreName),
                    ),
                  ),
                ),
                Icon(Icons.check_circle),
              ],
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}

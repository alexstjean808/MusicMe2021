import 'package:flutter/material.dart';

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
    return Scaffold(
        appBar: AppBar(
          leading: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
        ),
        body: Center(
          child: ListView.builder(
              padding: EdgeInsets.all(100),
              itemCount: _genres.length,
              itemBuilder: (BuildContext context, int index) {
                return GenreRow(
                  colors: _colors[index],
                  tileSpacing: 100,
                  genreNames: _genres[index],
                );
              }),
        ));
  }
}

class GenreRow extends StatelessWidget {
  final List<Color> colors; // max size is 2 for now
  final List<String> genreNames; // max size is 2 now
  final tileSpacing;
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
    return SizedBox(
      width: 200,
      height: 200,
      child: DecoratedBox(
        decoration: BoxDecoration(color: color),
        child: Center(
          child: Text(genreName),
        ),
      ),
    );
  }
}

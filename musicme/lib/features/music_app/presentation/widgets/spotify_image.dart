import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:spotify_sdk/models/image_uri.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

Widget spotifyImageWidget() {
  return FutureBuilder(
      future: SpotifySdk.getImage(
        imageUri:
            ImageUri('spotify:image:ab67616d0000b2736b4f6358fbf795b568e7952d'),
        dimension: ImageDimension.large,
      ),
      builder: (BuildContext context, AsyncSnapshot<Uint8List> snapshot) {
        if (snapshot.hasData) {
          return Image.memory(snapshot.data);
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
          return SizedBox(
            width: ImageDimension.large.value.toDouble(),
            height: ImageDimension.large.value.toDouble(),
            child: const Center(child: Text('Error getting image')),
          );
        } else {
          return SizedBox(
            width: ImageDimension.large.value.toDouble(),
            height: ImageDimension.large.value.toDouble(),
            child: const Center(child: Text('Getting image...')),
          );
        }
      });
}

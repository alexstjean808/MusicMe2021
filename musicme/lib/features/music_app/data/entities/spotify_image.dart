class SongImages {
  final List<SongImage> images;

  SongImages({this.images});
  factory SongImages.fromJson(Map<String, dynamic> json) {
    var dynamicList = json['images'] as List;
    List<SongImage> images =
        dynamicList.map((i) => SongImage.fromJson(i)).toList();
    return SongImages(images: images);
  }
}

class SongImage {
  final url;

  SongImage(this.url);
  SongImage.fromJson(Map<String, dynamic> json) : url = json["url"];
}

class IbmData {
  final DocumentTones documentTones;

  IbmData(this.documentTones);
  IbmData.fromJson(Map<String, dynamic> json)
      : documentTones = DocumentTones.fromJson(json['document_tone']);
}

class DocumentTones {
  final List<Tone> tones;

  DocumentTones({this.tones});
  factory DocumentTones.fromJson(Map<String, dynamic> json) {
    var dynamicList = json['tones'] as List;
    // ignore: omit_local_variable_types
    List<Tone> listOfTones = dynamicList.map((i) => Tone.fromJson(i)).toList();
    return DocumentTones(tones: listOfTones);
  }
}

class Tone {
  final double score;
  final String toneId;

  Tone(this.score, this.toneId);
  Tone.fromJson(Map<String, dynamic> json)
      : score = json['score'],
        toneId = json['tone_id'];
}

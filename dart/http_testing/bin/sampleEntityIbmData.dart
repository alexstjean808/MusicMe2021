class IbmData {
  final Map document_tone;

  IbmData(this.document_tone);
  IbmData.fromJson(Map<String, dynamic> json)
      : document_tone = json['document_tone'];
}

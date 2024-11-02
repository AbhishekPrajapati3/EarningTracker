class EarningTranscript {
  EarningTranscript({
      String? transcript,}){
    _transcript = transcript;
}

  EarningTranscript.fromJson(dynamic json) {
    _transcript = json['transcript'];
  }
  String? _transcript;
EarningTranscript copyWith({  String? transcript,
}) => EarningTranscript(  transcript: transcript ?? _transcript,
);
  String? get transcript => _transcript;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['transcript'] = _transcript;
    return map;
  }

}
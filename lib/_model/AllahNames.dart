class AllahNames{
  final String name;
  final String pronounce;
  final String meaning;

  AllahNames({this.name,this.meaning,this.pronounce});

  factory AllahNames.fromJson(Map<String, dynamic> json) {
    return AllahNames(
        name: json['name'],
        pronounce: json['transliteration'],
        meaning: json['en']['meaning']
    );
  }

}
class Ayat{
  final String contentArabic;
  final String contentEnglish;
  final int number;
  final String revelat;
  final String surahname;

  Ayat({this.contentArabic,this.contentEnglish,this.number,this.revelat,this.surahname});

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      contentArabic: json['data'][0]['text'],
      contentEnglish: json['data'][1]['text'],
      number: json['data'][0]['number'],
      revelat: json['data'][0]['surah']['revelationType'],
      surahname: json['data'][0]['surah']['englishName'],
    );
  }

}
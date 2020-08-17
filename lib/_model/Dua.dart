class DuaData {
  final String title;
  final String content;
  final String en;
  final String ur;

  DuaData({this.title,this.content,this.en,this.ur});

  factory DuaData.fromJson(Map<String,dynamic> json){
    return DuaData(
      title: json['title'],
      content: json['dua'],
      en: json['en'],
      ur: json['ur']
    );
  }

}
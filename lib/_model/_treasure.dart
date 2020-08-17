import 'dart:collection';

class TreasureData{

  final String title;
  final String content;

  TreasureData({this.title,this.content});

  factory TreasureData.fromJson(Map<String,dynamic> json) {
    return TreasureData(
      title: json['title'],
      content: json['content'],
    );
  }

}
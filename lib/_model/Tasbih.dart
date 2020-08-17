import 'package:Islam786/_utils/_tasbihDatabase.dart';

class TasbihData{
  final int id;
  final String name;
  final int set;
  final int count;

  TasbihData({this.id,this.name,this.set,this.count});

  factory TasbihData.fromJson(Map<String, dynamic> json) {
    return TasbihData(
      id: json[DatabaseInit.id],
      name: json[DatabaseInit.name],
      set: json[DatabaseInit.set],
      count: json[DatabaseInit.count]
    );
  }

}
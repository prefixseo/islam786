import 'dart:convert';

import 'package:Islam786/_model/_treasure.dart';
import 'package:Islam786/_utils/_constData.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;

class Treasure extends StatefulWidget {
  @override
  _TreasureState createState() => _TreasureState();
}

class _TreasureState extends State<Treasure> {

  TreasureData tData = new TreasureData();
  List<TreasureData> _tList = new List();

  double _fontSize = 22;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchTreasure();
  }

  Future<TreasureData> fetchTreasure() async {
    final response = await http.get(new ConstData().treasureApi);
    if (response.statusCode == 200) {
      List<dynamic> jsonobj = json.decode(response.body);
      jsonobj.forEach((element) {
        setState(() {
          _tList.add(TreasureData.fromJson(element));
        });
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Treasure"),
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: Icon(Icons.text_fields,color: Colors.white,),
              onSelected: (c){
                double temp = _fontSize;
                switch(c){
                  case 'Small':
                    temp = 18;
                    break;
                  case 'Normal':
                    temp = 22;
                    break;
                  case 'Large':
                    temp = 30;
                    break;
                }
                setState(() {
                  _fontSize = temp;
                });
              },
              itemBuilder: (BuildContext context) {
                return {'Small','Normal','Large'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
            IconButton(
              icon: Icon(Icons.share,color: Colors.white),
              onPressed: () => Share.share("Get Islamic Treasure on Islam786 ${new ConstData().downloadText}"),
            )
          ]
      ),
      body: Center(
        child: (_tList.length <= 0) ? Center(child: CircularProgressIndicator()) :
        PageView.builder(
          itemCount: _tList.length,
          itemBuilder: (context, i){
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                  ),
                  child: Column(
                    children: <Widget>[
                      Center(
                          child: Text(
                              _tList[i].title,
                              style:  TextStyle(fontWeight:FontWeight.bold,fontSize: 24,)
                          )
                      ),
                      SizedBox(height: 30.0,),
                      Text(
                          _tList[i].content,
                          textAlign: TextAlign.justify,
                          textDirection: TextDirection.rtl,
                          style:  TextStyle(fontFamily: 'NoorQuran',wordSpacing: 5.0,color: Theme.of(context).primaryColor,fontWeight:FontWeight.bold,fontSize: _fontSize,)
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          physics: BouncingScrollPhysics(),
        ),
      )

    );
  }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Islam786/_model/Dua.dart';

class Dua extends StatefulWidget {
  @override
  _DuaState createState() => _DuaState();
}

class _DuaState extends State<Dua> {

  List<DuaData> _allDua = new List();

  double _fontSize = 22;


  fetchDua() async {
    String data = await rootBundle.loadString('assets/content/_dua.json');
    if(data.isNotEmpty)
    {
      var _json = json.decode(data);
      setState(() {
        for(Map i in _json){
          _allDua.add(DuaData.fromJson(i));
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDua();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Masnun Dua"),
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
        ],
      ),
      body: Stack(
        children: <Widget>[
          Image.asset("assets/icons/pray.jpg", fit: BoxFit.fill,height: MediaQuery.of(context).size.height,),
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(),
          ),
          (_allDua == null) ?
          Center(child: CircularProgressIndicator())
              :
          ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _allDua.length,
            itemBuilder: (context,i){
              return Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      _allDua[i].title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Text(
                      _allDua[i].content,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: 'NoorQuran',
                        wordSpacing: 5.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: _fontSize,
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      _allDua[i].ur,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      _allDua[i].en,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

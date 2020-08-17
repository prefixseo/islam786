import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Islam786/_utils/_kalimaData.dart';
import 'package:share/share.dart';

class Kalima extends StatefulWidget {
  @override
  _KalimaState createState() => _KalimaState();
}

class _KalimaState extends State<Kalima> {

  static KalimaData _dataObj = new KalimaData();

  double _fontSize = 22;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("6 Kalimas"),
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
          Image.asset("assets/icons/kalima.jpg", fit: BoxFit.fill,height: MediaQuery.of(context).size.height,),
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(),
          ),
          ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _dataObj.kalima.length,
            itemBuilder: (context,i){
              return Container(
                margin: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0
                ),
                padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: <Widget>[
                    Text("کلمہ "+(i+1).toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0),),
                    SizedBox(height: 10.0,),
                    Text(_dataObj.kalima[i],textAlign:TextAlign.right,textDirection: TextDirection.rtl,style: TextStyle(fontFamily: 'NoorQuran',
                        wordSpacing: 5.0,color: Theme.of(context).primaryColor,fontSize: _fontSize,fontWeight: FontWeight.bold),),
                    SizedBox(height: 10.0,),
                    Text(_dataObj.en[i], style: TextStyle(fontSize: 18.0),)
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

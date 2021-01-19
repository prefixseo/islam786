import 'package:flutter/material.dart';
import 'package:Islam786/_utils/_QuraniDua.dart';

class DuaRabbani extends StatefulWidget {
  @override
  _DuaRabbaniState createState() => _DuaRabbaniState();
}

class _DuaRabbaniState extends State<DuaRabbani> {

  QuraniDua _rabbaniData = new QuraniDua();
  double _fontSize = 22;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dua e Rabbani"),
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
          Image.asset("assets/icons/duaerabbani.jpg", fit: BoxFit.fill,width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,),
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(),
          ),
          ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: _rabbaniData.duaArabic.length,
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
                      _rabbaniData.duaRef[i],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    Text(
                      _rabbaniData.duaArabic[i],
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
                      _rabbaniData.duaTranslate[i],
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

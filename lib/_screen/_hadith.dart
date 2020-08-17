import 'dart:math';

import 'package:Islam786/_utils/_constData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Islam786/_utils/_hadithData.dart';
import 'package:share/share.dart';

class Hadith extends StatefulWidget {
  @override
  _HadithState createState() => _HadithState();
}

class _HadithState extends State<Hadith> {

  static HadithData _dataObj = new HadithData();
  static Random random = new Random();
  int randRef = random.nextInt(_dataObj.getOffsetLength()-1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Holy Hadith"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share, color: Colors.white,),
            onPressed: (){
                Share.share("${_dataObj.getHadith(randRef)}\n\n${_dataObj.getRef(randRef)} \n\n\nDaily Hadith Share from islam786 with Love <3 ${new ConstData().downloadText}");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset("assets/icons/hadith.png"),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 20.0
              ),
              child: Text(_dataObj.getHadith(randRef).toString(),style: TextStyle(fontSize: 18.0,height: 1.3),),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              color: Theme.of(context).primaryColor,
              child: Text(_dataObj.getRef(randRef).toString(),style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}

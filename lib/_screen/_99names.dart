import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Islam786/_model/AllahNames.dart';

class Names99 extends StatefulWidget {
  @override
  _Names99State createState() => _Names99State();
}

class _Names99State extends State<Names99> {

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'ALLAH (ALMIGHTY)',),
    Tab(text: 'PROPHET (PBUH)'),
  ];



  List<AllahNames> _allName = new List();


  fetchNames() async {
    String data = await rootBundle.loadString('assets/content/names99/99namesmola.json');
    if(data.isNotEmpty)
    {
      var _json = json.decode(data);
      setState(() {
        for(Map i in _json['data']){
          _allName.add(AllahNames.fromJson(i));
        }
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    fetchNames();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("99 Holy Names"),
          bottom: TabBar(
            tabs: myTabs,
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
            children: <Widget>[
              _AllahNames(context),
              _ProphetNames(context)
            ]
        ),
      ),
    );
  }

  //-- jSon Content Grid
  Widget _AllahNames(context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/icons/makka.jpg",
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor.withOpacity(0.7),
          child: Center(),
        ),
        ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: _allName.length,
          itemBuilder: (context,i){
            return Container(
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                ),
              child: Column(
                children: <Widget>[
                  Text(
                    _allName[i].name,
                    style: TextStyle(
                      fontFamily: 'NoorQuran',
                      fontWeight: FontWeight.bold,
                      fontSize: 36.0,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(0.0, 5.0),
                          blurRadius: 5.0,
                          color: Colors.black26
                        ),
                      ],
                    ),
                  ),
                  Text(_allName[i].pronounce),
                  Text(_allName[i].meaning, style: TextStyle(fontWeight: FontWeight.bold,),),
                ],
              )
            );
          },
        )
      ],
    );
  }

  // -- Iamges Grid
  Widget _ProphetNames(context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "assets/icons/madina.jpg",
          fit: BoxFit.fill,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor.withOpacity(0.7),
          child: Center(),
        ),
        ListView.builder(
          itemCount: 99,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,i){
            i++;
            return Container(
              padding: EdgeInsets.all(15.0),
              margin: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
              ),
              child: Center(
                child: Image.asset(
                  "assets/content/names99/name ($i).gif",
                ),
              ),
            );
          },
        )
      ],
    );
  }
}

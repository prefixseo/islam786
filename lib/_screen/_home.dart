import 'dart:ui';

import 'package:Islam786/_screen/_lohequrani.dart';
import 'package:Islam786/_screen/_treasure.dart';
import 'package:Islam786/_utils/_constData.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:Islam786/_screen/_99names.dart';
import 'package:Islam786/_screen/_about.dart';
import 'package:Islam786/_screen/_dailyAyah.dart';
import 'package:Islam786/_screen/_disclaimer.dart';
import 'package:Islam786/_screen/_dua.dart';
import 'package:Islam786/_screen/_duarabbani.dart';
import 'package:Islam786/_screen/_hadith.dart';
import 'package:Islam786/_screen/_kalima.dart';
import 'package:Islam786/_screen/_prayerTime.dart';
import 'package:Islam786/_screen/_tasbih.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static var _today = new HijriCalendar.now();
  String hijriDate = _today.toFormat("MMMM dd yyyy");
  var _gridTextFontSize = 15.5;
  bool isOnline = false;


  checkInternet(widget) async{
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => widget),
      );
    }else{
      Toast.show(
        "Turn On Your Internet Connection",
        context,
        gravity: Toast.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Stack(
          children: <Widget>[
            ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 90.0,
                  child: DrawerHeader(
                      child: Text('ISLAM 786', style: TextStyle(color: Colors.white, fontSize: 22.0),),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                      ),
                      margin: EdgeInsets.all(0.0),
                      padding: EdgeInsets.all(20.0)
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.account_box, color: Theme.of(context).primaryColor,),
                  title: Text('About'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => About()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.warning, color: Theme.of(context).primaryColor,),
                  title: Text('Disclaimer'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Disclaimer()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.mail_outline, color: Theme.of(context).primaryColor,),
                  title: Text('Contact'),
                  onTap: () {
                    Navigator.pop(context);
                    launch(new ConstData().contacturl);
                  },
                )
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () => launch(new ConstData().devurl),
                child: Text(
                  "Copyright (c) 2020\nDeveloped By Hello Dear Code\n",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 11.0
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Center(child: Text("Islam 786")),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite,color: Colors.red,),
            onPressed: () => launch("market://details?id=com.hellodearcode.islam786"),
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Image.asset('assets/icons/home.jpg',fit: BoxFit.fill,height: MediaQuery.of(context).size.height,),
          Container(
            color: Theme.of(context).primaryColor.withOpacity(0.7),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(),
          ),
          Positioned(
            child: Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    hijriDate,
                    style: TextStyle(
                      fontSize: 22.0,
                      color:  Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              primary: false,
              slivers: <Widget>[
                SliverPadding(
                  padding: const EdgeInsets.all(10),
                  sliver: SliverGrid.count(
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    children: <Widget>[
                      _quranAyat(),
                      _hadiths(),
                      _digitalTasbih(),
                      _prayerTiming(),
                      _duaequran(),
                      _masnoonDua(),
                      _lohequrani(),
                      _treasure(),
                      _holyNames(),
                      _kalima(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }

  // -- tasbih counter
  Widget _digitalTasbih(){
   return GestureDetector(
     onTap: (){
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => Tasbih()),
       );
     },
     child: Card(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Image.asset('assets/icons/tasbih.png'),
           SizedBox(height: 10.0,),
           Text("Tasbih Counter", style: TextStyle(fontSize: _gridTextFontSize,color: Theme.of(context).primaryColor),),
         ],
       ),
     ),
   );
  }



  // -- Lohe qurani
  Widget _lohequrani(){
   return GestureDetector(
     onTap: (){
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => LoheQurani()),
       );
     },
     child: Card(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: <Widget>[
           Image.asset('assets/icons/lohequrani.png'),
           SizedBox(height: 10.0,),
           Text("Loh e Qurani", style: TextStyle(fontSize: _gridTextFontSize,color: Theme.of(context).primaryColor),),
         ],
       ),
     ),
   );
  }


  // -- dua e qanoot
  Widget _treasure(){
    return GestureDetector(
      onTap: (){
        checkInternet(Treasure());
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/icons/treasure.png'),
            SizedBox(height: 10.0,),
            Text("Treasure", style: TextStyle(fontSize: _gridTextFontSize,color: Theme.of(context).primaryColor),),
          ],
        ),
      ),
    );
  }



  // -- dua e quran
  Widget _duaequran(){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DuaRabbani()),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/icons/qurandua.png'),
            SizedBox(height: 10.0,),
            Text("Dua e Rabbani", style: TextStyle(fontSize: _gridTextFontSize,color: Theme.of(context).primaryColor),),
          ],
        ),
      ),
    );
  }



  // -- Holy Names
  Widget _holyNames(){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Names99()),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/icons/mola.png'),
            SizedBox(height: 10.0,),
            Text("Holy Names", style: TextStyle(fontSize: _gridTextFontSize,color: Theme.of(context).primaryColor),),
          ],
        ),
      ),
    );
  }



  // -- ayat e quran
  Widget _quranAyat(){
    return GestureDetector(
      onTap: (){
        checkInternet(DailyAyah());
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/icons/quran.png'),
            SizedBox(height: 10.0,),
            Text("Holy Aya'h", style: TextStyle(fontSize: _gridTextFontSize,color: Theme.of(context).primaryColor),),
          ],
        ),
      ),
    );
  }


  // -- Hadith
  Widget _hadiths(){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Hadith()),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/icons/hadis.png'),
            SizedBox(height: 10.0,),
            Text("Holy Hadith", style: TextStyle(fontSize: _gridTextFontSize,color: Theme.of(context).primaryColor),),
          ],
        ),
      ),
    );
  }



  // -- Masnun Dua
  Widget _masnoonDua(){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Dua()),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/icons/pray.png'),
            SizedBox(height: 10.0,),
            Text("Masnun Dua", style: TextStyle(fontSize: _gridTextFontSize,color: Theme.of(context).primaryColor),),
          ],
        ),
      ),
    );
  }


  // -- Kalima
  Widget _kalima(){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Kalima()),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/icons/kalima.png'),
            SizedBox(height: 10.0,),
            Text("6 Kalimas", style: TextStyle(fontSize: _gridTextFontSize,color: Theme.of(context).primaryColor),),
          ],
        ),
      ),
    );
  }

  // -- Prayer timing
  Widget _prayerTiming(){
    return GestureDetector(
      onTap: (){
        checkInternet(PrayerTime());
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/icons/azan.png'),
            SizedBox(height: 10.0,),
            Text("Prayer Timing", style: TextStyle(fontSize: _gridTextFontSize, color: Theme.of(context).primaryColor),),
          ],
        ),
      ),
    );
  }
}

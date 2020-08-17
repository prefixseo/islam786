import 'dart:convert';
import 'dart:math';
import 'package:Islam786/_utils/_constData.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:Islam786/_model/Ayat.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';


class DailyAyah extends StatefulWidget {
  @override
  _DailyAyahState createState() => _DailyAyahState();
}

class _DailyAyahState extends State<DailyAyah> {

  AudioPlayer audioPlayer = new AudioPlayer();
  bool isPlaying = false;

  Ayat _ayatObj = new Ayat();
  static Random random = new Random();
  int randAyat = random.nextInt(5000);
  double _fontSize = 22;


  @override
  void initState() {
    fetchAyah();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    audioPlayer.stop();
    audioPlayer.dispose();
  }

  void getAudio() async{
    var audio_url = "https://cdn.alquran.cloud/media/audio/ayah/ar.alafasy/"+ randAyat.toString();
    var res;
    if(isPlaying){
      res = await audioPlayer.pause();
      if(res == 1){
        setState(() {
          isPlaying = false;
        });
      }
    }else{
      res = await audioPlayer.play(audio_url);
      if(res == 1){
        setState(() {
          isPlaying = true;
        });
      }
    }

    audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });

  }


  Future<Ayat> fetchAyah() async {
    final response = await http.get('http://api.alquran.cloud/v1/ayah/'+ randAyat.toString() +'/editions/quran-uthmani,en.pickthall');
    if (response.statusCode == 200) {
      setState(() {
        _ayatObj = Ayat.fromJson(json.decode(response.body));
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  // -- UI Layout


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Holy Aya'h"),
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
              return {'Small', 'Normal','Large'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.white,),
            onPressed: (){
              if(_ayatObj != null) {
                Share.share("${_ayatObj.contentArabic} (#${_ayatObj.number.toString()}) ${_ayatObj.surahname} ${_ayatObj.revelat}\n\n\nDaily Aya'h Share from islam786 with Love <3 ${new ConstData().downloadText}");
              }
            },
          ),
        ],
      ),
      body: (_ayatObj.contentArabic == null)
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: Image.asset("assets/icons/ayah.png"),
              ),
              Container(
                margin: EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: () => getAudio(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        isPlaying == false
                            ? Icons.play_circle_filled
                            : Icons.stop
                        ,
                        color: Theme.of(context).primaryColor,
                        size: 48,
                      ),
                      Text("Listen")
                    ],
                  )
                ),
              ),
              Container(
                child: Text(_ayatObj.contentArabic,textAlign: TextAlign.right,style: TextStyle(fontFamily: 'NoorQuran',
                        wordSpacing: 5.0,color: Theme.of(context).primaryColor,fontSize: _fontSize),),
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "(#" + _ayatObj.number.toString() +
                      ") " + _ayatObj.surahname + " - " + _ayatObj.revelat,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                ),
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
              ),
              Container(
                child: Text(_ayatObj.contentEnglish,style: TextStyle(fontSize: 18,height: 1.3),),
                padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

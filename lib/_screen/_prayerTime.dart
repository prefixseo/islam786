import 'dart:convert';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class PrayerTime extends StatefulWidget {
  @override
  _PrayerTimeState createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime> {

  var lat,lng,geoCodeData,timingData;

  double _cellFontSize = 18.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchLatLng();
  }

  _fetchLatLng() async {
    bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();
    if(isLocationEnabled) {
      Position position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        lat = position.latitude;
        lng = position.longitude;
      });
      fetchDataApi();
      fetchGeoCode();
    }else{
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Can't get gurrent location"),
              content:
              const Text('Please make sure you enable GPS and try again'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    final AndroidIntent intent = AndroidIntent(
                        action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                    intent.launch();
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  fetchGeoCode() async{
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(lat,lng);
    // this is all you need
    Placemark placeMark  = placemark[0];
    String locality = placeMark.locality;
    String administrativeArea = placeMark.administrativeArea;
    String country = placeMark.country;
    setState(() {
      geoCodeData = "${locality}, ${administrativeArea}, ${country}";
    });
  }
  fetchDataApi() async{
    final response = await http.get('https://salah.com/get?lg=$lng&lt=$lat');
    if (response.statusCode == 200) {
      setState(() {
        timingData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load album');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Prayer Times")
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(child: Image.asset("assets/icons/prayer_time.png")),
            (geoCodeData == null)
            ? CircularProgressIndicator()
            : Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0),
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                child: Text(
                  geoCodeData,
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: (timingData == null) ? CircularProgressIndicator()
              : Table(
                border: TableBorder.all(width: 1.0,color: Theme.of(context).primaryColor),
                children: [
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("Fajr",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontSize: _cellFontSize))),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(timingData['times']['Fajr'],style: TextStyle(fontSize: _cellFontSize))),
                        ),
                      )
                    ]
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("Sunrise",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontSize: _cellFontSize))),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(timingData['times']['Sunrise'],style: TextStyle(fontSize: _cellFontSize))),
                        ),
                      )
                    ]
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("Dhuhr",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontSize: _cellFontSize))),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(timingData['times']['Dhuhr'],style: TextStyle(fontSize: _cellFontSize))),
                        ),
                      )
                    ]
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("Asr",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontSize: _cellFontSize))),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(timingData['times']['Asr'],style: TextStyle(fontSize: _cellFontSize))),
                        ),
                      )
                    ]
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("Maghrib",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontSize: _cellFontSize))),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(timingData['times']['Maghrib'],style: TextStyle(fontSize: _cellFontSize))),
                        ),
                      )
                    ]
                  ),
                  TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("Isha",style: TextStyle(fontWeight: FontWeight.bold,color: Theme.of(context).primaryColor,fontSize: _cellFontSize))),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text(timingData['times']['Isha'],style: TextStyle(fontSize: _cellFontSize))),
                        ),
                      )
                    ]
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

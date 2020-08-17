import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Islam786/_model/Tasbih.dart';
import 'package:Islam786/_utils/_radialProgress.dart';
import 'package:Islam786/_utils/_tasbihHelper.dart';

class TasbihCounter extends StatefulWidget {
  final int id;
  TasbihCounter({Key key, @required this.id}) : super(key: key);
  @override
  _TasbihCounterState createState() => _TasbihCounterState();
}

class _TasbihCounterState extends State<TasbihCounter> {

  TasbihData _cTasbih;
  int counter = 0;
  double progress = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    var _t = await ActionServiceTasbih.getTasbih(widget.id);
    setState(() {
      _cTasbih = _t;
    });
  }

  resetSets() async {
    await ActionServiceTasbih.updateSet(0, _cTasbih.id);
    _fetchData();
    setState(() {
      counter = 0;
      progress = 0.0;
    });
  }


  _counterRun() async {
    if(counter < _cTasbih.count){
      setState(() {
        counter = counter + 1;
        progress = (counter / _cTasbih.count) * 100;
      });
    }
    if(counter == _cTasbih.count){
      var s = _cTasbih.set + 1;
      await ActionServiceTasbih.updateSet(s, _cTasbih.id);
      setState(() {
        counter = 0;
        progress = 0.0;
      });
      _fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Digital Tasbih"),
      ),
      body: (_cTasbih == null)
      ?
          Center(child: CircularProgressIndicator())
      :
      InkWell(
        onTap: (){
          _counterRun();
        },
        splashColor: Theme.of(context).primaryColor.withOpacity(0.7),
        child: Column(
          children: <Widget>[
            Center(
              child: FlatButton(
                color: Theme.of(context).primaryColor,
                child: Text("Reset",style: TextStyle(color: Colors.white)),
                onPressed: () { resetSets(); },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: Center(
                child: Text(
                  _cTasbih.name,
                  style: TextStyle(
                    fontSize: 22.0,
                  ),
                ),
              ),
            ),
            Center(
              child: Text("Set: ${_cTasbih.set}", style: TextStyle(color: Colors.deepOrange,fontSize: 18.0)),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 50.0),
              height: MediaQuery.of(context).size.height/2,
              child: CustomPaint(
                foregroundPainter: RadialPainter(
                    bgColor: Colors.grey[200],
                    lineColor: Theme.of(context).primaryColor,
                    percent: progress/100,
                    width: 15.0
                ),
                child: Center(
                  child: Text(
                    '${counter} / ${_cTasbih.count}',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(25.0),
              child: Center(
                child: Text(
                  "Tap anywhere to run counter",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

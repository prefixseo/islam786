import 'package:flutter/material.dart';

class LoheQurani extends StatefulWidget {
  @override
  _LoheQuraniState createState() => _LoheQuraniState();
}

class _LoheQuraniState extends State<LoheQurani> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loh e Qurani"),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Image.asset("assets/icons/loh.png",width: 300,height: 300,),
          ),
          Column(
            children: <Widget>[
              Text(
                "لوح قرآنی",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                child: Center(
                  child: Table(
                    border: TableBorder.all(width: 1.0,color: Theme.of(context).primaryColor),
                    children: [
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("ن",style: TextStyle(fontFamily: 'NoorQuran',
                        wordSpacing: 5.0,fontSize: 24.0),),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("حمعسق",style: TextStyle(fontFamily: 'NoorQuran',
                        wordSpacing: 5.0,fontSize: 24.0),),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("الم",style: TextStyle(fontFamily: 'NoorQuran',
                        wordSpacing: 5.0,fontSize: 24.0),),
                              ),
                            ),
                          ),
                        ]
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("يس",style: TextStyle(fontFamily: 'NoorQuran',
                        wordSpacing: 5.0,fontSize: 24.0),),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("حم",style: TextStyle(fontFamily: 'NoorQuran',
                        wordSpacing: 5.0,fontSize: 24.0),),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("المص",style: TextStyle(fontFamily: 'NoorQuran',
                        wordSpacing: 5.0,fontSize: 24.0),),
                              ),
                            ),
                          ),
                        ]
                      ),
                      TableRow(
                        children: [
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("آمين",style: TextStyle(fontFamily: 'NoorQuran',
                        wordSpacing: 5.0,fontSize: 24.0),),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("ق",style: TextStyle(fontFamily: 'NoorQuran',
                        wordSpacing: 5.0,fontSize: 24.0),),
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text("كهيعص",style: TextStyle(fontFamily: 'NoorQuran',
                        wordSpacing: 5.0,fontSize: 24.0),),
                              ),
                            ),
                          ),
                        ]
                      ),
                    ],
                  ),
                ),
              )
            ]
          ),
        ],
      ),
    );
  }
}
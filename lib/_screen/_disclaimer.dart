import 'package:Islam786/_utils/_constData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Disclaimer extends StatefulWidget {
  @override
  _DisclaimerState createState() => _DisclaimerState();
}

class _DisclaimerState extends State<Disclaimer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Disclaimer"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0
          ),
          child: Column(
            children: <Widget>[
              Center(child: Image.asset("assets/icons/disclaimer.png")),
              Text("اس ایپ میں استعمال تمام مواد آنلائن مختلف ویبسائٹس سے حاصل کیا جا رہا ہے۔ \n اگر آپکو اس میں کسی بھی طرح کی غلطی معلوم ہو تو براہ کرم اپنی رائے سے آگاہ کر کے درستگی کروائیں۔ \n آپ کا یہ عمل دوسروں کے لئے فائدہ، اور آپ کے لئے صدقہ جاریہ ہو گا۔ \n جزاک اللہ \n ایڈمن اسلام ۷۸۶ ",
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("Contact Now", style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      launch(new ConstData().contacturl);
                    },
                  ),
                ),
              ),
              Text("All content used in this app is being retrieved online from various websites.\nIf you find any errors in it, please let us know your opinion and correct it.\nYour action will benefit others, and charity will continue for you.\nجزاک اللہ\nAdmin Islam786",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

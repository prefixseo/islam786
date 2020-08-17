import 'package:Islam786/_utils/_constData.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 20.0
          ),
          child: Column(
            children: <Widget>[
              Center(child: Image.asset("assets/icons/about.png")),
              Container(
                padding: EdgeInsets.all(5.0),
                child: Text("اسلام ۷۸۶ ایک اسلامی ایپ ہے، جو کے اپنے استعمال کرنے والے مسلمانوں کو ایک اچھے اور آسان انٹرفیس کے زریعے مختلف اسلامی خدمات کا حصول ممکن بناتی ہے۔\nاسلام ۷۸۶ میں مسلمانوں کی فلاح و بہبود کے لئے مختلف ایپلیٹ ڈالے گئے ہیں، جو کے ہر مسلمان روزمرہ معمول آسانی کے ساتھ استعمال کرسکتا ہے۔\nنوت: اسلام ۷۸۶ ایک برقی زریعہ معلومات ہے، غلطی کوتاہی کو بر وقت رپورٹ کر کے صدقہ جاریہ کرتے رہیں\nہم آپ کی زاتی رائے اور تجاویز کا تہ دل خیر مقدم کرتے ہیں",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    child: Text("Drop Suggestion/Report Problem", style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      launch(new ConstData().contacturl);
                    },
                  ),
                ),
              ),
              Text("Islam786 is an Islamic app that allows its users to access various Islamic services through a nice and easy interface.\nIslam786 has various applets for the welfare of Muslims, which every Muslim can easily use in his daily routine.\nNote: Islam786 is an electronic source of information, report mistakes in a timely manner and continue giving charity.\nWe warmly welcome your personal feedback and suggestions",
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

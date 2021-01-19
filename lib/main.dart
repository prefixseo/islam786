import 'package:Islam786/_utils/_pushNotificationService.dart';
import 'package:flutter/material.dart';
import 'package:Islam786/_screen/_home.dart';
import 'package:Islam786/_utils/_tasbihDatabase.dart';
import 'package:flutter/services.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await DatabaseInit().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushNotificationService().initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "islam786",
      theme: ThemeData(
        primaryColor: Color(0xff008080)
      ),
      home: Home()
    );
  }
}

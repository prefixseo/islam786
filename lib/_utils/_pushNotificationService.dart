import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _fmc = FirebaseMessaging();
  String notifTitle = '';
  Random _rand = new Random();
  String notifBody = '';

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;


  void ShowNotification() async {
    await notification();
  }

  Future<void> notification() async{
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      "inapp", "in-App", "In-App Notification",
      priority: Priority.High,
      importance: Importance.Max,
      ticker: "Test", // add this line in your code
      styleInformation: BigTextStyleInformation(''),
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails,iosNotificationDetails);
    await _flutterLocalNotificationsPlugin.show(_rand.nextInt(800), this.notifTitle , this.notifBody, notificationDetails);
  }

  Future OnSelectNotification(String payload) async{
    if(payload != null){
      print(payload);
    }
  }

  Future initialize() async{
    androidInitializationSettings = AndroidInitializationSettings("app_icon");
    initializationSettings = InitializationSettings(androidInitializationSettings,iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: OnSelectNotification);

    if(Platform.isIOS){
      _fmc.requestNotificationPermissions(IosNotificationSettings());
    }

   // _fmc.getToken().then((value) => print(value));

    _fmc.configure(
      onMessage: (Map<String, dynamic> message){
        this.notifTitle = message['notification']['title'];
        this.notifBody = message['notification']['body'];
        ShowNotification();
        //print("onmsg: ${message}");
        return;
      },
      onLaunch: (Map<String, dynamic> message){
        this.notifTitle = message['notification']['title'];
        this.notifBody = message['notification']['body'];
        ShowNotification();
//        print("launch: ${message}");
        return;
      },
      onResume: (Map<String, dynamic> message){
        this.notifTitle = message['notification']['title'];
        this.notifBody = message['notification']['body'];
        ShowNotification();
//        print("resume: ${message}");
        return;
      }
    );

  }

}
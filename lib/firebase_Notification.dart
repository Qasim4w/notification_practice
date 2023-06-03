
import 'package:http/http.dart'as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class FirebaseNotification {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,

        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('*********User Granted Permission Accepted**********');
    }
    else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('*********Provisional Permission Accepted**********');
    } else {
      print('*********User Denied  Permission **********');
    }
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void saveToken(String token) {
    FirebaseFirestore.instance.collection('User Token').doc('User1').set({
      'token': token
    });
  }

  initInfo() {
    var androidInitialize = const AndroidInitializationSettings('map');
    var iosInitialize = const IOSInitializationSettings();
    var initializationSetting = InitializationSettings(
        android: androidInitialize, iOS: iosInitialize);
    _flutterLocalNotificationsPlugin.initialize(
        initializationSetting, onSelectNotification: (String?payLoad) async {
      try {
        if (payLoad != null && payLoad.isNotEmpty) {

        } else {

        }
      }
      catch (e) {
        return;
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('*************On Message****************');
      print('On Message: ${message.notification!.title.toString()}\ ${message.notification!.body.toString()}');
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(), htmlFormatBigText: true,
        contentTitle: message.notification!.title,
        htmlFormatContentTitle: true,);
      AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
          'channelId', 'channelName',
          styleInformation: bigTextStyleInformation,
          importance: Importance.max,
          priority: Priority.high, playSound: false);
      NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails,iOS: IOSNotificationDetails());
      _flutterLocalNotificationsPlugin.show(0, message.notification?.title.toString(), message.notification?.body, notificationDetails,
      payload: message.data['body']);
    });

    }

    Future<void> sendPushMessage(String token,String titleText,String bodyText) async {
    try{
      await http.post(Uri.parse('http://fcm.google.com/fcm/send')
          ,headers: <String,String>{
        'Content-Type':'application/json',
            'Authorization':'key='
          });
    }
        catch(e){}

    }


}
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'home.dart';
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print('Handle a Background Data ${message.messageId}');
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
}

Future<void> main()  async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
   FirebaseMessaging.instance.getInitialMessage();
   FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      home: const Home(),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notification_practice/firebase_Notification.dart';
import 'package:notification_practice/localPush.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 FirebaseNotification notification =FirebaseNotification();
 LocalNotification notifi = LocalNotification();
  @override
  void initState() {
notifi.initliseNotification;
    // notification.requestPermission();
    // notification.getDeviceToken().then((value) =>{ print('Device Token is '+ value),
    // notification.saveToken(value!),
    // notification.initInfo()});

    // TODO: implement initState
    super.initState();
  }
  TextEditingController username =TextEditingController();
  TextEditingController title =TextEditingController();
  TextEditingController body =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(controller: username,decoration: InputDecoration(hintText: 'User Name'),),
            TextFormField(controller: title,decoration: InputDecoration(hintText: 'Title'),),
            TextFormField(controller: body,decoration: InputDecoration(hintText: 'BOdy'),),
SizedBox(height: 10,),
            GestureDetector(onTap: ()  {
              notifi.showNotification('Hi', 'Body');
              // String name=username.text.toString();
              // String title1=title.text.toString();
              // String body1=body.text.toString();
              // if(name != ""){
              //   DocumentSnapshot snap = await FirebaseFirestore.instance.collection('UserToken').doc(name).get();
              //   String Token = snap['token'];
              //   print('Device Token is $Token');
              //   // sendPushMessage(token,titleText,bodyText);
              }
    ,
              child: Container(
                height: 40,width: 200,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(color: Colors.redAccent.withOpacity(0.5)),]
                ),
                child:Center(child: const  Text(' Button ')),
              ),
            )
          ],
        ),
      ),
    );
  }
}

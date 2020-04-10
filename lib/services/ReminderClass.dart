
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:math';
import '../models/reminder.dart';
import 'package:flutter/cupertino.dart';
class ReminderClass {

  FlutterLocalNotificationsPlugin localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();




  initializeNotifications() async {
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);


    var result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
//
  print(title);
  print(body);
  }



  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    print(payload);
//    await Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => SecondScreen(payload)),
//    );
  }


  Future<dynamic> chekPendingNotificationRequests() async {
    List<Reminder> reminders = List<Reminder>();

    var pendingNotificationRequests =
    await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    for (var pendingNotificationRequest in pendingNotificationRequests) {

//      debugPrint(
//          'pending notification: [id: ${pendingNotificationRequest.id}, title: ${pendingNotificationRequest.title}, body: ${pendingNotificationRequest.body}, payload: ${pendingNotificationRequest.payload}]');
//
      reminders.add(Reminder(id: pendingNotificationRequest.id.toString(),title: pendingNotificationRequest.title,body:pendingNotificationRequest.body ));
      print('------');
    }
    //return jsonEncode(reminders);
    //print(jsonEncode(reminders));
    return  reminders;

  }



  void getAllNotification() async{
    var pendingNotificationRequests = await flutterLocalNotificationsPlugin.pendingNotificationRequests();

  }

  void cancelNotificationByID(reminderID) async{
    await flutterLocalNotificationsPlugin.cancel(reminderID);

  }

  void scheduleNotification(reminderDate,reminderTime,reminderTitle,reminderID) async {

    var getUserDateAndTime = reminderDate.split('-');
    var getUserTime = reminderTime.split(':');

    print(getUserDateAndTime);
    var year = int.parse(getUserDateAndTime[0]);
    var month = int.parse(getUserDateAndTime[1]);
    var day = int.parse(getUserDateAndTime[2]);

    var hour = int.parse(getUserTime[0]);
    var minutes = int.parse(getUserTime[1]);
    var seconds = double.parse(getUserTime[2]);

    //       print(getUserTime);
    var d1 = DateTime(year,month,day,hour,minutes,seconds.round());

    var remindTitle = reminderTitle.text;

    var scheduledNotificationDateTime = d1;




    var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your other channel id',
        'your other channel name', 'your other channel description');
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    Random random = new Random();
    int notificationID = random.nextInt(10000);

    cancelNotificationByID(reminderID);

    await flutterLocalNotificationsPlugin.schedule(
        notificationID,
        '$remindTitle',
        '$scheduledNotificationDateTime',
        scheduledNotificationDateTime,
        platformChannelSpecifics).then((onValue){
      print('its should be run on ..$scheduledNotificationDateTime');
    });
  }


  scheduleNoti(reminderTitle,reminderTime) async{
    print("OKKK");

    var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('your other channel id',
        'your other channel name', 'your other channel description');
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);


    Random random = new Random();
    int notificationID = random.nextInt(10000);

    await flutterLocalNotificationsPlugin.schedule(
        notificationID,
        '$reminderTitle',
        '$reminderTime',
        reminderTime,
        platformChannelSpecifics).then((onValue){
      print('its should be run on ..$reminderTime');
    });
  }


}

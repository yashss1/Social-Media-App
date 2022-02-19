import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:social_media/Services/authentication_helper.dart';
import 'package:social_media/Services/get_user_data.dart';
import 'package:social_media/Verification%20Screens/verification_screen.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  //Yash
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, // Required to display a heads up notification
    badge: true,
    sound: true,
  );

  //Local Notification
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    // print('Got a message whilst in the foreground!');
    // print('Message data: ${message.data}');
    //
    // if (message.notification != null) {
    //   print('Message also contained a notification: ${message.notification}');
    // }

    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // description: channel.description,
              color: Colors.blue,
              playSound: true,
              icon: '@mipmap/ic_launcher',
            ),
          ));
    }
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      // showDialog(
      //     context: context,
      //     builder: (_) {
      //       return AlertDialog(
      //         title: Text(notification.title),
      //         content: SingleChildScrollView(
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [Text(notification.body)],
      //           ),
      //         ),
      //       );
      //     });
      print("Body : " + notification.body!);
    }
  });

  runApp(MyApp());
}

Future isLoggedIn() async {
  FirebaseAuth.instance.currentUser!;
}



class MyApp extends StatefulWidget {

  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? user = FirebaseAuth.instance.currentUser;

  void showNotification(String title, String message) {
    flutterLocalNotificationsPlugin.show(
        0,
        title,
        message,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            // description: channel.description,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    showNotification("Hey", "Welcome to Signature");

    // print(AppSettings.pushNotification.toString());
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));

    // If user has already logged in we direct him to home page else to the login screen!
    if (user != null) {
      FirebaseMessaging.instance.getToken().then((value) {
        AuthenticationHelper().storeToken(value);
      });
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          primarySwatch: Colors.blue,
        ),
        home: GetUserData(),
      );
    } else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          primarySwatch: Colors.blue,
        ),
        home: MainRegistration(),
      );
    }
  }
}

// ignore_for_file: unused_local_variable

import 'package:budget_buddy/features/Home/dashboard.dart';
import 'package:budget_buddy/features/Main/home_screen.dart';
import 'package:budget_buddy/providers/AuthProvider.dart';
import 'package:budget_buddy/providers/BudgetProvider.dart';
import 'package:budget_buddy/providers/GroupProvider.dart';
import 'package:budget_buddy/providers/NewsProvider.dart';
import 'package:budget_buddy/providers/PostProvider.dart';
import 'package:budget_buddy/providers/UserProvider.dart';
import 'package:budget_buddy/providers/WishProvider.dart';
import 'package:budget_buddy/utils/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'themes/dark_theme.dart';
import 'themes/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, badge: true, sound: true);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (message.notification != null) {
      try {
        await flutterLocalNotificationsPlugin.initialize(
          const InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          ),
        );
      } on Exception catch (e) {}

      try {
        await flutterLocalNotificationsPlugin.show(
          message.notification!.hashCode,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
        );
      } catch (e) {}
    }
  });
  print("Subscibing to topic...");
  FirebaseMessaging.instance.subscribeToTopic("a").then((value) {
    print("Subscribed to topic a");
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<BudgetProvider>(
          create: (_) => BudgetProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<NewsProvider>(
          create: (_) => NewsProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<WishProvider>(
          create: (_) => WishProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<PostProvider>(
          create: (_) => PostProvider(),
          lazy: false,
        ),
        ChangeNotifierProvider<GroupProvider>(
          create: (_) => GroupProvider(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        theme: light_theme(),
        darkTheme: dark_theme(),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        // initialRoute: SplashScreen.id,
        // home: Preferences(),
        initialRoute: HomeScreen.id,
        routes: routes,
      ),
    );
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

const NotificationDetails notificationDetails = NotificationDetails(android: details);

const AndroidNotificationDetails details = AndroidNotificationDetails(
  'important_notifications',
  'Important Notifications',
  channelDescription: 'This channel is used for important notifications.',
  importance: Importance.max,
  priority: Priority.high,
  ticker: 'ticker',
  icon: "@mipmap/ic_launcher",
);

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description: 'This channel is used for important notifications.', // description
  playSound: true,
  importance: Importance.max,
);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("FCP message: ${message.notification!.title}");
  print("FCP body: ${message.notification!.body}");

  await flutterLocalNotificationsPlugin.show(
    0,
    message.notification!.title,
    message.notification!.body,
    notificationDetails,
  );
}

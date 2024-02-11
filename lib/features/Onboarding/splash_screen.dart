import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../Main/home_screen.dart';
import '../../utils/shared_preference.dart';
import 'package:provider/provider.dart';
import '../../providers/AuthProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/User.dart';
import '../../providers/UserProvider.dart';
import 'login_screen.dart';
import 'splash_content.dart';

class SplashScreen extends StatefulWidget {
  static const String id = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late bool isLoggedIn = false;
  late bool isAdmin = false;
  late bool isProvider = false;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  double begin = 0, end = 1;
  int splashDuration = 900;

  @override
  void initState() {
    Provider.of<AuthProvider>(context, listen: false).refreshToken();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
        reverseCurve: Curves.bounceIn);
    _animationController.forward();
    initMessaging();
    super.initState();
  }

  void _startActivityTimer() async {
    print("running");
    UserPreferences userPreferences = UserPreferences();
    User user = await userPreferences.getUser();
    if (user.accessToken == '' && mounted) {
      Navigator.of(context, rootNavigator: true)
          .pushNamedAndRemoveUntil(LoginScreen.id, (route) => false);
    } else if (mounted) {
      Navigator.of(context, rootNavigator: true)
          .pushNamedAndRemoveUntil(HomeScreen.id, (route) => false);
    }
  }

  @override
  void dispose() {
    // _animationController.dispose();
    super.dispose();
  }

  void initMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    FlutterLocalNotificationsPlugin fltNotification =
        FlutterLocalNotificationsPlugin();
    var androiInit = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInit = const DarwinInitializationSettings();
    var initSetting = InitializationSettings(android: androiInit, iOS: iosInit);

    fltNotification.initialize(initSetting);
    var androidDetails = const AndroidNotificationDetails(
      "default",
      "channel name",
      color: Colors.red,
      priority: Priority.high,
      importance: Importance.max,
      // styleInformation: styleinformation,
    );
    var iosDetails = const DarwinNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    // _firebaseMessaging.requestPermission();
    _firebaseMessaging.subscribeToTopic("Flutter");
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        fltNotification.show(notification.hashCode, notification.title,
            notification.body, generalNotificationDetails);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: begin, end: end),
            duration: Duration(milliseconds: splashDuration),
            onEnd: () {
              if (end != 0) {
                Future.delayed(Duration(milliseconds: splashDuration), () {
                  setState(() {
                    begin = 1;
                    end = 0;
                  });
                });
              }
              if (end == 0) {
                _startActivityTimer();
              }
            },
            builder: (BuildContext context, double opacity, Widget? child) {
              return SplashContent(opacity: opacity);
            },
          ),
        ));
  }
}

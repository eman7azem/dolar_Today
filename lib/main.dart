import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'fcm_service.dart';
import 'presentaion/bottomBar/bottomBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../service/admob_services.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  RewardedAd? _rewardedAd;
  late Timer _rewardedAdTimer;
  bool showed = false;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    messaging.subscribeToTopic("all");

    _createRewardAd();
    _rewardedAdTimer = Timer.periodic(Duration(minutes: 5), (timer) {
      _showRewardedAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سعر الدولار اليوم في السوق السودا',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.white)
      ),
      debugShowCheckedModeBanner: false,
      home:BottomBar() ,
    );
  }

  void _createRewardAd() {
    RewardedAd.load(
        adUnitId: AdMobService.rewardAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) => setState(() {
              _rewardedAd = ad;
              if(!showed){
                _showRewardedAd();
              }
              showed = true;
            }),
            onAdFailedToLoad: (LoadAdError error) {
              debugPrint('Add failed to load $error');
            }));
  }
  void _showRewardedAd(){
    if(_rewardedAd != null){
      _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (ad){
            ad.dispose();
            _createRewardAd();
          },
          onAdFailedToShowFullScreenContent: (ad, error){
            ad.dispose();
            _createRewardAd();
          }
      );
      _rewardedAd!.show(onUserEarnedReward: (ad, reward) {});
      _rewardedAd = null;
    }
  }
}


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'API/api.dart';
import 'fcm_service.dart';
import 'presentaion/bottomBar/bottomBar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../service/admob_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;
  late SharedPreferences prefs;

  RewardedAd? _rewardedAd;
  RewardedInterstitialAd? _rewardedInterstitialAd;
  Timer? _timer;

  final _api = API();

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

    WidgetsBinding.instance.addObserver(this);
    _loadInterstitialRewardedAd();
    _shared();
  }

  void _shared() async {
    prefs = await SharedPreferences.getInstance();
  }

  void _loadInterstitialRewardedAd() {
    RewardedInterstitialAd.load(
      adUnitId: AdMobService.rewardInterstitialUnitId,
      request: AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedInterstitialAd = ad;
          _showInterstitialRewardedAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedInterstitialAd failed to load: $error');
        },
      ),
    );
  }

  void _showInterstitialRewardedAd() {
    _rewardedInterstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        Fluttertoast.showToast(
          msg:
          "شكرًا لدعمكم ومشاركتكم في مشاهدة الإعلانات، إنها الوسيلة الوحيدة لنا لضمان استمرارية التطبيق وتحسين دقة البيانات. نقدر دعمكم وثقتكم بنا!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFF2378A8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        print('Interstitial ad failed to show: $error');
      },
    );
    _rewardedInterstitialAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {  });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سعر الدولار اليوم في السوق السودا',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
      ),
      debugShowCheckedModeBanner: false,
      home: BottomBar(),
    );
  }

  void _showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd!.fullScreenContentCallback =
          FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
        Fluttertoast.showToast(
          msg:
              "شكرًا لدعمكم ومشاركتكم في مشاهدة الإعلانات، إنها الوسيلة الوحيدة لنا لضمان استمرارية التطبيق وتحسين دقة البيانات. نقدر دعمكم وثقتكم بنا!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(0xFF2378A8),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        ad.dispose();
      }, onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _createRewardAd();
      });
      _rewardedAd!.show(onUserEarnedReward: (ad, reward) {});
      _rewardedAd = null;
    }
  }

  void _createRewardAd() {
    RewardedAd.load(
        adUnitId: AdMobService.rewardAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          _rewardedAd = ad;
          _showRewardedAd();
        }, onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Add failed to load $error');
        }));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    AdMobService.isRewardedShowed = false;
    super.dispose();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _interstitialAd = ad;
            _isInterstitialAdReady = true;
          },
          onAdFailedToLoad: (LoadAdError error) {}),
    );
  }

  void _showInterstitialAd() {
    if (_isInterstitialAdReady) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {},
        onAdFailedToShowFullScreenContent: (ad, error) {
          print('Interstitial ad failed to show: $error');
        },
      );
      _interstitialAd!.show();
    } else {
      print('Interstitial ad is not ready yet.');
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}
}

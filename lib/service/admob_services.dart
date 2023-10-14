import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class AdMobService {

  static bool isRewardedShowed = false;

  static String get bannerAdUnitId {
    return 'ca-app-pub-6848148437732539/7202509694';
  }
  static String get interstitialAdUnitId {
    return 'ca-app-pub-6848148437732539/5983639245';
  }
  static String get rewardAdUnitId {
    return 'ca-app-pub-6848148437732539/8324057664';
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad Loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad failed to load: $error');
    }
  );
}
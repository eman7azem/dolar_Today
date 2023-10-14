import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class AdMobService {

  static bool isRewardedShowed = false;

  static String get bannerAdUnitId {
    return 'ca-app-pub-1927974795737593/3705680446';
  }
  static String get interstitialAdUnitId {
    return 'ca-app-pub-6848148437732539/5983639245';
  }
  static String get rewardAdUnitId {
    return 'ca-app-pub-1927974795737593/1877593453';
  }

  static String get rewardInterstitialUnitId {
    return 'ca-app-pub-1927974795737593/4559597112';
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad Loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad failed to load: $error');
    }
  );
}
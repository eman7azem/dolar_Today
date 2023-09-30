import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class AdMobService {
  static String get bannerAdUnitId {
    return 'ca-app-pub-6848148437732539/3717656299';
  }
  static String get interstitialAdUnitId {
    return 'ca-app-pub-6848148437732539/1632788126';
  }
  static String get rewardAdUnitId {
    return 'ca-app-pub-3940256099942544/5224354917';
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint('Ad Loaded'),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint('Ad failed to load: $error');
    }
  );
}
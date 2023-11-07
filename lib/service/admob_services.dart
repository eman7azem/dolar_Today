import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';


class AdMobService {

  static bool isRewardedShowed = false;

  static String get bannerAdUnitId {
    return 'ca-app-pub-1927974795737593/8054089182';
  }

  static String get interstitialAdUnitId {
    return 'ca-app-pub-1927974795737593/9828163255';
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
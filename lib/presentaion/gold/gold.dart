import 'dart:async';

import 'package:dolar_today/models/gold.dart';
import 'package:dolar_today/service/admob_services.dart';
import 'package:dolar_today/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../API/api.dart';
import '../../constants/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Gold extends StatefulWidget {
  const Gold({super.key});

  @override
  State<Gold> createState() => _GoldState();
}

class _GoldState extends State<Gold> {

  RewardedInterstitialAd? _rewardedInterstitialAd;
  Timer? _timer;

  List<String> goldImage = [
    'assets/images/gold.png',
    'assets/images/gold.png',
    'assets/images/gold.png',
    'assets/images/gold.png',
    'assets/images/gold.png',
    'assets/images/coin.png',
    'assets/images/kilo_gold.png',
    'assets/images/kilo_gold.png',
  ];
  List<String> text = [
    'ذهب عيار 10',
    'ذهب عيار 14',
    'ذهب عيار 18',
    'ذهب عيار 21',
    'ذهب عيار 24',
    'جنيه ذهب',
    'اونصة الذهب',
    'كيلو الذهب',
  ];

  final _api = API();

  @override
  void initState() {
    super.initState();
    //_adTimer();
  }

  bool isThreeMinutesPassed(String? lastAdTimeStr) {
    if (lastAdTimeStr == null) {
      return true;
    }

    final lastAdTime = DateTime.parse(lastAdTimeStr);
    final now = DateTime.now();

    final difference = now.difference(lastAdTime);
    return difference.inMinutes >= 2;
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

  void _adTimer() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if(isThreeMinutesPassed(prefs.getString('lastAdTime'))){
        final String currentTimestamp = DateTime.now().toIso8601String();
        prefs.setString('lastAdTime', currentTimestamp);
        _loadInterstitialRewardedAd();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {});
              },
              child: FutureBuilder(
                  future: _api.golds(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      List<GoldModel> golds = snapshot.data;
                      return Column(
                        children: [
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors
                                        .yellow, // You can use your kPrimaryColor here
                                  ),
                                  child: Image.asset(
                                    'assets/images/bar_gold.png',
                                    width: 40, // Adjust the width as needed
                                    height: 40, // Adjust the height as needed
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                Text(
                                  'اسعار الذهب',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF124C6C), Color(0xFF2378A8)],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                            height: size.height * 0.09,
                            width: double.infinity,
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'اخر تحديث',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                                Text(
                                  '${convertToString(golds.first.lastUpdate)}',

                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),


                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04,
                              ),
                              child: ListView.builder(
                                itemCount: goldImage.length,
                                itemBuilder: (context, index) {
                                  final goldModel = golds[index];
                                  return Container(
                                    height: size.height*0.19,
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(
                                        top: size.width * 0.03,
                                        left: size.width * 0.01,
                                        right: size.width * 0.01),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          offset: Offset(0, 1),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'شراء',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                        fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${goldModel.price}',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize:
                                                          18, // Set an initial font size
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Column(mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    height: 35,
                                                    goldImage[index],
                                                  ),
                                                  Text(
                                                    text[index],
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'بيع',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${goldModel.sell}',
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  );

                                },
                              ),
                            ),
                          ),






                          // Expanded(
                          //   child: Container(
                          //     margin: EdgeInsets.symmetric(
                          //       horizontal: size.width * 0.04,
                          //     ),
                          //     child: ListView.builder(
                          //       itemCount: goldImage.length,
                          //       itemBuilder: (context, index) {
                          //         final goldModel = golds[index];
                          //         return Container(
                          //           padding: EdgeInsets.all(10),
                          //           margin: EdgeInsets.only(
                          //             top: size.width * 0.03,
                          //             left: size.width * 0.01,
                          //             right: size.width * 0.01,
                          //           ),
                          //           width: double.infinity,
                          //           decoration: BoxDecoration(
                          //             color: Colors.white,
                          //             boxShadow: [
                          //               BoxShadow(
                          //                 color: Colors.grey.withOpacity(0.4),
                          //                 spreadRadius: 1,
                          //                 blurRadius: 2,
                          //                 offset: Offset(0, 1),
                          //               ),
                          //             ],
                          //             borderRadius: BorderRadius.circular(10),
                          //           ),
                          //           child: Column(
                          //             children: [
                          //               Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.spaceBetween,
                          //                 children: [
                          //                   Row(
                          //                     children: [
                          //                       Image.asset(
                          //                         height: 35,
                          //                         goldImage[index],
                          //                       ),
                          //                       Text(
                          //                         text[index],
                          //                         style: TextStyle(
                          //                             fontWeight:
                          //                                 FontWeight.w700,
                          //                             fontSize: 18),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                   Row(
                          //                     children: [
                          //                       Column(
                          //                         children: [
                          //                           Text(
                          //                             'شراء',
                          //                             style: TextStyle(
                          //                               fontSize: 18,
                          //                             ),
                          //                           ),
                          //                           Row(
                          //                             children: [
                          //                               Text(
                          //                                 '${goldModel.price}',
                          //                                 style: TextStyle(
                          //                                   color: Colors.black,
                          //                                   fontSize:
                          //                                   18, // Set an initial font size
                          //                                 ),
                          //                               ),
                          //                             ],
                          //                           ),
                          //                         ],
                          //                       ),
                          //                       SizedBox(width: size.width * 0.03,),
                          //                       Column(
                          //                         children: [
                          //                           Text(
                          //                             'بيع',
                          //                             style: TextStyle(
                          //                               fontSize: 18,
                          //                             ),
                          //                           ),
                          //                           Row(
                          //                             children: [
                          //                               Text(
                          //                                 '${goldModel.sell}',
                          //                                 style: TextStyle(
                          //                                   color: Colors.black,
                          //                                   fontSize: 18,
                          //                                 ),
                          //                               ),
                          //                             ],
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ],
                          //               ),
                          //               SizedBox(
                          //                 height: size.height * 0.03,
                          //               ),
                          //               Row(
                          //                 mainAxisAlignment:
                          //                     MainAxisAlignment.spaceBetween,
                          //                 children: [
                          //                   Text(
                          //                     'اخر تحديث',
                          //                     style: TextStyle(
                          //                         color: Colors.black,
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.w600),
                          //                   ),
                          //                   Text(
                          //                     '${convertToString(goldModel.lastUpdate)}',
                          //                     style: TextStyle(
                          //                         color: Colors.black,
                          //                         fontSize: 18,
                          //                         fontWeight: FontWeight.w600),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ],
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // ),
                        ],
                      );
                    }
                  }),
            ),
          ),
        ));
  }
}

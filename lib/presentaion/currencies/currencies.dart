import 'package:dolar_today/constants/navigator.dart';
import 'package:dolar_today/models/bank_data.dart';
import 'package:dolar_today/presentaion/bank_page/bank_page.dart';
import 'package:dolar_today/utils/date_time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../API/api.dart';
import '../../models/bank.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../service/admob_services.dart';


class Currencies extends StatefulWidget {
  const Currencies({super.key});

  @override
  State<Currencies> createState() => _CurrenciesState();
}

class _CurrenciesState extends State<Currencies> {
  RewardedAd? _rewardedAd;


  @override
  void initState() {
    super.initState();
    _createRewardAd();
  }

  List<String> imagesLogo = [
    'assets/images/black_souq.png',
    'assets/images/bank_alahly.png',
    'assets/images/bank_msr.png',
    'assets/images/cib.png',
    'assets/images/bank_qnb.png',
    'assets/images/bank_CoE.png',
    'assets/images/bank_alex.jpg',
    'assets/images/bank_alkwty.png',
  ];

  bool isLike = false;
  final _api = API();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                });
                _createRewardAd();
              },
              child: FutureBuilder(
                  future: _api.banks(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    } else {
                      BankData? bankData = snapshot.data;
                      if (bankData != null) {
                        return Column(
                          children: [
                            Container(
                              height: size.height * 0.08,
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05),
                              child: Row(
                                //crossAxisAlignment: CrossAxisAlignment.center, // Align children vertically in the middle
                                children: [
                                  SizedBox(
                                    height: size.height * 0.08,
                                    width: size.width * 0.08,
                                    child: SvgPicture.asset(
                                      'assets/images/flag_america.svg',
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * 0.03,
                                  ),
                                  Text(
                                    'دولار امريكي/ USD ',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
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
                                    convertToString(bankData.lastUpdate),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18),
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
                                  itemCount: bankData.banks.length,
                                  itemBuilder: (context, index) {
                                    Bank bank = bankData.banks[index];
                                    return GestureDetector(
                                      onTap: () {
                                        navigateTo(
                                            context,
                                            BankPage(
                                              id: bank.id,
                                            ));
                                      },
                                      child: Container(
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
                                              child: Image.asset(
                                                imagesLogo[index],
                                                height: size.height * 0.02,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'شراء',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${bank.dollarPurchaseRate}',
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
                                                  Text(
                                                    '${bank.name}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w700,
                                                        fontSize: 18,
                                                        height: 2),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        'بيع',
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            '${bank.dollarSellRate}',
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
                                      ),
                                    );

                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return Center(
                          child: Text('يوجد خطأ في الإتصال اتصال بالانترنت'));
                    }
                  }),
            ),
          ),
        ));
  }

  void _createRewardAd() {
    RewardedAd.load(
        adUnitId: AdMobService.rewardAdUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
            onAdLoaded: (ad) => setState(() {
              _rewardedAd = ad;
              if(!AdMobService.isRewardedShowed){
                _showRewardedAd();
              }
              AdMobService.isRewardedShowed = true;
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
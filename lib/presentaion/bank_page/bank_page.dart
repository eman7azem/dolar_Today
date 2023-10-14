import 'dart:async';

import 'package:dolar_today/utils/date_time.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../API/api.dart';
import '../../models/currency.dart';
import '../../models/currency_data.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../service/admob_services.dart';
import '../../utils/flags.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key ,required this.id});
  final id;

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  final _api = API();
  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  bool _isInterstitialAdReady = false;

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

  @override
  void initState() {
    super.initState();
    _createBannerId();
  }

  void _startRepeatingTimer() {
    // Set up a timer to repeat every 10 minutes
    Timer.periodic(Duration(minutes: 3), (timer) {
      _loadInterstitialAd();
    });
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdMobService.interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _interstitialAd = ad;
            _isInterstitialAdReady = true;
            _showInterstitialAd();
          }, onAdFailedToLoad: (LoadAdError error) {

      }
      ),
    );
  }

  void _showInterstitialAd() {
    if (_isInterstitialAdReady) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
        },
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
                },
                child: FutureBuilder(
                    future: _api.bankInformation(widget.id),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else {
                        CurrencyData? currencyData = snapshot.data;
                        if(currencyData != null){
                          return SingleChildScrollView(
                            child: Column(children: [
                              Container(
                                width: double.infinity,
                                height: size.height * 0.55,
                                child: Stack(children: [
                                  Container(
                                    width: double.infinity,
                                    height: size.height * 0.35,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF124C6C),
                                          Color(0xFF2378A8)
                                        ],
                                        begin: Alignment.centerRight,
                                        end: Alignment.centerLeft,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: size.height * 0.03,
                                    child: Container(
                                      width: size.width,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: size.width * 0.04),
                                      child: Row(mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(
                                                right: 10,
                                                top: 5,
                                                left: 3,
                                                bottom: 5),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: kPrimaryColor,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Icon(Icons.arrow_back_ios,
                                                  color: Colors.white),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: size.height * 0.15,
                                    left: size.width * 0.05,
                                    right: size.width * 0.05,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.012,
                                          horizontal: size.width * 0.03),
                                      height: size.height * 0.38,
                                      width: size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 2,
                                            blurRadius: 3,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [

                                          _bannerAd == null ? Container() :
                                          Container(
                                            height: _bannerAd?.size.height.toDouble(),
                                            width: size.width,
                                            child: AdWidget(ad: _bannerAd!),
                                          ),],
                                      ),
                                    ),
                                  ),
                                ]),
                              ),

                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: size.width*0.03),
                                child: pricesWidget(size, currencyData),
                              ),
                              SizedBox(
                                height: size.height * 0.01,
                              ),
                              Column(
                                children: [
                                  Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 5,
                                  ),
                                  hotlineWidget(size, currencyData),
                                  Divider(
                                    color: Colors.grey.shade300,
                                    thickness: 5,
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.03),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'الاسعار تختلف حسب المحافظه والوقت ومحل الصرافة وحتى حسب التفاوض. السعر المعروض هو معدل متوسط نحسبه من اكثر من مكان',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.02,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.03),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: size.width * 0.05),
                                          height: size.height * 0.06,
                                          width: size.width * 0.48,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF062A37),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(25),
                                                  bottomRight: Radius.circular(25))),
                                          child: Text(
                                            'العملة',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white,
                                                fontSize: 24,
                                                height: 2),
                                          ),
                                        ),
                                        Container(
                                          height: size.height * 0.06,
                                          width: size.width * 0.21,
                                          color: Color(0xFF062A37),
                                          child: Center(
                                            child: Text(
                                              'شراء',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  height: 2),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: size.height * 0.06,
                                          width: size.width * 0.21,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF062A37),
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(25),
                                                  bottomLeft: Radius.circular(25))),
                                          child: Center(
                                            child: Text(
                                              'بيع',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  height: 2),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: size.height*0.9,
                                    child: currencies(context, size, currencyData),),
                                  ],
                              ),
                            ]),
                          );
                        }
                        return Center(
                          child: Text('خطأ  في السيرفر',style: TextStyle(fontSize: 18),),
                        );
                      }
                    }),
              ),
            )));
  }

  Widget hotlineWidget(Size size, CurrencyData currencyData) {
    if(widget.id != 1){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'الخط الساخن',
            style: TextStyle(
                color: Colors.black, fontSize: 20),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kPrimaryColor,
            ),
            child: Icon(
              Icons.call,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          Text(
            '${currencyData.bank.hotline}',
            style: TextStyle(
                color: Colors.black, fontSize: 20),
          ),
        ],
      );
    }
    return Container();
  }

  Widget pricesWidget(Size size, CurrencyData currencyData) {
    if(widget.id != 1){
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Text(
            'اخر تحديث',
            style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 20),
          ),
          Text(
            convertToString(currencyData.lastUpdate),
            style: TextStyle(
                color: Colors.black,
                fontSize: 18),
          ),
        ],
      );
    }
    return Row(


      mainAxisAlignment:
      MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'اخر تحديث',
          style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 20),
        ),
        Text(
          convertToString(currencyData.lastUpdate),
          style: TextStyle(
              color: Colors.black,
              fontSize: 18),
        ),      ],
    );
  }

  String getImage() {
    switch(widget.id){
      case 1:
        return imagesLogo[0];
      case 2:
        return imagesLogo[1];
      case 3:
        return imagesLogo[2];
      case 4:
        return imagesLogo[3];
      case 5:
        return imagesLogo[4];
      case 6:
        return imagesLogo[5];
      case 7:
        return imagesLogo[6];
      case 8:
        return imagesLogo[7];
      default:
        return imagesLogo[0];
    }
  }

  void _createBannerId() {
    _bannerAd = BannerAd(
        adUnitId: AdMobService.bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.mediumRectangle,
        listener: AdMobService.bannerAdListener
    )..load();
  }
  Widget currencies(BuildContext context, Size size, CurrencyData currencyData) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
      ),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: size.height * 0.01,
        );
      },
      itemCount: currencyData.currencies.length,
      itemBuilder: (context, index) {
        print("currencies length is ${currencyData.currencies.length}");
        Currency currency = currencyData.currencies[index];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                height: size.height * 0.06,
                width: size.width * 0.48,
                decoration: BoxDecoration(
                    color: Color(0xFF062A37),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: Row(
                  children: [
                    Image.asset(getFlag(currency.name), width: 16),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    Text(
                      '${currency.name}',
                      style: TextStyle(
                          color: Colors.white, fontSize: 16, height: 1),
                    ),
                  ],
                ),
              ),
              Container(
                  height: size.height * 0.06,
                  width: size.width * 0.21,
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                  ),
                  child: Center(
                    child: Text('${currency.purchaseRate}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          fontSize: 18,
                        )),
                  )),
              Container(
                height: size.height * 0.06,
                width: size.width * 0.21,
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25))),
                child: Center(
                  child: Text(
                    '${currency.sellRate}',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
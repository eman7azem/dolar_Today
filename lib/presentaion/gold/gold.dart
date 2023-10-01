import 'package:dolar_today/models/gold.dart';
import 'package:dolar_today/service/admob_services.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../API/api.dart';
import '../../constants/colors.dart';

class Gold extends StatefulWidget {
  const Gold({super.key});

  @override
  State<Gold> createState() => _GoldState();
}

class _GoldState extends State<Gold> {

  BannerAd? _bannerAd;

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
    _createBannerId();
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
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: size.width * 0.04,
                              ),
                              child: ListView.builder(
                                itemCount: goldImage.length + 1,
                                itemBuilder: (context, index) {
                                  if (index == 2) {
                                    return Container(
                                      height: _bannerAd?.size.height.toDouble(),
                                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      margin: EdgeInsets.only(
                                        top: size.width * 0.03,
                                        left: size.width * 0.01,
                                        right: size.width * 0.01,
                                      ),
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
                                      child: _bannerAd == null
                                          ? Container()
                                          : Container(
                                        width: size.width,
                                        height: _bannerAd!.size.height.toDouble(), // Set the height here
                                        child: AdWidget(ad: _bannerAd!),
                                      ),
                                    );
                                  } else {
                                    final goldModel = golds[index > 2 ? index - 1 : index];
                                    return Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(
                                        top: size.width * 0.03,
                                        left: size.width * 0.01,
                                        right: size.width * 0.01,
                                      ),
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                    height: 35,
                                                    goldImage[index > 2 ? index - 1 : index],
                                                  ),
                                                  Text(
                                                    text[index > 2 ? index - 1 : index],
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'ج.م',
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                  Text(
                                                    goldModel.price.toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: size.height*0.03,),
                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'اخر تحديث',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                'منذ ساعه',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ),
          ),
        ));
  }

  void _createBannerId() {
    _bannerAd = BannerAd(
        adUnitId: AdMobService.bannerAdUnitId,
        request: const AdRequest(),
        size: AdSize.mediumRectangle,
        listener: AdMobService.bannerAdListener
    )..load();
  }
}

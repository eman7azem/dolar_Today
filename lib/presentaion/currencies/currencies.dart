import 'package:dolar_today/constants/navigator.dart';
import 'package:dolar_today/models/bank_data.dart';
import 'package:dolar_today/presentaion/bank_page/bank_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../API/api.dart';
import '../../constants/colors.dart';
import '../../models/bank.dart';
import '../../service/admob_services.dart';

class Currencies extends StatefulWidget {
  const Currencies({super.key});

  @override
  State<Currencies> createState() => _CurrenciesState();
}

class _CurrenciesState extends State<Currencies> {

  @override
  void initState() {
    super.initState();
  }
  BannerAd? _bannerAd;

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
                                   'منذ ساعه',
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
                                      Bank bank = bankData.banks[index > 2 ? index - 1 : index];
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
                                                            Icon(
                                                              Icons
                                                                  .arrow_upward_sharp,
                                                              color:
                                                              Color(0xff3ea04d),
                                                            )
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
                                                            Icon(
                                                              Icons
                                                                  .arrow_upward_sharp,
                                                              color:
                                                              Color(0xff3ea04d),
                                                            )
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
                                    }

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
}

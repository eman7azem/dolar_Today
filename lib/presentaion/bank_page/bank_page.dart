import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../API/api.dart';
import '../../models/bank_data.dart';
import '../../models/bank_information.dart';
import '../../models/currency.dart';
import '../../models/currency_data.dart';

class BankPage extends StatefulWidget {
  const BankPage({super.key ,required this.id});
  final id;

  @override
  State<BankPage> createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> {
  final _api = API();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
            child: Scaffold(
                body: FutureBuilder(
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
                          return Column(children: [
                            Container(
                              width: double.infinity,
                              height: size.height * 0.33,
                              child: Stack(children: [
                                Container(
                                  width: double.infinity,
                                  height: size.height * 0.22,
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
                                  // child: Center(
                                  //     child: Text(
                                  //       'Black Market',
                                  //       style: TextStyle(
                                  //           color: Colors.black,
                                  //           fontSize: 20,
                                  //           fontWeight: FontWeight.w700),
                                  //     )),
                                ),
                                Positioned(
                                  top: size.height * 0.03,
                                  child: Container(
                                    width: size.width,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size.width * 0.04),
                                    child: Row(
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
                                    height: size.height * 0.18,
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
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/bank_alahly.png',
                                              width: size.width * 0.09,
                                            ),
                                            SizedBox(
                                              width: size.width * 0.02,
                                            ),
                                            Text(
                                              '${currencyData.bank.name}',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20),
                                            ),
                                            Spacer(),
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
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'سعر البنك',
                                                  style: TextStyle(
                                                      color: Colors.grey.shade700,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  '${currencyData.bankPrice} ج.م',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'اخر تحديث',
                                                  style: TextStyle(
                                                      color: Colors.grey.shade700,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  '${currencyData.lastUpdate}',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'السوق السوداء',
                                                  style: TextStyle(
                                                      color: Colors.grey.shade700,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  '${currencyData.blackPrice} ج.م',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Divider(
                              color: Colors.grey.shade300,
                              thickness: 5,
                            ),
                            Row(
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
                            ),
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
                            currencies(context, size, currencyData),
                            SizedBox(
                              height: size.height * 0.02,
                            )
                          ]);
                        }
                        return Center(
                          child: Text('خطأ  في السيرفر',style: TextStyle(fontSize: 18),),
                        );
                      }
                    }))));
  }
}

currencies(BuildContext context, Size size, CurrencyData currencyData) {
  List<String> currenciesImage = [
    'assets/images/flag_america.svg',
    'assets/images/european-union-flag-circular-17759.svg',
    'assets/images/japan-flag-circular-17764.svg',
    'assets/images/kuwait-flag-circular-17800.svg',
    'assets/images/qatar-flag-circular-17881.svg',
    'assets/images/bahrain-flag-circular-17886.svg',
    'assets/images/australia-flag-circular-17749.svg',
  ];
  return Expanded(
    child: ListView.separated(
      padding: EdgeInsets.symmetric(
        vertical: size.height * 0.01,
      ),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: size.height * 0.01,
        );
      },
      itemCount: currenciesImage.length,
      itemBuilder: (context, index) {
        Currency currency = currencyData.currencies[index];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                height: size.height * 0.06,
                width: size.width * 0.48,
                decoration: BoxDecoration(
                    color: Color(0xFF062A37),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
                child: Row(
                  children: [
                    SvgPicture.asset(currenciesImage[index], width: 16),
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
    ),
  );
}
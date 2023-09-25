import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Bank extends StatefulWidget {
  const Bank({super.key});

  @override
  State<Bank> createState() => _BankState();
}

class _BankState extends State<Bank> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: size.height * 0.31,
                  child: Stack(children: [
                    Container(
                      width: double.infinity,
                      height: size.height * 0.22,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF124C6C), Color(0xFF2378A8)],
                          begin: Alignment.centerRight,
                          end: Alignment.centerLeft,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        'Black Market',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      )),
                    ),
                    Positioned(
                      top: size.height * 0.03,
                      child: Container(
                        width: size.width,
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  right: 10, top: 5, left: 3, bottom: 5),
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
                        height: size.height * 0.16,
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
                                  'البنك الاهلي المصري',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      '30.83 ج.م',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
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
                                      'منذ 5 دقائق',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
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
                                      '34.00 ج.م',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
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
                      style: TextStyle(color: Colors.black, fontSize: 20),
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
                      '19623',
                      style: TextStyle(color: Colors.black, fontSize: 20),
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
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
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
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
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
                currencies(context, size),
                SizedBox(
                  height: size.height * 0.02,
                )
              ],
            ),
          ),
        ));
  }
}

currencies(BuildContext context, Size size) {
  List<String> currenciesImage = [
    'assets/images/flag_america.svg',
    'assets/images/european-union-flag-circular-17759.svg',
    'assets/images/japan-flag-circular-17764.svg',
    'assets/images/kuwait-flag-circular-17800.svg',
    'assets/images/qatar-flag-circular-17881.svg',
    'assets/images/bahrain-flag-circular-17886.svg',
    'assets/images/australia-flag-circular-17749.svg',
  ];

  List<String> currenciesName = [
    'سعر السوق السوداء',
    'البنك الاهلي المصري',
    'بنك مصر',
    'بنك CIB',
    'بنك QNB',
    'البنك المركزي المصري',
    'بنك الاسكندريه',
    'البنك الاهلي المصري',
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
                    SvgPicture.asset(currenciesImage[index], width: 25),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Text(
                      'دولار امريكي USD',
                      style: TextStyle(
                          color: Colors.white, fontSize: 18, height: 2),
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
                    child: Text('30.25',
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
                    '30.99',
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

import 'package:dolar_today/constants/navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/colors.dart';
import '../bank/bank.dart';

class Currencies extends StatefulWidget {
  const Currencies({super.key});

  @override
  State<Currencies> createState() => _CurrenciesState();
}

class _CurrenciesState extends State<Currencies> {
  List<String> imagesLogo = [
    'assets/images/black_souq.png',
    'assets/images/bank_alahly.png',
    'assets/images/bank_msr.png',
    'assets/images/Cib_Logo.svg.png',
    'assets/images/bank_qnb.png',
    'assets/images/bank_CoE.png',
    'assets/images/bank_alex.jpg',
    'assets/images/bank_alkwty.png',
  ];
  List<String> text = [
    'سعر السوق السوداء',
    'البنك الاهلي المصري',
    'بنك مصر',
    'بنك CIB',
    'بنك QNB',
    'البنك المركزي المصري',
    'بنك الاسكندريه',
    'البنك الاهلي المصري',
  ];

  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: Transform.scale(
                scale: 0.8,
                child: SvgPicture.asset(
                  'assets/images/flag_america.svg',
                )),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'دولار امريكي/ USD ',
                  style: TextStyle(color: Colors.black,fontSize: 18),
                ),
                Text(
                  'تحديث 8-مارس-2023-3:23.م',
                  style: TextStyle(color:kPrimaryColor, fontSize: 15),
                ),
              ],
            ),

          ),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF124C6C), Color(0xFF2378A8)],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
                height: size.height * 0.1,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'متوسط السعر',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              'شراء',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '30.5 ج.م',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.03,
                        ),
                        Column(
                          children: [
                            Text(
                              'بيع',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              '31.5 ج.م',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04,
                     ),
                  child: GridView.builder(
                    itemCount: imagesLogo.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // 6 columns
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 2.5, // Adjust this ratio according to your Container's size
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                         navigateTo(context, Bank());
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: size.width * 0.03),
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
                              Expanded(flex: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              '30.5',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize:
                                                    18, // Set an initial font size
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_upward_sharp,
                                              color: Color(0xff3ea04d),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      text[index],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
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
                                              '31.5',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_upward_sharp,
                                              color: Color(0xff3ea04d),
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
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

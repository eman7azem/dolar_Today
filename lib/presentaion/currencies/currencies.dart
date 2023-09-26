import 'package:dolar_today/constants/navigator.dart';
import 'package:dolar_today/models/bank_data.dart';
import 'package:dolar_today/presentaion/bank_page/bank_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../API/api.dart';
import '../../constants/colors.dart';
import '../../models/bank.dart';

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
    'البنك الاهلي الدولي',
  ];

  bool isLike = false;
  final _api = API();

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
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                Text(
                  'تحديث 8-مارس-2023-3:23.م',
                  style: TextStyle(color: kPrimaryColor, fontSize: 15),
                ),
              ],
            ),
          ),
          body: FutureBuilder(
              future: _api.banks(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  BankData bankData=snapshot.data;
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF124C6C), Color(0xFF2378A8)],
                            begin: Alignment.centerRight,
                            end: Alignment.centerLeft,
                          ),
                        ),
                        padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.03),
                        height: size.height * 0.1,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'متوسط السعر',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'شراء',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${bankData.average.purchase} ج.م',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'بيع',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${bankData.average.sell} ج.م',
                                      style: TextStyle(
                                        color: Colors.white,
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
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: size.width * 0.04,
                          ),
                          child: GridView.builder(
                            itemCount: bankData.banks.length,
                            gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1, // 6 columns
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio:
                              2.5, // Adjust this ratio according to your Container's size
                            ),
                            itemBuilder: (context, index) {
                              Bank bank= bankData.banks[index];
                              return GestureDetector(
                                onTap: () {
                                  navigateTo(context, BankPage( id: bank.id,));
                                },
                                child: Container(
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
                                          MainAxisAlignment.spaceBetween,
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
                                                      Icons.arrow_upward_sharp,
                                                      color: Color(0xff3ea04d),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Text(
                                            '${bank.name}',
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
                                                      '${bank.dollarSellRate}',
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
                  );
                }
              }),
        ));
  }
}

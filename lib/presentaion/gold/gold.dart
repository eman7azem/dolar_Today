import 'package:dolar_today/models/gold.dart';
import 'package:dolar_today/service/admob_services.dart';
import 'package:dolar_today/utils/date_time.dart';
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
                                itemCount: goldImage.length,
                                itemBuilder: (context, index) {
                                  final goldModel = golds[index];
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
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
                                            Row(
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
                                                SizedBox(width: size.width * 0.08,),
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
                                          ],
                                        ),
                                        SizedBox(
                                          height: size.height * 0.03,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'اخر تحديث',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            Text(
                                              '${convertToString(goldModel.lastUpdate)}',
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
}

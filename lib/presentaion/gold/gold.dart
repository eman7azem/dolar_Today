import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            leading: Container(
              margin: EdgeInsets.all(5),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
              child: Image.asset(
                'assets/images/bar_gold.png',
              ),
            ),
            title: Text(
              'اسعار الذهب',
              style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 20),
            ),
            elevation: 4,
            // actions: [
            //   GestureDetector(
            //     onTap: () {
            //       _showDialog(context, size);
            //     },
            //     child: Container(
            //       margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
            //       padding: EdgeInsets.symmetric(horizontal: 7),
            //       decoration: BoxDecoration(
            //           color: kPrimaryColor,
            //           borderRadius: BorderRadius.circular(7)),
            //       child: Row(
            //         children: [
            //           Icon(
            //             Icons.calculate_outlined,
            //             color: Colors.black,
            //           ),
            //           SizedBox(
            //             width: 5,
            //           ),
            //           Text(
            //             'حساب المصنعيه',
            //             style: TextStyle(
            //                 color: Colors.black,
            //                 fontWeight: FontWeight.w600,
            //                 fontSize: 20),
            //           )
            //         ],
            //       ),
            //     ),
            //   )
            // ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.04,
                  ),
                  child: GridView.builder(
                    itemCount: goldImage.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // 6 columns
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio:
                          3.1, // Adjust this ratio according to your Container's size
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(top: size.width * 0.03,left: size.width*0.01,right: size.width*0.01),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        '30.5',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize:
                                          20, // Set an initial font size
                                        ),
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
            ],
          ),
        ));
  }

// Future<void> _showDialog(BuildContext context, Size size) async {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Directionality(
//         textDirection: TextDirection.rtl,
//         child: Dialog(
//           insetPadding: EdgeInsets.symmetric(horizontal: size.height*0.02, vertical: 0),
//           shape: RoundedRectangleBorder(
//             // Add this line to set border radius
//             borderRadius:
//                 BorderRadius.circular(10.0), // Set your desired radius
//           ),
//           backgroundColor: Colors.white,
//           child: Container(
//             height: size.height * 0.45,
//             width: double.infinity,
//             padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   icon: Icon(
//                     Icons.close,
//                     color: Colors.grey,
//                   ),
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide: BorderSide(
//                           color: Colors.grey.shade500,
//                           width: 2,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                         borderSide:
//                             BorderSide(color: kPrimaryColor, width: 2.5),
//                       ),
//                       labelText: 'إجمالي المبلغ المدفوع (جنيه مصري)',
//                       labelStyle: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 17,
//                           fontWeight: FontWeight.bold)),
//                   // Rest of your TextFormField...
//                 ),
//                 SizedBox(height: size.height*0.01),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 150,
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade500,
//                                 width: 2,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                               borderSide: BorderSide(
//                                   color: kPrimaryColor, width: 2.5),
//                             ),
//                             labelText: 'إجمالي الوزن بالجرام',
//                             labelStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 17,
//                                 fontWeight: FontWeight.bold)),
//                         // Rest of your TextFormField...
//                       ),
//                     ),
//                     Container(
//                       width: 150,
//                       child: DropdownButtonFormField<String>(
//                         iconSize: 35,
//                         iconEnabledColor: Colors.grey.shade500,
//                         decoration: InputDecoration(
//                           label: Text(
//                             'العيار',
//                             style: TextStyle(
//                               color: Colors.grey.shade500,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: size.height * 0.014,
//                               horizontal: size.width * 0.02),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                               color: Colors.grey.shade500,
//                               width: 2,
//                             ),
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                               color: Colors.grey.shade500,
//                               width: 2,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                             borderSide: BorderSide(
//                               color: kPrimaryColor,
//                               width: 2,
//                             ),
//                           ),
//                         ),
//                         items: [
//                           DropdownMenuItem<String>(
//                             alignment: Alignment.centerRight,
//                             value: 'option1',
//                             child: Text(
//                               '10',
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                           DropdownMenuItem<String>(
//                             alignment: Alignment.centerRight,
//                             value: 'option2',
//                             child: Text(
//                               '14',
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                           DropdownMenuItem<String>(
//                             alignment: Alignment.centerRight,
//                             value: 'option3',
//                             child: Text(
//                               '18',
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                           DropdownMenuItem<String>(
//                             alignment: Alignment.centerRight,
//                             value: 'option4',
//                             child: Text(
//                               '21',
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                           DropdownMenuItem<String>(
//                             alignment: Alignment.centerRight,
//                             value: 'option5',
//                             child: Text(
//                               '24',
//                               style: TextStyle(
//                                 color: Colors.black87,
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ),
//                         ],
//                         onChanged: (value) {
//                           // Handle dropdown value change
//                         },
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'يرجى اختيار العيار';
//                           }
//                           return null; // Return null if validation passes
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: size.height * 0.03),
//                 Center(
//                   child: Container(
//                     width: size.width * 0.5,
//                     height: size.height*0.05,
//                     decoration: ShapeDecoration(
//                       color: kPrimaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'حساب مصنعيه الذهب',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.02),
//                 Container(
//                   width: double.infinity,
//                   height: size.height*0.055,
//                   decoration: ShapeDecoration(
//                     color: kPrimaryColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       'مصنعية 8 جرام ذهب 2560 جنيه مصري',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 20,
//                         fontFamily: 'Ah-moharram-bold',
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }
}

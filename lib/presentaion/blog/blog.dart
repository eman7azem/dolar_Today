import 'package:dolar_today/models/blog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../API/api.dart';
import '../../constants/colors.dart';

class Blog extends StatelessWidget {
  const Blog({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final _api = API();

    return Scaffold(
      appBar: AppBar(
        leading: Container(
            margin: EdgeInsets.all(5),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: kPrimaryColor),
            child: Icon(
              Icons.edit_document,
              color: Colors.white,
            )),

        title: Text(
          'الأخبار',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
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
      body: FutureBuilder(
          future: _api.blogs(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<BlogModel> blogs = snapshot.data;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: size.height * 0.02),
                      itemCount: blogs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                              vertical: size.height * 0.01),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(color: Colors.transparent)),
                          elevation: 15.0, // Set the elevation to 10
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                // ClipRRect(
                                //   borderRadius: BorderRadius.only(
                                //       topRight: Radius.circular(15),
                                //       topLeft: Radius.circular(15)),
                                //   child: Image.asset(
                                //     'assets/images/blog.jpg',
                                //     // Replace with your image path
                                //     fit: BoxFit.cover, // Adjust the image fit
                                //   ),
                                // ),
                                Text(
                                  blogs[index].text,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                                Text(
                                  blogs[index].date,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}

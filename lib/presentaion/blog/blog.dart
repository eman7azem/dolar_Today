import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class Blog extends StatelessWidget {
  const Blog({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: 3,
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
                              Text(
                                'Name of the Day',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

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
                                'Description about the image goes here.',
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
                )
              ],
            ),
          ),
        ));
  }
}

import 'package:dolar_today/models/blog.dart';
import 'package:flutter/material.dart';
import '../../API/api.dart';
import '../../constants/colors.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../service/admob_services.dart';

class Blog extends StatefulWidget {
  const Blog({super.key});

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {

  final _api = API();
  BannerAd? _bannerAd;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                  SizedBox(
                    height: 10,
                  ),
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

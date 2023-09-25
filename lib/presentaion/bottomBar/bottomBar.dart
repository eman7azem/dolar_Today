import 'package:dolar_today/presentaion/blog/blog.dart';
import 'package:dolar_today/presentaion/currencies/currencies.dart';
import 'package:dolar_today/presentaion/gold/gold.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  final List<Widget> screens = [
    Currencies(),
    Gold(),
    Blog(),
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: PageView(
          controller: pageController,
          children: screens,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF124C6C), Color(0xFF2378A8)],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15))),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                gap: 10,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 600),
                tabBackgroundColor: Theme.of(context).primaryColor,
                tabs: [
                  GButton(
                    icon: Icons.attach_money,
                    iconColor: Colors.white,
                    text: 'العملات',
                    iconSize: 30,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ),
                  GButton(
                    iconSize: 30,
                    iconColor: Colors.white,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                    icon: Icons.diamond,
                    text: 'الذهب',
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ),
                  GButton(
                    iconColor: Colors.white,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                    iconSize: 30,
                    icon: Icons.edit_document,
                    text: 'الأخبار',
                    backgroundColor: Colors.white.withOpacity(0.1),
                  ),
                ],
                selectedIndex: currentIndex,
                onTabChange: (index) {
                  setState(() {
                    currentIndex = index;
                    pageController.animateToPage(
                      index,
                      duration: Duration(milliseconds: 200),
                      curve: Curves.ease,
                    );
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../constants/colors.dart';
import '../blog/blog.dart';
import '../currencies/currencies.dart';
import '../gold/gold.dart';

class BottomBar extends StatefulWidget {
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [
        Currencies(),
        Gold(),
        Blog(),

      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.attach_money, color: Colors.white),
          inactiveIcon: Icon(
            Icons.attach_money,
            color: Colors.white,
            size: 30,

          ),
          title: ' العملات',
          activeColorPrimary: Colors.white.withOpacity(0.1),
          activeColorSecondary: Colors.white,
          textStyle: TextStyle(
            color: kPrimaryColor,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.diamond, color: Colors.white),
          inactiveIcon: Icon(
            Icons.diamond,
            color: Colors.white,
            size: 30,
          ),
          title: ' الذهب',

          activeColorPrimary: Colors.white.withOpacity(0.1),
          activeColorSecondary: Colors.white, //           contentPadding: 0,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.edit_document, color: Colors.white),
          inactiveIcon: Icon(
            Icons.edit_document,
            color: Colors.white,
            size: 30,

          ),
          title: ' المدونه',
          activeColorPrimary: Colors.white.withOpacity(0.1),
          activeColorSecondary: Colors.white, //           contentPadding: 0,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w600,
          ),
        ),

      ];
    }

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: PersistentTabView(
        // backgroundColor: Color(0xff222531),
        navBarHeight: 70,
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        // backgroundColor: Color(0xFF0E3850),
        handleAndroidBackButtonPress: true,
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF124C6C), Color(0xFF2378A8)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          // adjustScreenBottomPaddingOnCurve: true,
          borderRadius: BorderRadius.circular(15),
          // colorBehindNavBar: Colors.yellow,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          // curve: Curves.easeInCubic,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          // curve: Curves.easeInCubic,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style7,
      ),
    );
  }
}

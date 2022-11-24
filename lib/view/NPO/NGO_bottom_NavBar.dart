import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_volunter/view/NPO/volunteer_info.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'AddEvent.dart';
import 'NGOMap.dart';
import 'ngo_event_list.dart';
import 'Profile.dart';

class NGOBottomNav extends StatefulWidget {
  const NGOBottomNav({Key? key}) : super(key: key);

  @override
  State<NGOBottomNav> createState() => _NGOBottomNavState();
}

class _NGOBottomNavState extends State<NGOBottomNav> {
  late PersistentTabController _controller;
  List<Widget> _buildScreens() {
    return [
      EventsPage(),
      NGOProfile()
      //EventsPage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [

      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.calendar),
        title: ("My Events"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: ("Profile"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3,
      // Choose the nav bar style with this property.
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_delivery/pages/Home/main_food_page.dart';
import 'package:food_delivery/pages/accounts/account_page.dart';
import 'package:food_delivery/pages/cart/cart_history.dart';
import 'package:food_delivery/utils/constants/color_constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;

  // int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buidScreen() {
    return [
      const MainFoodPage(),
      const Center(
        child: Text("Hello"),
      ),
      const CartHistory(),
      const AccountPage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.archive),
        title: ("History"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person),
        title: ("Account"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: Colors.amberAccent,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buidScreen(),
      items: _navBarItems(),
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
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style2, // Choose the nav bar style with this property.
    );
  }
}

  // List pages = [
  //   const MainFoodPage(),
  //   const Center(
  //     child: Text("Hello"),
  //   ),
  //   const CartHistory(),
  //   const AccountPage()
  // ];

  // void onTapNav(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: pages[_selectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       selectedItemColor: AppColors.mainColor,
  //       unselectedItemColor: Colors.amberAccent,
  //       showSelectedLabels: false,
  //       showUnselectedLabels: false,
  //       selectedFontSize: 0.0,
  //       unselectedFontSize: 0.0,
  //       currentIndex: _selectedIndex,
  //       onTap: onTapNav,
  //       items: const [
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.home_outlined),
  //           label: "Home",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.archive),
  //           label: "History",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.shopping_cart),
  //           label: "Cart",
  //         ),
  //         BottomNavigationBarItem(
  //           icon: Icon(Icons.person),
  //           label: "Profile",
  //         ),
  //       ],
  //     ),
  //   );
  // }





  



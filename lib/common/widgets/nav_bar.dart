import 'package:amazon_clone/account/account_screen.dart';
import 'package:amazon_clone/pages/home_screen.dart';
import 'package:amazon_clone/constants/globals.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  static const String routeName = '/nav-bar';
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _page = 0;
  double navBarWidth = 42;
  double navBarBorderWidth = 2;

  void navigatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    HomeScreen(),
    const Center(
      child: Text('Cart Page'),
    ),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Globals.selectedNavBarColor,
        unselectedItemColor: Globals.unselectedNavBarColor,
        backgroundColor: Globals.bgColor,
        iconSize: 28,
        onTap: navigatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: navBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? Globals.selectedNavBarColor
                        : Globals.bgColor,
                    width: navBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.home_outlined),
            ),
            label: 'Home',
          ),
          // Cart
          BottomNavigationBarItem(
            icon: Container(
              width: navBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? Globals.selectedNavBarColor
                        : Globals.bgColor,
                    width: navBarBorderWidth,
                  ),
                ),
              ),
              child: Badge(
                  badgeStyle: BadgeStyle(
                    elevation: 0,
                    badgeColor: Theme.of(context).primaryColor,
                  ),
                  badgeContent: const Text('3'),
                  child: const Icon(Icons.shopping_cart_outlined)),
            ),
            label: '',
          ),
          // Account
          BottomNavigationBarItem(
            icon: Container(
              width: navBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 2
                        ? Globals.selectedNavBarColor
                        : Globals.bgColor,
                    width: navBarBorderWidth,
                  ),
                ),
              ),
              child: const Icon(Icons.person_outline),
            ),
            label: 'Account',
          )
        ],
      ),
    );
  }
}

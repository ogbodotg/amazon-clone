import 'package:amazon_clone/account/account_screen.dart';
import 'package:amazon_clone/admin/admin_screen.dart';
import 'package:amazon_clone/admin/product_screen.dart';
import 'package:amazon_clone/pages/home_screen.dart';
import 'package:amazon_clone/constants/globals.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class AdminNavBar extends StatefulWidget {
  static const String routeName = '/admin-nav-bar';
  const AdminNavBar({Key? key}) : super(key: key);

  @override
  State<AdminNavBar> createState() => _AdminNavBarState();
}

class _AdminNavBarState extends State<AdminNavBar> {
  int _page = 0;
  double navBarWidth = 42;
  double navBarBorderWidth = 2;

  void navigatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    const Products(),
    const Center(
      child: Text('Analytics'),
    ),
    const Center(
      child: Text('Orders'),
    ),
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
              child: const Icon(Icons.menu),
            ),
            label: 'Products',
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
                  child: const Icon(Icons.analytics_outlined)),
            ),
            label: 'Analytics',
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
              child: const Icon(Icons.list_alt),
            ),
            label: 'Orders',
          )
        ],
      ),
    );
  }
}

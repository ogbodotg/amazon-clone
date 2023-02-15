import 'package:amazon_clone/constants/globals.dart';
import 'package:flutter/material.dart';

class Services {
  static Widget sizedBox({double? h, double? w}) {
    return SizedBox(
      height: h ?? 0,
      width: w ?? 0,
    );
  }

  static PreferredSize CustomAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: Globals.appBarGradient,
          ),
        ),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('Amazoon',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Row(
              children: const [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.notifications_outlined),
                ),
                Icon(Icons.search)
              ],
            ),
          ),
        ]),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    const Icon(Icons.shopping_bag_outlined),
                    Services.sizedBox(w: 5),
                    const Text("Orders")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    const Icon(Icons.store_mall_directory_outlined),
                    Services.sizedBox(w: 5),
                    const Text("Start Selling")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    const Icon(Icons.list_alt_outlined),
                    Services.sizedBox(w: 5),
                    const Text("Wish List")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 4,
                child: Row(
                  children: [
                    const Icon(Icons.logout_outlined),
                    Services.sizedBox(w: 5),
                    const Text("Logout")
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 100),
            color: Colors.grey.shade100,
            elevation: 2,
            // on selected we show the dialog box
            onSelected: (value) {
              // if value 1 show dialog
              if (value == 1) {
                // customer orders
                // if value 2 show dialog
              } else if (value == 2) {
                // become a seller
              } else if (value == 3) {
                // wish list
              } else if (value == 4) {
                // logout
              }
            },
          ),
        ],
      ),
    );
  }

  static PreferredSize CustomAdminAppBar({String? title}) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(50),
      child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: Globals.appBarGradient,
          ),
        ),
        title: Text(title!,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    const Icon(Icons.shopping_bag_outlined),
                    Services.sizedBox(w: 5),
                    const Text("Orders")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: Row(
                  children: [
                    const Icon(Icons.store_mall_directory_outlined),
                    Services.sizedBox(w: 5),
                    const Text("Start Selling")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: Row(
                  children: [
                    const Icon(Icons.list_alt_outlined),
                    Services.sizedBox(w: 5),
                    const Text("Wish List")
                  ],
                ),
              ),
              PopupMenuItem(
                value: 4,
                child: Row(
                  children: [
                    const Icon(Icons.logout_outlined),
                    Services.sizedBox(w: 5),
                    const Text("Logout")
                  ],
                ),
              ),
            ],
            offset: const Offset(0, 100),
            color: Colors.grey.shade100,
            elevation: 2,
            // on selected we show the dialog box
            onSelected: (value) {
              // if value 1 show dialog
              if (value == 1) {
                // customer orders
                // if value 2 show dialog
              } else if (value == 2) {
                // become a seller
              } else if (value == 3) {
                // wish list
              } else if (value == 4) {
                // logout
              }
            },
          ),
        ],
      ),
    );
  }
}

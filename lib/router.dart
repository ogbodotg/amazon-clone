import 'package:amazon_clone/account/delivery_address.dart';
import 'package:amazon_clone/admin/product_screen.dart';
import 'package:amazon_clone/admin/products/add_product_screen.dart';
import 'package:amazon_clone/auth/pages/auth_screen.dart';
import 'package:amazon_clone/models/orders.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/orders/order_details.dart';
import 'package:amazon_clone/pages/cat_deals_screen.dart';
import 'package:amazon_clone/pages/home_screen.dart';
import 'package:amazon_clone/common/widgets/nav_bar.dart';
import 'package:amazon_clone/products/product_details.dart';
import 'package:amazon_clone/search/search_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );
    case CatDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CatDealsScreen(
          category: category,
        ),
      );
    case AddProduct.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProduct(),
      );
    case Products.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddProduct(),
      );
    case NavBar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NavBar(),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case AddressPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressPage(),
      );
    case ProductDetails.routeName:
      var product = routeSettings.arguments as Product;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetails(
          product: product,
        ),
      );
    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;

      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailsScreen(
          order: order,
        ),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text(
                'Unknown route (404): We could not find the page you\'re looking for'),
          ),
        ),
      );
  }
}

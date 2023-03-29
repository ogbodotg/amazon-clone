import 'dart:convert';

import 'package:amazon_clone/constants/config.dart';
import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/utilities.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class APIServices {
  static var client = http.Client();

// get products by categories
  Future<List<Product>> getCategoryProducts(
      {required BuildContext context, required String category}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      var url = Uri.http(
        Config.apiURL,
        Config.products,
      );

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': userProvider.user.token,
      };

      http.Response res = await client.get(
        // Uri.parse('${Config.apiURL}/${Config.products}?category=$category'),
        Uri.parse('$url?category=$category'),
        headers: requestHeaders,
      );

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  // deal of the day
  Future<Product> getDealOfTheDay({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
        productName: '',
        productDescription: '',
        quantity: 0,
        price: 0,
        productImages: [],
        category: '');

    try {
      var url = Uri.http(
        Config.apiURL,
        Config.dealOfTheDay,
      );

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': userProvider.user.token,
      };

      http.Response res = await client.get(
        // Uri.parse('${Config.apiURL}/${Config.products}?category=$category'),
        Uri.parse('$url'),
        headers: requestHeaders,
      );

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            product = Product.fromJson(res.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }

// save delivery address
  void saveDeliveryAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      var url = Uri.http(
        Config.apiURL,
        Config.saveDeliveryAddress,
      );

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': userProvider.user.token,
      };

      http.Response res = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({
          'address': address,
        }),
      );

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            User user = userProvider.user.copyWith(
              address: jsonDecode(res.body)['address'],
            );
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // place new order
  void placeOrder({
    required BuildContext context,
    required String address,
    required totalPrice,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      var url = Uri.http(
        Config.apiURL,
        Config.placeOrder,
      );

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': userProvider.user.token,
      };

      http.Response res = await client.post(
          // Uri.parse('http://$url/'),
          url,
          headers: requestHeaders,
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalPrice,
          }));

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Order placed successfully');
            User user = userProvider.user.copyWith(
              cart: [],
            );
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

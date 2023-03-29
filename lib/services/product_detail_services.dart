import 'dart:convert';

import 'package:amazon_clone/constants/config.dart';
import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/utilities.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailServices {
  static var client = http.Client();

// rate product
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      var url = Uri.http(
        Config.apiURL,
        Config.productRating,
      );

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': userProvider.user.token,
      };

      http.Response res = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({
          'id': product.id,
          'rating': rating,
        }),
      );

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product rating added');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // add product to cart
  void addProductToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      var url = Uri.http(
        Config.apiURL,
        Config.addToCart,
      );

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': userProvider.user.token,
      };

      http.Response res = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // decrease/remove product from cart
  // add product to cart
  void removeProductToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      var url = Uri.http(
        Config.apiURL,
        Config.removeFromCart,
      );

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': userProvider.user.token,
      };

      http.Response res = await client.delete(
        Uri.parse('${url}/${product.id}'),
        headers: requestHeaders,
      );

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            User user =
                userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

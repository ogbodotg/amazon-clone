import 'dart:convert';

import 'package:amazon_clone/constants/config.dart';
import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/utilities.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailServices {
  static var client = http.Client();

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
}

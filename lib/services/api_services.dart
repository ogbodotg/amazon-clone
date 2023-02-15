import 'dart:convert';

import 'package:amazon_clone/constants/config.dart';
import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/utilities.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class APIServices {
  static var client = http.Client();

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
}

import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/admin/product_screen.dart';
import 'package:amazon_clone/constants/config.dart';
import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/utilities.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  static var client = http.Client();

  // publish product
  void publishProduct({
    required BuildContext context,
    required String productName,
    required String productDescription,
    required int price,
    required int quantity,
    required String category,
    required List<File> productImages,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dmackxcfv', 'edxbxzd5');
      List<String> productImageUrls = [];

      for (int i = 0; i < productImages.length; i++) {
        CloudinaryResponse imgRes = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(productImages[i].path, folder: productName),
        );

        productImageUrls.add(imgRes.secureUrl);
      }

      Product product = Product(
        productName: productName,
        productDescription: productDescription,
        quantity: quantity,
        price: price,
        productImages: productImageUrls,
        category: category,
      );

      var url = Uri.http(
        Config.apiURL,
        Config.publishProduct,
      );

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': userProvider.user.token,
      };

      http.Response res = await client.post(
        url,
        headers: requestHeaders,
        body: product.toJson(),
      );

      httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();

            // Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get all products
  Future<List<Product>> getAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];

    try {
      var url = Uri.http(
        Config.apiURL,
        Config.getProducts,
      );

      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth-token': userProvider.user.token,
      };

      http.Response res = await client.get(
        // Uri.parse('http://$url/'),
        url,
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

  // delete product
  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      var url = Uri.http(
        Config.apiURL,
        Config.deleteProduct,
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
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}

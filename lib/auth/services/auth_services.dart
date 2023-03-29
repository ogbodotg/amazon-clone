import 'dart:convert';

import 'package:amazon_clone/pages/home_screen.dart';
import 'package:amazon_clone/common/widgets/nav_bar.dart';
import 'package:amazon_clone/constants/config.dart';
import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/utilities.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static var client = http.Client();

// register user
  void registerUser({
    required String email,
    required String password,
    required name,
    required context,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        isAdmin: false,
        token: '',
        cart: [],
      );
      var url = Uri.http(
        Config.apiURL,
        Config.registerAPI,
      );
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      http.Response response = await client.post(
        url,
        body: user.toJson(),
        headers: requestHeaders,
      );

      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context,
                'Account created successfully. Please proceed to login');
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  // login
  void loginUser({
    required String email,
    required String password,
    required context,
  }) async {
    try {
      var url = Uri.http(
        Config.apiURL,
        Config.loginAPI,
      );
      Map<String, String> requestHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
      };
      http.Response response = await client.post(
        url,
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: requestHeaders,
      );

      httpErrorHandler(
          response: response,
          context: context,
          onSuccess: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false)
                .setUser(response.body);
            await prefs.setString(
                'auth-token', jsonDecode(response.body)['token']);

            Navigator.pushNamedAndRemoveUntil(
                context, NavBar.routeName, (route) => false);
          });
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

// get user data
  void getUserData({
    BuildContext? context,
  }) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('auth-token');

    if (token == null) {
      preferences.setString('auth-token', '');
    }

    var url = Uri.http(
      Config.apiURL,
      Config.verifyToken,
    );
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'auth-token': token!
    };
    var tokenResponse = await client.post(
      url,
      headers: requestHeaders,
    );

    var response = jsonDecode(tokenResponse.body);

    if (response == true) {
      // get user data
      http.Response userRes = await client.get(
        Uri.parse('http://${Config.apiURL}/'),
        headers: requestHeaders,
      );

      var userProvider = Provider.of<UserProvider>(context!, listen: false);
      userProvider.setUser(userRes.body);
    }
  }
}

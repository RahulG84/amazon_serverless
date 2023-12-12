import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/models/user_models.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/widgets/bottom_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/utils.dart';

class AuthService {
  //signUp
  void signupUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String address,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: address,
        type: '',
        token: '',
        cart: [],
      );
      http.Response res = await http.post(
        Uri.parse('$uri/api-signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackPopup(
            context,
            'Account created! Login with the same credentials!',
          );
        },
      );
    } catch (e) {
      showSnackPopup(context, e.toString());
    }
  }

// signIn
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api-signIn'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.restorablePushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackPopup(context, e.toString());
    }
  }

// get user Data
  void getUserData(
    BuildContext context,
  ) async {
    print('Hello Rahul1');
    try {
      print('Hello Rahul2');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      var tokenResp = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        },
      );

      // this response gives us true or false from the above api call
      // with respect to that will fetch the user data from the api call
      // this  tokenResp will give us the valid jwd token that is true or false
      var response = jsonDecode(tokenResp.body);
      print(response.toString());
      print(token);
      if (response == true) {
        var userResp = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        print('Hello Rahul3');
        print('userResp.body${userResp.toString()}');
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResp.body);
      }
      print('Hello Rahul4');
    } catch (e) {
      showSnackPopup(context, e.toString());
    }
  }
}

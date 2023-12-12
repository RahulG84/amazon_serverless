import 'dart:convert';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/models/user_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../provider/user_provider.dart';
import '../../../utils/utils.dart';
import 'package:http/http.dart' as http;

class AddressServices {
  void saveTheUserData({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user = userProvider.user
              .copyWith(address: jsonDecode(res.body)['address']);
          userProvider.setUserFromModel(user);
          showSnackPopup(
              context, 'You are Placed The Order On The Entered Address');
        },
      );
    } catch (e) {
      showSnackPopup(context, e.toString());
    }
  }
}

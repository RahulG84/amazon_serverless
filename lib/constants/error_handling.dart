import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utils/utils.dart';


void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackPopup(context, jsonDecode(response.body)['message']);
      break;
    case 500:
      showSnackPopup(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackPopup(context, response.body);
  }
}

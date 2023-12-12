import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/models/products_models.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../../utils/utils.dart';

class AdminServices {
  void sellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dzpgebwbm', 'iznw5stp');

      List<String> imageUrl = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse resp = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrl.add(resp.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrl,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      // if (res.statusCode == 200) {
      //   // Check if response body is not null before accessing it
      //   if (res.body != null) {
      //     print('Response: ${res.body}');
      //     // Process the response body here
      //   } else {
      //     print('Response body is null.');
      //     // Handle null response case here
      //   }
      // } else {
      //   print('Request failed with status: ${res.statusCode}');
      //   // Handle error scenarios or failed requests
      // }

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackPopup(context, 'Products Added Scussefully!');
          Navigator.pop(context);
        },
      );
    } catch (e) {
      showSnackPopup(context, e.toString());
    }
  }

  // fetch all the sell products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productsList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productsList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackPopup(context, e.toString());
    }
    return productsList;
  }

  // delete the products

  void deleteTheProducts({
    required BuildContext context,
    required Product product,
    required void Function() onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
          showSnackPopup(context, 'Products Deleted Scussefully!');
        },
      );
    } catch (e) {
      showSnackPopup(context, e.toString());
    }
  }
}
// formJson accept string but with the jsondecode it will gives the object so we want string for that we use the formjson and jsonencode
//jsonDecode() jsonDecode is give an object
// JsonEncode(JsonDecode())  jsonEncode is give the string that where we want in the get request in the fetch all the products  converting json object into the string

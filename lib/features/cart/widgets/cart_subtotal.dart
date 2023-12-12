import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubTotal extends StatelessWidget {
  const CartSubTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    int sum = 0;
    user.cart
        .map(
          (e) => sum += e['quantity'] * e['product']['price'] as int,
        )
        .toList();

    return Container(
      padding: const EdgeInsets.all(10.00),
      child: Row(
        children: [
          const Text(
            'SubTotal ',
            style: TextStyle(
              fontSize: 18,
              color: GlobalVariables.blackColor,
            ),
          ),
          Text(
            '\$$sum',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:amazon_clone/features/cart/services/cart_services.dart';
import 'package:amazon_clone/features/product_details/screen/product_details_screen.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/models/products_models.dart';
import 'package:amazon_clone/models/user_models.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';

class CartProduct extends StatefulWidget {
  int index;
  CartProduct({Key? key, required this.index}) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  ProductDetailsServices productDetailsServices = ProductDetailsServices();
  CartServices cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    final cartProduct =
        Provider.of<UserProvider>(context).user.cart[widget.index];
    final product = Product.fromMap(cartProduct['product']);

    void increaseQuantity(Product product) {
      productDetailsServices.addToCart(
        context: context,
        product: product,
      );
    }

    void decreaseQuantity(Product product) {
      cartServices.removeFromCart(
        context: context,
        product: product,
      );
    }

    void navigateToDetailScreen(Product product) {
      Navigator.pushNamed(context, ProductDetails.routeName,
          arguments: product);
    }

    return Column(
      children: [
        InkWell(
          onTap: () => navigateToDetailScreen(product),
          child: Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 7,
            ),
            child: Row(
              children: [
                Image.network(
                  product.images[0],
                  fit: BoxFit.fitWidth,
                  height: 135,
                  width: 135,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        width: 235,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          '\$${product.price}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: const Text('Eligible for FREE Shipping'),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: const Text(
                          'In Stock',
                          style: TextStyle(
                            color: GlobalVariables.tealColor,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(
                left: 10.00,
                bottom: 10.00,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 1.4,
                ),
                borderRadius: BorderRadius.circular(5),
                color: Colors.black12,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => decreaseQuantity(product),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.remove,
                        size: 18,
                      ),
                    ),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 1.5,
                      ),
                      color: GlobalVariables.whiteColor,
                      borderRadius: BorderRadius.circular(0.00),
                    ),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: Text(
                        cartProduct['quantity'].toString(),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => increaseQuantity(product),
                    child: Container(
                      width: 35,
                      height: 32,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.add,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

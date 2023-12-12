import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/starts.dart';
import 'package:amazon_clone/models/products_models.dart';
import 'package:flutter/material.dart';
import '../../product_details/screen/product_details_screen.dart';

class SearchProducts extends StatefulWidget {
  final Product product;
  void Function()? onDetailClick;
  SearchProducts({Key? key, required this.product, required this.onDetailClick})
      : super(key: key);

  @override
  State<SearchProducts> createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onDetailClick,
          child: Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 7,
            ),
            child: Row(
              children: [
                Image.network(
                  widget.product.images[0],
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
                          widget.product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 5, top: 5),
                        child: Stars(
                          rating: 5,
                        ),
                      ),
                      Container(
                        width: 235,
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Text(
                          'INR ${widget.product.price}',
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
      ],
    );
  }
}

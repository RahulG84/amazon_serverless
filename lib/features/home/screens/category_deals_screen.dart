import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screen/product_details_screen.dart';
import 'package:amazon_clone/models/products_models.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class CategoryDealsScreen extends StatefulWidget {
  static const String routeName = '/category_screen';
  String categories;
  CategoryDealsScreen({Key? key, required this.categories}) : super(key: key);

  @override
  State<CategoryDealsScreen> createState() => _CategoryDealsScreenState();
}

class _CategoryDealsScreenState extends State<CategoryDealsScreen> {
  List<Product>? productList;
  HomeServices homeServices = HomeServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllCategoryProducts();
  }

  void fetchAllCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: widget.categories,
    );
    setState(() {
      //print(productList!.map((e) => e.price));
    });
  }

  navigateToProductDetailsScreen(Product product) {
    Navigator.pushNamed(context, ProductDetails.routeName, arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Text(
            widget.categories,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: GlobalVariables.blackColor,
            ),
          ),
        ),
      ),
      body: productList == null
          ? const Loader()
          : Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for ${widget.categories}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 170,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: 15),
                    itemCount: productList!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1.4,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final product = productList![index];
                      return product.images.isEmpty
                          ? const Text('No Data Added')
                          : GestureDetector(
                              onTap: () => navigateToProductDetailsScreen(product),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 130,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(
                                          product.images[0],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: const EdgeInsets.only(
                                      left: 0,
                                      top: 5,
                                      right: 15,
                                    ),
                                    child: Text(
                                      product.name,
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

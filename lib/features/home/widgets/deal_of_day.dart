import 'package:amazon_clone/features/home/screens/Total_deal_of_day.dart';
import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/features/product_details/screen/product_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../../models/products_models.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({Key? key}) : super(key: key);

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {
  List<Product>? productList;
  HomeServices homeServices = HomeServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchALlMobileCategoryProduct();
  }

  fetchALlMobileCategoryProduct() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: 'Essentials',
    );
    setState(() {});
  }

  navigateToProductDetailScreen(Product product) {
    Navigator.pushNamed(context, ProductDetails.routeName, arguments: product);
  }

  navigateToTotalDealOfTheDay() {
    Navigator.pushNamed(context, TotalDealOfTheDay.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Deal Of The Day..',
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  color: GlobalVariables.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {
                  navigateToTotalDealOfTheDay();
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 16,
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.43,
            color: GlobalVariables.backgroundColor,
            child: Card(
              color: GlobalVariables.whiteColor,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:  productList?.length ?? 0,
                //itemCount: productList!.isEmpty ? 0 : productList?.length,
                //itemCount: productList?.length,
                itemBuilder: (context, index) {
                  final dealProduct = productList?[index];
                  return GestureDetector(
                    onTap: () {
                      navigateToProductDetailScreen(dealProduct!);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white60,
                            spreadRadius: 1,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image(
                                fit: BoxFit.fitHeight,
                                // color: Colors.black,
                                image: NetworkImage(
                                  dealProduct!.images[0],
                                ),
                              ),
                            ),
                          ),
                          Text(
                            dealProduct.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'INR ${dealProduct.price.toString()}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

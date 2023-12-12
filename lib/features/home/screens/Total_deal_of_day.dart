import 'package:amazon_clone/features/home/services/home_services.dart';
import 'package:amazon_clone/models/products_models.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../../product_details/screen/product_details_screen.dart';
import '../../search/screens/search_screen.dart';

class TotalDealOfTheDay extends StatefulWidget {
  static const String routeName = '/total_deal_of_day';

  const TotalDealOfTheDay({Key? key}) : super(key: key);

  @override
  State<TotalDealOfTheDay> createState() => _TotalDealOfTheDayState();
}

class _TotalDealOfTheDayState extends State<TotalDealOfTheDay> {
  HomeServices homeServices = HomeServices();
  List<Product>? productList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAllDealOfTheDay();
  }

  void fetchAllDealOfTheDay() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: 'Mobiles',
    );
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  navigateToProductDetailScreen(Product product) {
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                        suffixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ),
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: const InkWell(
                  child: Icon(
                    Icons.mic,
                    color: GlobalVariables.blackColor,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Card(
        color: GlobalVariables.whiteColor,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount:  productList?.length ?? 0,
          itemBuilder: (context, index) {
            final dealProduct = productList![index];
            return GestureDetector(
              onTap: () {
                navigateToProductDetailScreen(dealProduct);
              },
              child: Center(
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 300,
                        width: 250,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image(
                            fit: BoxFit.cover,
                            // color: Colors.black,
                            image: NetworkImage(
                              dealProduct!.images[0],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        dealProduct!.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'INR ${dealProduct!.price.toString()}',
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
              ),
            );
          },
        ),
      ),
    );
  }
}
import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/search/services/search_services.dart';
import 'package:amazon_clone/features/search/widgets/search_product.dart';
import 'package:flutter/material.dart';
import 'package:amazon_clone/models/products_models.dart';

import '../../../constants/global_variables.dart';
import '../../home/widgets/address_box.dart';
import '../../product_details/screen/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search_screen';
  final String searchQuery;
  const SearchScreen({Key? key, required this.searchQuery}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? product;
  SearchServices searchServices = SearchServices();

  navigateToProductDetailsScreen(Product product) {
    Navigator.pushNamed(context, ProductDetails.routeName, arguments: product);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSearchedProducts();
  }

  fetchSearchedProducts() async {
    product = await searchServices.searchProducts(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
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
      body: product == null
          ? const Loader()
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: product!.length,
                    itemBuilder: (context, index) {
                      return SearchProducts(
                        product: product![index],
                        onDetailClick: () {
                          navigateToProductDetailsScreen(product![index]);
                        },
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }
}

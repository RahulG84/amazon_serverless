import 'package:amazon_clone/constants/starts.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/models/products_models.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';
import '../../search/screens/search_screen.dart';

class ProductDetails extends StatefulWidget {
  static const String routeName = '/product-detail-detail-screen';
  final Product product;
  const ProductDetails({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductDetailsServices productDetailsServices = ProductDetailsServices();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  addToCart() {
    productDetailsServices.addToCart(context: context, product: widget.product);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.00, vertical: 6.00),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product!.id as String,
                    style: const TextStyle(
                      fontSize: 14,
                      color: GlobalVariables.blackColor,
                    ),
                  ),
                  Stars(
                    rating: 5,
                    iconSize: 30,
                    initialRating: 3.45,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.product!.name,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: GlobalVariables.blackColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  viewportFraction: 0.95,
                  height: 250,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                ),
                items: widget.product.images.map(
                  (item) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        item,
                        fit: BoxFit.fitHeight,
                        // height: 300,
                      ),
                    );
                  },
                ).toList(),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                color: GlobalVariables.greyBackgroundColor,
                width: double.infinity,
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text(
                    'Deal Price: ',
                    style: TextStyle(
                      fontSize: 20,
                      color: GlobalVariables.blackColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'INR ${widget.product!.price}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: GlobalVariables.redColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: AutofillHints.givenName,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.product.description,
                style: const TextStyle(
                  fontSize: 16,
                  color: GlobalVariables.blackColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                color: GlobalVariables.greyBackgroundColor,
                width: double.infinity,
                height: 10,
              ),
              const SizedBox(
                height: 8,
              ),
              CustomButton(
                onPressed: () {},
                buttonTile: 'Buy Now',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                onPressed: addToCart,
                buttonTile: 'Add to cart',
                backgroundColor: Colors.yellowAccent,
                buttonTitleColor: GlobalVariables.blackColor,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: GlobalVariables.greyBackgroundColor,
                width: double.infinity,
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Rate The Product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: GlobalVariables.blackColor,
                ),
              ),
              Stars(
                rating: 5,
                initialRating: 4.5,
                iconSize: 45,
                onTap: () {},
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

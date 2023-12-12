import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/cart/widgets/cart_product.dart';
import 'package:amazon_clone/features/cart/widgets/cart_subtotal.dart';
import 'package:amazon_clone/features/home/widgets/address_box.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/global_variables.dart';
import '../../search/screens/search_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController? searchTextController = TextEditingController();

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
    searchTextController!.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    int sum = 0;
    user.cart
        .map(
          (e) => sum += e['quantity'] * e['product']['price'] as int,
        )
        .toList();

    void navigateToAddressScreen(String sum) {
      Navigator.pushNamed(context, AddressScreen.routeName, arguments: sum);
    }

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
                      controller: searchTextController,
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
        child: Column(
          children: [
            const AddressBox(),
            const CartSubTotal(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CustomButton(
                onPressed: () => navigateToAddressScreen(sum.toString()),
                buttonTile: 'Proceed To Buy ( ${user.cart.length} items )',
                backgroundColor: GlobalVariables.yellowColor,
                buttonTitleColor: GlobalVariables.blackColor,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: GlobalVariables.blackColor.withOpacity(0.8),
              height: 1,
              margin: const EdgeInsets.symmetric(horizontal: 08.00),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap:
                  true, // it will not take the entire space that is available for the parent widget
              scrollDirection: Axis.vertical,
              itemCount: user.cart.length,
              itemBuilder: (context, index) {
                return CartProduct(index: index);
              },
            )
          ],
        ),
      ),
    );
  }
}

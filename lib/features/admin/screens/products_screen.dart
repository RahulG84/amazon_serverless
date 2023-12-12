import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/loader.dart';
import 'package:amazon_clone/features/account/widgest/single_products.dart';
import 'package:amazon_clone/features/admin/screens/add_products_screen.dart';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/models/products_models.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product>? products;
  AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    products = await adminServices.fetchAllProducts(context);
    setState(() {});
  }

  navigateToAddProductScreen() {
    Navigator.pushNamed(context, AddProductsScreen.routeName);
  }

  void deleteProducts(Product product, int index) {
    adminServices.deleteTheProducts(
      context: context,
      product: product,
      onSuccess: () {
        products?.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return products == null
        ? const Loader()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                itemCount: products!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final productData = products![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: SingleProduct(image: productData.images[0]),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                productData.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: true,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: GlobalVariables.blackColor,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                deleteProducts(productData, index);
                              },
                              icon: const Icon(Icons.delete_outlined),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            'INR ${productData.price.toString()}',
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: navigateToAddProductScreen,
              tooltip: 'Add a Products',
              child: const Icon(
                Icons.add,
                size: 20,
                color: GlobalVariables.blackColor,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}

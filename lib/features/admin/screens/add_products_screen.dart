import 'dart:io';
import 'package:amazon_clone/features/admin/services/admin_services.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/custom_button.dart';
import 'package:amazon_clone/widgets/custom_textfield.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AddProductsScreen extends StatefulWidget {
  static const routeName = '/add-products-screen';
  const AddProductsScreen({Key? key}) : super(key: key);

  @override
  State<AddProductsScreen> createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final _addProductFormKey = GlobalKey<FormState>();

  AdminServices adminServices = AdminServices();

  String category = 'Mobiles';

  static const List<String> productCategoriesList = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
  ];

  List<File> images = [];

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
    print('images.length ${images.length}');
  }

  void sellProducts() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      adminServices.sellProducts(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: double.parse(quantityController.text),
        category: category,
        images: images,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // productNameController.dispose();
    // descriptionController.dispose();
    // priceController.dispose();
    // quantityController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              'Add Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: GlobalVariables.blackColor,
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _addProductFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        options: CarouselOptions(
                          viewportFraction: 1,
                          height: 210,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                        ),
                        items: images.map(
                          (item) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                item,
                                fit: BoxFit.cover,
                                height: double.infinity,
                              ),
                            );
                          },
                        ).toList(),
                      )
                    : InkWell(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: SizedBox(
                            width: double.infinity,
                            height: 150,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open_rounded,
                                  size: 60,
                                  color: GlobalVariables.blackColor,
                                ),
                                Text(
                                  'Select Products Image',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: productNameController,
                  hintText: 'Product Name',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: descriptionController,
                  hintText: 'Description',
                  maxLine: 8,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: priceController,
                  hintText: 'Price',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  controller: quantityController,
                  hintText: 'Quantity',
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: DropdownButton(
                    hint: const Text('Select Category'),
                    value: category,
                    items: productCategoriesList.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(
                          items,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        category = newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(onPressed: sellProducts, buttonTile: 'Sell'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

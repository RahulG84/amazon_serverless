import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';
import '../screens/category_deals_screen.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({Key? key}) : super(key: key);

  void navigateToCategoryDealScreen(BuildContext context, String categories) {
    Navigator.pushNamed(context, CategoryDealsScreen.routeName,
        arguments: categories);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: GlobalVariables.categoryImages.length,
        scrollDirection: Axis.horizontal,
        itemExtent: 75,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => {
              navigateToCategoryDealScreen(
                  context, GlobalVariables.categoryImages[index]['title']!),
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 50,
                      width: 60,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  GlobalVariables.categoryImages[index]['title']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: GlobalVariables.blackColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

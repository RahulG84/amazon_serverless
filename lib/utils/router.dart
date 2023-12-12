import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/features/admin/screens/add_products_screen.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/home/screens/Total_deal_of_day.dart';
import 'package:amazon_clone/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:amazon_clone/features/product_details/screen/product_details_screen.dart';
import 'package:amazon_clone/features/search/screens/search_screen.dart';
import 'package:amazon_clone/models/products_models.dart';
import 'package:amazon_clone/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (context) => const BottomBar(),
      );
    case AddProductsScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const AddProductsScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => CategoryDealsScreen(categories: category),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => SearchScreen(searchQuery: searchQuery),
      );
    case ProductDetails.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        builder: (context) => ProductDetails(product: product),
      );
    case TotalDealOfTheDay.routeName:
      return MaterialPageRoute(
        builder: (context) => const TotalDealOfTheDay(),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => AddressScreen(totalAmount: totalAmount),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Text("Screen Dose Not Exists"),
      );
  }
}

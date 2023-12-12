import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/screens/account_screen.dart';
import 'package:amazon_clone/features/cart/screens/cart_screen.dart';
import 'package:amazon_clone/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../provider/user_provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/initial-home-page';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 50;
  double bottomBarBorderWidth = 5;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> widgetArray = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartLength = Provider.of<UserProvider>(context).user.cart.length;
    return Scaffold(
      body: widgetArray[_page],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 30,
        onTap: updatePage,
        items: [
          //HOME
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: bottomBarBorderWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(Icons.home_outlined,
                  color: _page == 0
                      ? GlobalVariables.blueColor
                      : GlobalVariables.blackColor),
            ),
          ),

          //ACCOUNT
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarBorderWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: _page == 1
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottomBarBorderWidth,
                  ),
                ),
              ),
              child: Icon(Icons.person_outline_outlined,
                  color: _page == 1
                      ? GlobalVariables.blueColor
                      : GlobalVariables.blackColor),
            ),
          ),

          //CART
          BottomNavigationBarItem(
            label: '',
            icon: Container(
                width: bottomBarBorderWidth,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: _page == 2
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: bottomBarBorderWidth,
                    ),
                  ),
                ),
                child: badges.Badge(
                  badgeContent: Text(
                    cartLength.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: GlobalVariables.secondaryColor,
                    elevation: 0,
                    shape: badges.BadgeShape.twitter,
                  ),
                  child: Icon(Icons.shopping_cart_outlined,
                      color: _page == 2
                          ? GlobalVariables.blueColor
                          : GlobalVariables.blackColor),
                )),
          ),
        ],
      ),
    );
  }
}

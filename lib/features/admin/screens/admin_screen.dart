import 'package:amazon_clone/features/admin/screens/products_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 50;
  double bottomBarBorderWidth = 5;

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> widgetArray = [
    const ProductsScreen(),
    const Center(child: Text('Analytics Page')),
    const Center(child: Text('Cart Page')),
  ];

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
          title: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/amazon_in.png',
                    width: 140,
                    height: 70,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'Admin',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: GlobalVariables.blackColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: widgetArray[_page],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 30,
        onTap: updatePage,
        items: [
          //Post
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

          //Analytics
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
              child: Icon(Icons.analytics_outlined,
                  color: _page == 1
                      ? GlobalVariables.blueColor
                      : GlobalVariables.blackColor),
            ),
          ),

          //Order
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
              child: Icon(Icons.all_inbox_outlined,
                  color: _page == 2
                      ? GlobalVariables.blueColor
                      : GlobalVariables.blackColor),
            ),
          ),
        ],
      ),
    );
  }
}

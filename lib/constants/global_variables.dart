import 'package:flutter/material.dart';

// String uri = 'http://10.75.22.236:4000';
String uri = 'https://upset-purse-cod.cyclic.app:4000';
//10.75.22.236

// String uri = 'http://localhost:4000';
class GlobalVariables {
  // COLOR
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundColor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;
  static const blackColor = Colors.black;
  static const blueColor = Colors.blueAccent;
  static const whiteColor = Colors.white;
  static const redColor = Colors.red;
  static const tealColor = Colors.teal;
  static const yellowColor = Colors.yellow;

  static const List<String> carouselImages = [
    'https://images-eu.ssl-images-amazon.com/images/G/31/img21/Wireless/WLA/TS/D37847648_Accessories_savingdays_Jan22_Cat_PC_1500.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img2021/Vday/bwl/English.jpg',
    'https://images-eu.ssl-images-amazon.com/images/G/31/img22/Wireless/AdvantagePrime/BAU/14thJan/D37196025_IN_WL_AdvantageJustforPrime_Jan_Mob_ingress-banner_1242x450.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/Symbol/2020/00NEW/1242_450Banners/PL31_copy._CB432483346_.jpg',
    'https://images-na.ssl-images-amazon.com/images/G/31/img21/shoes/September/SSW/pc-header._CB641971330_.jpg',
  ];

  static const List<Map<String, String>> categoryImages = [
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.jpeg',
    },
    {
      'title': 'Mobiles',
      'image': 'assets/images/mobiles.jpeg',
    },
    {
      'title': 'Essentials',
      'image': 'assets/images/essentials.jpeg',
    },
    {
      'title': 'Appliances',
      'image': 'assets/images/appliances.jpeg',
    },
    {
      'title': 'Books',
      'image': 'assets/images/books.jpeg',
    },
    {
      'title': 'Fashion',
      'image': 'assets/images/fashion.jpeg',
    },
  ];
  static const List<Map<String, String>> dealList = [
    {
      'name': 'Nike',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9D9BF3fLStmwf-TRvBKm3TxcQETcu6O3jpg&usqp=CAU',
      'rate': 'INR : 500.00'
    },
    {
      'name': 'Men-jacket',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGBL5vKGaS6DrLGNyvEr3mDMQrBu2us2z7_g&usqp=CAU',
      'rate': 'INR : 1200.00'
    },
    {
      'name': 'Puma T-shirt',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5sR7D2kTep2vKlKfQ6QlKvdX4_WfQ66WFug&usqp=CAU',
      'rate': 'INR : 1000.00'
    },
    {
      'name': 'Nike',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9D9BF3fLStmwf-TRvBKm3TxcQETcu6O3jpg&usqp=CAU',
      'rate': 'INR : 500.00'
    },
    {
      'name': 'Men-jacket',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGBL5vKGaS6DrLGNyvEr3mDMQrBu2us2z7_g&usqp=CAU',
      'rate': 'INR : 1200.00'
    },
    {
      'name': 'Puma T-shirt',
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ5sR7D2kTep2vKlKfQ6QlKvdX4_WfQ66WFug&usqp=CAU',
      'rate': 'INR : 1000.00'
    },
  ];
}

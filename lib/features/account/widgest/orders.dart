import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/account/widgest/single_products.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final laptopLost = [
    'https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/7974/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/7974/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/7974/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/7974/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/7974/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/205421/pexels-photo-205421.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/7974/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  ];

  final kurtaList = [
    'https://manyavar.scene7.com/is/image/manyavar/I03_0R5A3619%20copy_20-10-2021-20-04:650x900',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvh8lEyzz71VsvoTh49WwAXqCYkXY5G7GNHg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKgwli5nVHBkPjdwhCKOdoM3F6M1VZXy6z2w&usqp=CAU',
    'https://manyavar.scene7.com/is/image/manyavar/I03_0R5A3619%20copy_20-10-2021-20-04:650x900',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvh8lEyzz71VsvoTh49WwAXqCYkXY5G7GNHg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKgwli5nVHBkPjdwhCKOdoM3F6M1VZXy6z2w&usqp=CAU',
    'https://manyavar.scene7.com/is/image/manyavar/I03_0R5A3619%20copy_20-10-2021-20-04:650x900',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvh8lEyzz71VsvoTh49WwAXqCYkXY5G7GNHg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKgwli5nVHBkPjdwhCKOdoM3F6M1VZXy6z2w&usqp=CAU',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                'Yours Orders',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: GlobalVariables.blackColor,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                'See all',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(
            left: 10,
            top: 20,
            right: 0,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: laptopLost.length,
            itemBuilder: (context, index) {
              return SingleProduct(
                image: laptopLost[index],
              );
            },
          ),
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.only(
            left: 10,
            top: 20,
            right: 0,
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: kurtaList.length,
            itemBuilder: (context, index) {
              return SingleProduct(
                image: kurtaList[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

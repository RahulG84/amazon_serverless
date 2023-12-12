import 'package:amazon_clone/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImage extends StatefulWidget {
  const CarouselImage({Key? key}) : super(key: key);

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color(0xff000000),
              spreadRadius: 4,
              blurRadius: 10 //edited
              ),
        ],
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 0.95,
          height: 210,
          enlargeCenterPage: true,
          enlargeStrategy: CenterPageEnlargeStrategy.height,
        ),
        items: GlobalVariables.carouselImages.map(
          (item) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item,
                fit: BoxFit.fitHeight,
                height: 200,
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

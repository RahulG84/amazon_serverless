import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class SingleProduct extends StatelessWidget {
  final String image;
  const SingleProduct({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white60,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FadeInImage(
            width: 180,
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(image),
            fit: BoxFit.contain,
            fadeInDuration: const Duration(seconds: 3),
            fadeInCurve: Curves.easeInOut,
          ),
        ),
      ),
    );
  }
}

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  int rating;
  double initialRating;
  double iconSize;
  void Function()? onTap;

  Stars({
    Key? key,
    required this.rating,
    this.initialRating = 2.67,
    this.iconSize = 0.88,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: initialRating,
      itemBuilder: (context, index) => InkWell(
        onTap: onTap,
        child: const Icon(
          Icons.star,
          color: GlobalVariables.secondaryColor,
        ),
      ),
      itemCount: rating,
      itemSize: iconSize,
      direction: Axis.horizontal,
    );
  }
}

//     RatingBar.builder(
//     initialRating: initialRating,
//     minRating: 1,
//     direction: Axis.horizontal,
//     itemCount: rating,
//     itemBuilder: (context, _) => Icon(
//       Icons.star,
//       color: GlobalVariables.secondaryColor,
//       size: iconSize,
//     ),
//     onRatingUpdate: (double value) {},
//   );
// }

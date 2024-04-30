import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/utils/image_constant.dart';
import 'common_image_view.dart';

class RatingBarWidget extends StatelessWidget {
  final double initialRating;
  final double itemSize;
  final bool ignoreGestures;
  final Function(double)? onRatingChanged;
   const RatingBarWidget(
       { this.onRatingChanged, this.ignoreGestures = false, this.initialRating=0.0,this.itemSize=30});
  @override
  Widget build(BuildContext context) {
    return RatingBar(
      onRatingUpdate: onRatingChanged!,
      ignoreGestures: ignoreGestures,
      ratingWidget: RatingWidget(
        full:  CommonImageView(
          svgPath: ImageConstant.imgStar2,
          height: 20,
          width: 20,
        ),
        half: const Icon(
          FontAwesomeIcons.solidStarHalfStroke,
          color: Colors.orange, // Set your desired color for half stars
        ),
        empty: const Icon(
          FontAwesomeIcons.solidStar,
          color: Colors.grey, // Set your desired color for empty stars
        ),
      ),
      itemSize: itemSize,
      initialRating: initialRating,
      allowHalfRating: true,
      glow: false,
      itemPadding: const EdgeInsets.only(right: 4.0),
    );
  }
}

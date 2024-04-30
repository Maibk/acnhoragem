import 'package:flutter/material.dart';
import '../core/utils/color_constant.dart';
import 'custom_text.dart';

class searchCategoryItem extends StatelessWidget {

  double? imageHeight;
  VoidCallback? ontap;

  searchCategoryItem({this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: ColorConstant.apppWhite,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
      color: ColorConstant.appgreenColor, // Choose the color of the border
        width: 1.0, // Adjust the width of the border
      ),

      ),

      width: 100,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: Expanded(
            child: MyText(
              title: "Featured",
              fontSize: 14,
              center: true,
              customWeight: FontWeight.w300,
            ),
          ),
        ),
      )
    );
  }
}

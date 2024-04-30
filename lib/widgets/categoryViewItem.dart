import 'package:flutter/material.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import 'common_image_view.dart';
import 'custom_text.dart';

class CategoryViewIem extends StatelessWidget {

  double? imageHeight;
  VoidCallback? ontap;

  CategoryViewIem({this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: ColorConstant.apppWhite,
            borderRadius: BorderRadius.circular(5)
        ),
        //  width: getHorizontalSize(120),
        child: Padding(
          padding: getPadding(top:10,left: 5,right: 5,bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonImageView(
                imagePath: ImageConstant.imgImage6,
              ),
              MyText(
                title: "Brake System",
                fontSize: 14,
                customWeight: FontWeight.w400,
              ),
              SizedBox(height: getVerticalSize(5),),
              MyText(
                title: "2.4k Product",
                fontSize: 14,
                customWeight: FontWeight.w400,
                clr: ColorConstant.appgreenColor,
              ),


            ],
          ),
        )
    );
  }
}

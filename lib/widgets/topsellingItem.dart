import 'package:anchorageislamabad/widgets/rating_bar_widget.dart';
import 'package:flutter/material.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import 'common_image_view.dart';
import 'custom_text.dart';

class TopSellingIem extends StatelessWidget {

  double? imageHeight;
  VoidCallback? ontap;
// imagePath: ImageConstant.imgImage74,
  TopSellingIem({this.ontap});

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
            children: [
              CommonImageView(
                imagePath: ImageConstant.imgImage74,
              ),
              MyText(
                title: "Touch screen LCD Monitor",
                fontSize: 10,
                customWeight: FontWeight.w400,
              ),
              SizedBox(height: getVerticalSize(5),),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        MyText(
                          title: "900AED",
                          fontSize: 12,
                          customWeight: FontWeight.w500,
                          clr: ColorConstant.apppinkColor,
                        ),
                        SizedBox(height: getVerticalSize(5),),
                        FittedBox(
                          child: RatingBarWidget(onRatingChanged: (value) {
                          },itemSize: 8,initialRating: 5.0,),
                        ),
                      ],
                    ),
                  ),
                  CommonImageView(
                    svgPath: ImageConstant.addIcon,
                  )
                ],
              ),

            ],
          ),
        )
    );
  }
}

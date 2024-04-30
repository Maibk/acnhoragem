import 'package:anchorageislamabad/widgets/rating_bar_widget.dart';
import 'package:flutter/material.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import 'common_image_view.dart';
import 'custom_text.dart';

class CardListIIem extends StatelessWidget {
 // var controller = Get.find<CheckOutController>();

  double? imageHeight;
  VoidCallback? ontap;

  CardListIIem({this.ontap});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: ColorConstant.apppWhite,
            borderRadius: BorderRadius.circular(5)
        ),
        width: getHorizontalSize(120),
        child: Padding(
          padding: getPadding(top:10,left: 5,right: 5,bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonImageView(
                imagePath: ImageConstant.imgImage74,
                height: 100,
                width: 100,
              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(title: "Touch screen LCD Monitor"),
                  MyText(title: "900 AED",fontSize: 20,clr: ColorConstant.apppinkColor,customWeight: FontWeight.w500,),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      RatingBarWidget(onRatingChanged: (value) {
                      },itemSize: 10,initialRating: 0.0,),
                    ],
                  )
                ],
              )

            ],
          ),
        )
    );
  }

  Widget _incrementButton(int index) {
    return FloatingActionButton(
      child: Icon(Icons.add, color: Colors.black87),
      backgroundColor: Colors.white,
      onPressed: () {
       // controller.incrementItem(index);
      },
    );
  }

  Widget _decrementButton(int index) {
    return FloatingActionButton(
      onPressed: () {
      //  controller.decrementItem(index);
      },
      child: Icon(Icons.remove, color: Colors.black),
      backgroundColor: Colors.white,
    );
  }
}







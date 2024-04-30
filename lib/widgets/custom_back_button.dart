import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../core/utils/responsive.dart';
import '../core/app_export.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import 'common_image_view.dart';

class CustomBackButton extends StatelessWidget {
  CustomBackButton({this.scale, this.color, this.onTap});

  double? scale;
  Color? color;
  Function()? onTap;

  Responsive responsive = Responsive();


  @override
  Widget build(BuildContext context) {
    responsive.setContext(context);
    return GestureDetector(
      onTap: onTap != null? onTap! : (){

        Get.back();

      },
      child:  CommonImageView(
        svgPath: ImageConstant.imgArrowLeft,
        height: getSize(
          26.00,
        ),
        width: getSize(
          26.00,
        ),
        // color: ColorConstant.teal800,
      ),
    );
  }
}

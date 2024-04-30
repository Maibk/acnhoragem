import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../core/app_export.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../common_image_view.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: getPadding(left: 10,right: 10,top: 10,bottom: 10),
            decoration: BoxDecoration(
              color: ColorConstant.apppWhite,
              borderRadius: BorderRadius.circular(10),
            ),
            height: getVerticalSize(60),
            width: getHorizontalSize(280),
            child: Row(
              children: [
                CommonImageView(
                  svgPath: ImageConstant.imgGroup21071,
                ),
                VerticalDivider(
                  color: ColorConstant.appBorderGray, // Set the color of the divider as per your requirement
                  thickness: 1.0, // Set the thickness of the divider
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'North Area Dubai..',
                      hintStyle: TextStyle(
                        color: Colors.black, // Set the color of the hint text
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400  // Set the font size of the hint text
                        // You can add more styling properties as needed
                      ),
                      // Placeholder text
                      // You can customize other properties like hintStyle, contentPadding, etc.
                    ),
        
        
                  ),
                )
        
              ],
            ),
          ),
        ),
      ),
        GestureDetector(
          onTap: (){
           // Get.toNamed(AppRoutes.ProfilePage);
          },
          child: CommonImageView(
            imagePath: ImageConstant.imgRectangle581,
            height: getVerticalSize(60),
            width: getHorizontalSize(60),
          ),
        ),
      ],
    );
  }
}



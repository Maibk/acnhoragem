
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import 'custom_image_view.dart';
import 'custom_text.dart';

class RadioButtonRow  extends StatelessWidget {

  final String? title;
  final VoidCallback? onTap;
  final Widget? prefix;
  final bool? isSuffix;
  final bool? isPrefix;
  final Rx<bool>? ischecked;
  RadioButtonRow({this.title,this.onTap,this.prefix,this.isPrefix=false,this.isSuffix=true,required this.ischecked});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child:Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            title!=null? MyText(
              title: title!,

              customWeight: FontWeight.w500,
              fontSize: 17,
              clr: ColorConstant.appBlack,
            ):Container(),
            const Spacer(),
            Row(
              children: [
                isPrefix! && prefix==null? CustomImageView(svgPath: ImageConstant.cardImg,
                  height: 20,
                  width: 20,
                  color: ColorConstant.apppinkColor,
                  colorfilter:  ColorFilter.mode( ColorConstant.apppinkColor, BlendMode.srcIn),):isPrefix! && prefix!=null?prefix!:const Offstage(),
                isPrefix!?const SizedBox(
                  width: 10,
                ):Container(),
                isSuffix!?const SizedBox(
                  width: 3,
                ):const Offstage(),
                isSuffix! ?
                Obx(() => CustomImageView(svgPath: ischecked!.value==true?ImageConstant.selected:ImageConstant.Unselected,
                  height: 20,
                  width: 20,
                ))
                    :const Offstage()
              ],
            ),



          ],
        ),
      ),
    );
  }
}

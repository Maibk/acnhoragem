import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../core/utils/color_constant.dart';
import 'custom_text.dart';


// ignore: must_be_immutable
class MyAnimatedButtonOutline extends StatelessWidget {
  double? height, width, fontSize, radius, borderWidth;
  String? title, weight;
  Color? bgColor, textColor, borderColor;
  Function? onTap;
  RoundedLoadingButtonController? controller;
  bool? gradient, shadow;

  MyAnimatedButtonOutline({
    Key? key,
    this.height,
    this.textColor,
    this.radius,
    this.fontSize,
    this.weight,
    this.width,
    this.onTap,
    this.title,
    this.bgColor,
    this.controller,
    this.gradient,
    this.shadow,
    this.borderWidth,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 60.0,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: bgColor ?? ColorConstant.whiteA70071,
        borderRadius: BorderRadius.circular(radius ?? 5.0),
        border: Border.all(
          color: borderColor ?? Colors.white,
          width: borderWidth ?? 0.0,
        ),
      ),
      child: RoundedLoadingButton(
        controller: controller!,
        color: Colors.transparent,
        borderRadius: radius ?? 5.0,
        animateOnTap: false,
        onPressed: () {
          if (controller!.currentState != ButtonState.loading) {
            onTap!();
          }
        },
        child: MyText(
          letterSpacing: 2,
          title: title!,
          clr: textColor ?? ColorConstant.whiteA700,
          fontSize: fontSize ?? 18,
        ),
      ),
    );
  }
}

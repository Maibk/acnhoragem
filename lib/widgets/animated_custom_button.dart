import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

import '../core/utils/color_constant.dart';
import 'custom_text.dart';

// ignore: must_be_immutable
class MyAnimatedButton extends StatelessWidget {
  double? height, width, fontSize, radius;
  String? title, weight;
  Color? bgColor, textColor;
  Function? onTap;
  RoundedLoadingButtonController? controller;
  bool? gradient, shadow;

  MyAnimatedButton({
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      controller: controller!,
      height: height ?? 60.0,
      width: width ?? double.infinity,
      color: bgColor ?? ColorConstant.whiteA70071,
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
    );
  }
}

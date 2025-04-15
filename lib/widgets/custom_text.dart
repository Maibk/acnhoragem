import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/utils/color_constant.dart';
import '../theme/app_style.dart';

TextStyle textStyle = AppStyle.txtPoppinsSemiBold16WhiteA700;

class MyText extends StatefulWidget {
  final String title;
  final String? weight;
  final FontWeight? customWeight;
  final double? fontSize, height, letterSpacing;
  final clr;
  final TextOverflow? toverflow;
  final bool? center;
  final bool? alignRight;
  final int? line;
  final bool? under, cut, isMontserrat;
  final List<FontFeature>? fontFeatures;

  MyText(
      {required this.title,
      this.fontSize,
      this.clr,
      this.fontFeatures,
      this.weight,
      this.customWeight,
      this.height,
      this.center,
      this.alignRight,
      this.line,
      this.under,
      this.toverflow,
      this.cut,
      this.isMontserrat,
      this.letterSpacing});

  @override
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      overflow: widget.toverflow == null ? TextOverflow.visible : widget.toverflow,
      maxLines: widget.line,
      textScaleFactor: 1.0,
      style: widget.isMontserrat == true
          ? AppStyle.txtPoppinsSemiBold16WhiteA700.copyWith(
              fontFeatures: widget.fontFeatures,
              height: widget.height,
              decoration: widget.under == true
                  ? TextDecoration.underline
                  : widget.cut == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
              fontSize: widget.fontSize ?? 16.sp,
              color: widget.clr ?? ColorConstant.primaryTextColor,
              fontWeight: widget.customWeight != null
                  ? widget.customWeight
                  : widget.weight == null
                      ? FontWeight.normal
                      : widget.weight == "Bold"
                          ? FontWeight.bold
                          : widget.weight == "Semi Bold"
                              ? FontWeight.w600
                              : widget.weight == "Semi light Bold"
                                  ? FontWeight.w200
                                  : FontWeight.normal)
          : TextStyle(
              fontFamily: 'Poppins',
              height: widget.height,
              letterSpacing: widget.letterSpacing ?? null,
              decoration: widget.under == true
                  ? TextDecoration.underline
                  : widget.cut == true
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
              fontSize: widget.fontSize ?? 16.sp,
              color: widget.clr ?? Colors.black,
              fontWeight: widget.customWeight != null
                  ? widget.customWeight
                  : widget.weight == null
                      ? FontWeight.normal
                      : widget.weight == "Bold"
                          ? FontWeight.bold
                          : widget.weight == "Semi Bold"
                              ? FontWeight.w600
                              : FontWeight.normal),
      textAlign: widget.center == null
          ? widget.alignRight != null
              ? TextAlign.right
              : TextAlign.left
          : widget.center!
              ? TextAlign.center
              : TextAlign.left,
    );
  }
}

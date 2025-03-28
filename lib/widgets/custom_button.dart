import 'package:anchorageislamabad/core/utils/color_constant.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/size_utils.dart';
import 'common.dart';
import 'icons.dart';

class CustomIconButton extends StatelessWidget {
  final ResizableIcon icon;
  final void Function()? onTap;
  final EdgeInsets? padding;
  const CustomIconButton({
    Key? key,
    this.padding,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: IconButton(
          padding: padding,
          icon: Container(
              //   color: AppColor.COLOR_RED1,
              child: buildIcon()),
          onPressed: onTap,
          iconSize: icon.getIconSize,
          // padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ));
  }

  Widget buildIcon() {
    return icon;
  }
}

class AppBarButton extends CustomIconButton {
  final bool isSvg;
  AppBarButton({
    required String icon,
    Color color = Colors.black,
    void Function()? onTap,
    this.isSvg = true,
  }) : super(
          icon: CustomMonoIcon(
            icon: icon,
            color: color,
            isSvg: isSvg,
            size: 20,
          ),
          onTap: onTap,
        );
}

/*
class CustomButton extends StatelessWidget {
  final String text;
  final Color? textColor, bgColor;
  final void Function()? onTap;
  final double fontsize;
  double? radius;
  final EdgeInsets? padding;
  final BorderSide border;
  final bool italic;
  final FontWeight fontWeight;
 // final bool enabled;

  CustomButton({
    this.text = "",
    this.textColor = AppColor.white,
    this.bgColor = AppColor.primary2,//this.enabled=true,
    this.onTap,
    this.radius,
    this.italic = true,
    this.fontsize = AppDimen.FONT_BUTTON,
    this.border = BorderSide.none,
    this.fontWeight = FontWeight.bold,
    this.padding,
  }) {
    radius ??= getRadius(AppDimen.LOGIN_BUTTON_RADIUS);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        border: Border.fromBorderSide(border),
        color: bgColor,
      ),
      child: Material(
        color: AppColor.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding ??
                EdgeInsets.symmetric(vertical: getVerticalSize(AppDimen.BUTTON_VERT_PADDING)),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget get child {
    return CustomText(
      text: text,
      fontColor: textColor,
      fontSize: fontsize,
      textAlign: TextAlign.center,
      fontWeight: fontWeight,
    );
  }
}
*/

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.label,
    this.color,
    required this.onPressed,
    this.enabled,
    this.textColor,
    this.fontSize,
    this.fontWeight,
    this.prefix,
    this.suffix,
    this.height,
    this.borderColor,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.width,
    this.borderRadius = 5,
  }) : super(key: key);

  final String label;
  final Color? color;
  final MainAxisAlignment mainAxisAlignment;
  final Color? textColor;
  final Color? borderColor;
  final bool? enabled;
  final VoidCallback? onPressed;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? prefix;
  final Widget? suffix;
  final double? width;
  final double? height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? getVerticalSize(46),
      width: width ?? double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              disabledBackgroundColor: ColorConstant.antextGrayDark,
              backgroundColor: color ?? Colors.red,
              elevation: 0,
              side: BorderSide(
                width: 0.8,
                color: enabled ?? true ? borderColor ?? Colors.transparent : borderColor?.withOpacity(0.5) ?? Colors.transparent,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              )),
          onPressed: enabled ?? true ? onPressed : null,
          child: prefix != null || suffix != null
              ? Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // Center children horizontally
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        prefix ?? const SizedBox.shrink(),
                        const SizedBox(width: 8),
                        CustomText(
                            text: label,
                            fontColor: textColor ?? Colors.white,
                            fontSize: fontSize ?? 17.sp,
                            fontWeight: fontWeight ?? FontWeight.normal),
                        const SizedBox(width: 8),
                        suffix ?? const SizedBox.shrink(),
                      ]),
                )
              : CustomText(
                  text: label,
                  fontColor: (enabled ?? true ? (textColor ?? Colors.white) : Colors.white),
                  fontSize: fontSize ?? 17.sp,
                  //fontFamily: FontFamily.urbanist,
                  fontWeight: fontWeight ?? FontWeight.normal)),
    );
  }
}

class CircularButton extends StatelessWidget {
  final double diameter;
  final String icon;
  final Color color, bgColor;
  final void Function()? onTap;
  final BorderSide border;
  final double elevation;
  final double ratio;
  final bool isSvg;

  const CircularButton({
    Key? key,
    required this.diameter,
    required this.icon,
    this.bgColor = Colors.white,
    this.elevation = 0,
    this.ratio = 0.4,
    this.border = const BorderSide(width: 0, color: Colors.transparent),
    this.onTap,
    this.color = Colors.black,
    this.isSvg = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
        radius: diameter / 2,
        elevation: elevation,
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor, border: Border.fromBorderSide(border)),
          child: Material(
            color: Colors.transparent,
            child: InkWell(onTap: onTap, child: Center(child: buildChild())),
          ),
        ));
  }

  Widget buildChild() {
    return CustomMonoIcon(
      size: diameter * ratio,
      icon: icon,
      isSvg: isSvg,
      color: color,
    );
  }
}

class CustomButtonBorder extends StatelessWidget {
  const CustomButtonBorder(
      {Key? key,
      required this.label,
      this.color,
      required this.onPressed,
      this.enabled,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.bottomborder = 2,
      this.prefix,
      this.borderColor,
      this.height,
      this.width})
      : super(key: key);

  final String label;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final bool? enabled;
  final VoidCallback onPressed;
  final double? fontSize;
  final double? bottomborder;
  final FontWeight? fontWeight;
  final Widget? prefix;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: enabled ?? true ? onPressed : null,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: height ?? getVerticalSize(46),
            width: width ?? double.infinity,
            decoration: BoxDecoration(
                color: color ?? Colors.white,
                borderRadius: BorderRadius.circular(6),
                border: Border(
                    top: BorderSide(width: 1, color: borderColor ?? Colors.lightBlue),
                    bottom: BorderSide(width: bottomborder ?? 2, color: borderColor ?? Colors.lightBlue),
                    left: BorderSide(width: 1, color: borderColor ?? Colors.lightBlue),
                    right: BorderSide(width: 1, color: borderColor ?? Colors.lightBlue))),
            child: prefix != null
                ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    prefix ?? const SizedBox.shrink(),
                    const SizedBox(width: 8),
                    Center(
                      child: CustomText(
                          text: label,
                          fontColor: (enabled ?? true
                              ? (textColor ?? Colors.lightBlue)
                              : (textColor?.withOpacity(0.5) ?? Colors.lightBlue.withOpacity(0.5))),
                          fontSize: fontSize ?? 16,
                          // fontFamily: FontFamily.urbanist,
                          fontWeight: fontWeight ?? FontWeight.w600),
                    )
                  ])
                : Center(
                    child: CustomText(
                        text: label,
                        fontColor:
                            (enabled ?? true ? (textColor ?? Colors.lightBlue) : (textColor?.withOpacity(0.5) ?? Colors.lightBlue.withOpacity(0.5))),
                        fontSize: fontSize ?? 16, // fontFamily: FontFamily.urbanist,
                        fontWeight: fontWeight ?? FontWeight.w600),
                  )));
  }
}

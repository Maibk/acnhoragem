import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/size_utils.dart';

class AppStyle {
  static TextStyle txtPoppinsSemiBold16WhiteA700 = TextStyle(
    color: ColorConstant.whiteA700,
    fontSize: getFontSize(
      16,
    ),
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
  );

  static TextStyle hintTextStyle = TextStyle(
    color: ColorConstant.appdarktext,
    fontSize: 15,
    // fontFamily: FontFamily.urbanist,
    fontWeight: FontWeight.w400,
  );

  static TextStyle txtSourceSansProRegular16Gray600 = TextStyle(
    color: ColorConstant.gray600,
    fontSize: getFontSize(
      16,
    ),
    fontFamily: 'Source Sans Pro',
    fontWeight: FontWeight.w400,
  );
}

import 'dart:ui';
import 'package:flutter/material.dart';

class ColorConstant {
  ///
  static Color anbtnBlue = fromHex('#123D71');
  static Color anhintTextgray = fromHex('#bababa');
  static Color antextGrayDark = fromHex('#5C5D5E');
  static Color antextlightgray = fromHex('#797979');
  static Color anblueText = fromHex('#1052CB');

  ///
  static Color whiteA700B0 = fromHex('#b0ffffff');
  static Color switcha700 = fromHex('#34C759');

  static Color textfieldborder = fromHex('#E6E6E6');

  static Color gray600 = fromHex('#7c7c7e');

  static Color whiteA700 = fromHex('#ffffff');

  static Color whiteA70071 = fromHex('#71ffffff');

  static Color black900 = fromHex('#000000');

  static const Color yellow90001 = Color(0xfff79219);
  static const Color yellow90002Light = Color(0xfff8cb94);

  static Color hintTextColor = Color(0xff89889B);

  static Color primaryTextColor = fromHex('#000000');

  static Color secondaryTextColor = fromHex('#7c7c7e');
  static Color graybuttontext = fromHex('#979797');
  static Color goingbutton = fromHex('#7C7C7E');

  static Color primaryColor = Color(0xff14684E);
  static Color greyColor = Color(0xff7C7C7E);

  static Color errorColor = Colors.red;

  static Color success = Colors.green;

  static Color blackColor = Colors.black;
  static Color tabBarIndicatorColor = Colors.black;

  static Color backgroundColor = Colors.white;

  static Color appDescriptionTextColor = Color(0xFFA7A7A7);

  //auto app colors

  static Color appBlack = fromHex('#000000');
  static Color appTextGray = fromHex('#A4A4A4');
  static Color appBorderGray = fromHex('#A4A4A4');
  static Color apppinkColor = fromHex('#ED2656');
  static Color apppWhite = fromHex('#FFFFFF');
  static Color appBackgroundColor = fromHex('#FFFFFF');
  static Color appBackgroundgrayColor = fromHex('#f1f1f1');
  static Color appgreenColor = fromHex('#00AE4F');
  static Color pendingColor = fromHex('#ABA000');
  static Color assignedColor = fromHex('#8DC63F');
  static Color appdarktext = fromHex('#6B6B6B');
  static Color appbottombarr = fromHex('#D9D9D9');
  static Color appbottombarrtrans = fromHex('#ededed');
  static Color textgraydark = fromHex('#797979');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

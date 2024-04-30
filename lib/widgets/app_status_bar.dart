import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppStatusBar
{
  static getDefaultStatusBar()
  {
    return SystemUiOverlayStyle(
      statusBarColor: Color(0xffFFFFFF),
     // systemNavigationBarColor: Color(0xffFFFFFF),
      statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: Colors.white70,
    );
  }

  static getTransparentStatusBar()
  {
   return
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
         // systemNavigationBarColor: ColorConstant.whiteA700,
          systemNavigationBarColor: Colors.white70,
          statusBarBrightness: Platform.isIOS ? Brightness.light : Brightness.dark,
          statusBarIconBrightness: Platform.isIOS ? Brightness.light : Brightness.dark);

  }

  static getTransparentLightStatusBar()
  {
   return
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
         // systemNavigationBarColor: ColorConstant.whiteA700,
          systemNavigationBarColor: Colors.white70,
          statusBarBrightness: Platform.isIOS ? Brightness.dark : Brightness.light,
          statusBarIconBrightness: Platform.isIOS ? Brightness.dark : Brightness.light);

  }
}
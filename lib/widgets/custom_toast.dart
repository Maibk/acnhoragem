import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import 'custom_image_view.dart';
import 'custom_text.dart';

class CustomToast {
  showToast(String body, bool error) {
    Fluttertoast.showToast(
        msg: body,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:
            error ? ColorConstant.errorColor : ColorConstant.success,
        textColor: ColorConstant.whiteA700,
        fontSize: 16.0);
  }


  showAppMessages(context,data,{height=150})
  {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
      content: CustomToast().customview(data),
      behavior: SnackBarBehavior.floating,
      backgroundColor: ColorConstant.whiteA700,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      margin: EdgeInsets.only(
          bottom: Platform.isIOS? MediaQuery.of(context).size.height - (height+60): MediaQuery.of(context).size.height - height,
          right: 20,
          left: 20),
    ));
  }

  customview(data) {
    return Container(
      // color: ColorConstant.whiteA700,
      height: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.black,

            child: Container(
              margin: EdgeInsets.all(5),
              child: CustomImageView(
               // imagePath: ImageConstant.imageNotFound,
              ),
            ),
          ),
          MyText(title: data,clr: ColorConstant.primaryTextColor,),
          CustomImageView(
           // imagePath: ImageConstant.imageNotFound,
          ),
        ],
      ),
    );
  }
}

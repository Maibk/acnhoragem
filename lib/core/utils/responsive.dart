import 'package:flutter/material.dart';


class Responsive {
  double? blockSizeHorizontal;
  double? blockSizeVertical;
  double? textRatio;
BuildContext? mContext;


  setContext(context) {
    this.mContext=context;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    textRatio = MediaQuery.of(context).textScaleFactor;
    blockSizeHorizontal = width / 100; // 4
    blockSizeVertical = height / 100; // 6
  }

  double setWidth(val) {
    return blockSizeHorizontal! * val;
  }

  double setHeight(val) {
    return blockSizeVertical! * val;
  }

  double setTextScale(val) {
    return 1.0 * val;
  }

  double setFormLabelWidth() {
    return setWidth(2);
  }

  double setFormLabelHeight() {
    return setHeight(2);
  }


  double setLargeTextSize() {
    return 1.0 * 14;
  }

  double setMediumTextSize() {
    return 1.0 * 12;
  }
  double setSmallTextSize() {
    return 1.0 * 11;
  }
  double setFullWidth(){
    return MediaQuery.of(mContext!).size.width;
  }
}
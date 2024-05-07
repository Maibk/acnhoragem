import 'package:flutter/material.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../custom_image_view.dart';
import '../custom_search_view.dart';

// ignore: must_be_immutable
class AppbarSearchview extends StatelessWidget {
  AppbarSearchview({this.hintText, this.controller, this.margin, this.onSubmitted, this.onChanged, this.isTappable = true});

  String? hintText;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  Function(String)? onSubmitted;
  Function(String)? onChanged;

  bool isTappable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.only(left: 1),
      child: CustomSearchView(
        width: size.width,
        //  isTappable: isTappable,
        focusNode: FocusNode(),
        controller: controller,
        hintText: hintText,
        // onSubmitted: onSubmitted,
        onChanged: onChanged,
        // fontStyle: SearchViewFontStyle.PoppinsRegular17,
        prefix: Container(
          child: CustomImageView(
            imagePath: ImageConstant.imgClose,
          ),
        ),
        prefixConstraints: BoxConstraints(
          maxHeight: getVerticalSize(
            36.00,
          ),
        ),
      ),
    );
  }
}

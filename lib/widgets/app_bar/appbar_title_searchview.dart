import 'package:anchorageislamabad/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../custom_search_view.dart';

// ignore: must_be_immutable
class AppbarTitleSearchview extends StatelessWidget {
  AppbarTitleSearchview({
    Key? key,
    this.hintText,
    this.controller,
    this.margin,
  }) : super(
          key: key,
        );

  String? hintText;

  TextEditingController? controller;

  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: CustomSearchView(
        width: 290.h,
        controller: controller,
        hintText: "msg_north_area_dubai".tr,
      ),
    );
  }
}

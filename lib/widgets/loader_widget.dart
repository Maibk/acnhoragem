import 'package:anchorageislamabad/core/utils/color_constant.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      strokeWidth: 2,
      color: ColorConstant.whiteA700,
    ));
  }
}

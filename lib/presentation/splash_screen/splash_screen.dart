import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../widgets/app_status_bar.dart';
import '../../widgets/common_image_view.dart';
import 'controller/splash_controller.dart';

// ignore_for_file: must_be_immutable
class SplashScreen extends GetWidget<SplashController> {
  const SplashScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppStatusBar.getTransparentStatusBar(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstant.black900,
        body: SafeArea(
          top: false,
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: CommonImageView(
                    imagePath: ImageConstant.imgSplash,
                    width: double.infinity,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

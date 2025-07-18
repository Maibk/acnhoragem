import 'dart:developer';

import 'package:anchorageislamabad/core/utils/size_utils.dart';
import 'package:anchorageislamabad/presentation/reset_screen.dart/controller/reset_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../baseviews/baseview_auth_screen.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/image_constant.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/animated_custom_button.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_radio_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_textfield_new.dart';

//check commit
// ignore_for_file: must_be_immutable
class ResestPassScreen extends GetWidget<ResetController> {
  final args = Get.arguments;
  String? email;
  final selectedOption = RxBool(false);
  ResestPassScreen({Key? key, this.email})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return BaseviewAuthScreen(
      image: true,
      imageShown: ImageConstant.backgroundImage,
      child: Form(
        key: controller.formKey,
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Padding(
              padding: getPadding(left: 10, top: 20, right: 10),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: ColorConstant.whiteA700,
                        )),
                  ),
                  // MyText(title: "Welcome Forgot ",
                  //   clr: ColorConstant.apppinkColor,
                  //   fontSize: 35,
                  // ),
                  Padding(
                    padding: getPadding(top: 100),
                    child: Container(
                      padding: getPadding(left: 10, right: 10),
                      margin: getMargin(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstant.whiteA700,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: getVerticalSize(10),
                          ),
                          Center(
                            child: CommonImageView(
                              imagePath: ImageConstant.appLogo,
                            ),
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          CustomTextField(
                            fieldText: "OTP Code".tr,
                            controller: controller.otpController,
                            isFinal: false,
                            limit: 4,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return HelperFunction.otpvalidate(value!);
                            },
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          CustomTextField(
                            label: Text(
                              "New Password".tr,
                              style: TextStyle(color: ColorConstant.blackColor.withOpacity(0.5), fontSize: 13),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            controller: controller.passwordController,
                            isFinal: false,
                            // keyboardType: TextInputType.visiblePassword,
                            limit: HelperFunction.PASSWORD_VALIDATION,
                            validator: (value) {
                              return HelperFunction.passwordValidate(value!);
                            },
                          ),
                          SizedBox(
                            height: getVerticalSize(20),
                          ),
                          MyAnimatedButton(
                            radius: 15.0,
                            height: getVerticalSize(50),
                            width: getHorizontalSize(400),
                            fontSize: 16,
                            bgColor: ColorConstant.anbtnBlue,
                            controller: controller.btnController,
                            title: "Continue".tr,
                            onTap: () async {
                              print(args);
                              controller.resetPassAPI(context, args);
                            },
                          ),
                          SizedBox(height: getVerticalSize(20)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
}

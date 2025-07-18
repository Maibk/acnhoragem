import 'package:anchorageislamabad/core/utils/size_utils.dart';
import 'package:anchorageislamabad/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../baseviews/baseview_auth_screen.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/image_constant.dart';
import '../../widgets/animated_custom_button.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_textfield_new.dart';
import 'controller/signup_controller.dart';

//check commit
// ignore_for_file: must_be_immutable
class SignUpScreen extends GetWidget<SignUpController> {
  final selectedOption = RxBool(false);
  SignUpScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BaseviewAuthScreen(
      image: true,
      imageShown: ImageConstant.backgroundImage,
      child: Form(
        key: controller.formKey,
        child: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Padding(
              padding: getPadding(top: 100, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    title: "Register",
                    clr: ColorConstant.whiteA700,
                    fontSize: 35,
                  ),
                  SizedBox(
                    height: getVerticalSize(10),
                  ),
                  Container(
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
                        GestureDetector(
                          onTap: () async {
                            await showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (_) => AlertDialog(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                surfaceTintColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                actions: [
                                  Container(
                                      padding: EdgeInsets.all(20),
                                      height: 230.h,
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(10), color: Color(0xffFFFFFF)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Select User Type",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 25,
                                              color: Color(0xff02045C),
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.userTypeContoller.text = "Owner";
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(4),
                                                      color: Color(0xff0072BC),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Owner",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Color(0xffFFFFFF),
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ).paddingSymmetric(vertical: 5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: getHorizontalSize(5),
                                              ),
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    controller.userTypeContoller.text = "Tenant";
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(width: 1, color: ColorConstant.anbtnBlue),
                                                        borderRadius: BorderRadius.circular(4),
                                                        color: ColorConstant.whiteA700),
                                                    child: Center(
                                                      child: Text(
                                                        "Tenant",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: ColorConstant.blackColor,
                                                          fontFamily: 'Poppins',
                                                        ),
                                                      ).paddingSymmetric(vertical: 5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ],
                              ),
                            );
                          },
                          child: TextFormField(
                            enabled: false,
                            controller: controller.userTypeContoller,
                            decoration: InputDecoration(
                              hintText: "Select User type",
                              hintStyle: TextStyle(height: 0.5, fontSize: 16, color: Colors.grey),
                              labelText: "User type",
                              labelStyle: AppStyle.txtSourceSansProRegular16Gray600
                                  .copyWith(fontSize: 15, color: ColorConstant.gray600, fontWeight: FontWeight.w400),
                              contentPadding: EdgeInsets.only(left: 18, right: 10, bottom: 15),
                              errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(width: 1.0, color: Theme.of(context).colorScheme.error)),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(width: 1.0, color: ColorConstant.appBorderGray)),
                              enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(width: 1.0, color: ColorConstant.appBorderGray)),
                              disabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(width: 1.0, color: ColorConstant.appBorderGray)),
                              focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0), borderSide: BorderSide(width: 1.0, color: ColorConstant.appBorderGray)),
                            ),
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: getVerticalSize(5),
                        ),
                        CustomTextField(
                          label: Text(
                            "First Name".tr,
                            style: TextStyle(color: ColorConstant.blackColor.withOpacity(0.5), fontSize: 13),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          controller: controller.firstNameController,
                          isFinal: false,
                          keyboardType: TextInputType.emailAddress,
                          limit: HelperFunction.EMAIL_VALIDATION,
                          validator: (value) {
                            return HelperFunction.validateAlphabetsOnly(value!);
                          },
                        ),
                        SizedBox(
                          height: getVerticalSize(5),
                        ),
                        CustomTextField(
                          label: Text(
                            "Last Name".tr,
                            style: TextStyle(color: ColorConstant.blackColor.withOpacity(0.5), fontSize: 13),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          controller: controller.lastNameController,
                          isFinal: false,
                          keyboardType: TextInputType.emailAddress,
                          limit: HelperFunction.EMAIL_VALIDATION,
                          validator: (value) {
                            return HelperFunction.validateAlphabetsOnly(value!);
                          },
                        ),
                        SizedBox(
                          height: getVerticalSize(5),
                        ),
                        CustomTextField(
                          label: Text(
                            "Present address".tr,
                            style: TextStyle(color: ColorConstant.blackColor.withOpacity(0.5), fontSize: 13),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          controller: controller.presentAddressController,
                          isFinal: false,
                          keyboardType: TextInputType.emailAddress,
                          limit: HelperFunction.EMAIL_VALIDATION,
                          validator: (value) {
                            return HelperFunction.empthyFieldValidator(value!);
                          },
                        ),
                        SizedBox(
                          height: getVerticalSize(5),
                        ),
                        CustomTextField(
                          label: Text(
                            "lbl_email_address".tr,
                            style: TextStyle(color: ColorConstant.blackColor.withOpacity(0.5), fontSize: 13),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          controller: controller.emailController,
                          isFinal: false,
                          keyboardType: TextInputType.emailAddress,
                          limit: HelperFunction.EMAIL_VALIDATION,
                          validator: (value) {
                            return HelperFunction.emailValidate(value!);
                          },
                        ),
                        SizedBox(
                          height: getVerticalSize(5),
                        ),
                        Obx(
                          () => CustomTextField(
                            postPixText: controller.isShowPassword.value == true ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                            sufixIconOnTap: () {
                              controller.isShowPassword.value = HelperFunction.showPassword(controller.isShowPassword.value);
                            },
                            limit: 15,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                            ],
                            label: Text(
                              "lbl_password".tr,
                              style: TextStyle(color: ColorConstant.blackColor.withOpacity(0.5), fontSize: 13),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            controller: controller.passwordController,
                            isFinal: false,
                            keyboardType: TextInputType.visiblePassword,
                            isPassword: controller.isShowPassword.value,
                            validator: (value) {
                              return HelperFunction.passwordValidate(value!);
                            },
                          ),
                        ),
                        SizedBox(
                          height: getVerticalSize(5),
                        ),
                        CustomTextField(
                          label: Text(
                            "Mobile Number".tr,
                            style: TextStyle(color: ColorConstant.blackColor.withOpacity(0.5), fontSize: 13),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          controller: controller.phoneController,
                          isFinal: false,
                          keyboardType: TextInputType.phone,
                          limit: HelperFunction.EMAIL_VALIDATION,
                          validator: (value) {
                            return HelperFunction.validatePakistaniPhoneNumber(value!);
                          },
                        ),
                        SizedBox(
                          height: getVerticalSize(16),
                        ),
                        SizedBox(
                          height: getVerticalSize(16),
                        ),
                        MyAnimatedButton(
                          radius: 15.0,
                          height: getVerticalSize(50),
                          width: getHorizontalSize(400),
                          fontSize: 16,
                          bgColor: ColorConstant.anbtnBlue,
                          controller: controller.btnController,
                          title: "Sign Up".tr,
                          onTap: () async {
                            controller.signupAPI(context);
                          },
                        ),
                        SizedBox(height: getVerticalSize(20)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText(title: "Already have an Account?"),
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: MyText(
                                  title: "Login",
                                  clr: ColorConstant.anbtnBlue,
                                  customWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        SizedBox(height: getVerticalSize(20)),
                      ],
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

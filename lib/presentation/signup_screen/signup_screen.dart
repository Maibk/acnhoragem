import 'package:anchorageislamabad/core/utils/size_utils.dart';
import 'package:anchorageislamabad/theme/app_style.dart';
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
import '../../routes/app_routes.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/animated_custom_button.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_outlined_button.dart';
import '../../widgets/custom_radio_button.dart';
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
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (_context) {
                                return SimpleDialog(
                                  title: const Text("Select User type"),
                                  children: <Widget>[
                                    SimpleDialogOption(
                                      onPressed: () {
                                        controller.userTypeContoller.text = "Owner";
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Owner",
                                      ),
                                    ),
                                    SimpleDialogOption(
                                      onPressed: () {
                                        controller.userTypeContoller.text = "Tenant";
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "Tenant",
                                      ),
                                    ),
                                  ],
                                );
                              },
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
                              contentPadding: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                              errorBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(width: 1.0, color: Theme.of(context).errorColor)),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(width: 1.0, color: ColorConstant.appBorderGray)),
                              enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(width: 1.0, color: ColorConstant.appBorderGray)),
                              disabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(width: 1.0, color: ColorConstant.appBorderGray)),
                              focusedBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(width: 1.0, color: ColorConstant.appBorderGray)),
                            ),
                            style: TextStyle(color: Colors.black, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: getVerticalSize(5),
                        ),
                        CustomTextField(
                          fieldText: "First Name".tr,
                          controller: controller.firstNameController,
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
                          fieldText: "Last Name".tr,
                          controller: controller.lastNameController,
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
                          fieldText: "lbl_email_address".tr,
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
                            postPixText: controller.isShowPassword.value == true
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            sufixIconOnTap: () {
                              controller.isShowPassword.value =
                                  HelperFunction.showPassword(controller.isShowPassword.value);
                            },
                            limit: 15,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(30),
                            ],
                            fieldText: "lbl_password".tr,
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
                          fieldText: "Mobile Number".tr,
                          controller: controller.phoneController,
                          isFinal: false,
                          keyboardType: TextInputType.phone,
                          limit: HelperFunction.EMAIL_VALIDATION,
                          validator: (value) {
                            return HelperFunction.empthyFieldValidator(value!);
                          },
                        ),
                        SizedBox(
                          height: getVerticalSize(16),
                        ),
                        SizedBox(
                          height: getVerticalSize(16),
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       controller.signupAPI(context);
                        //     },
                        //     child: Text("Sunmit")),
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

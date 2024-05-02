import 'package:anchorageislamabad/presentation/splash_screen/controller/splash_controller.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:anchorageislamabad/widgets/custom_textfield_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/animated_custom_button.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_textfield_forms.dart';
import 'controller/myprofile_controller.dart';

class MyprofileScreen extends StatelessWidget {
  MyprofileController controller = Get.put(MyprofileController());
  // const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/background.png'), // Replace 'assets/background_image.jpg' with your image path
            fit: BoxFit.cover, // Adjust as needed
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 100.0,
            backgroundColor: Colors.transparent,
            title: MyText(
              title: "My Profile",
              clr: ColorConstant.whiteA700,
              fontSize: 20,
              customWeight: FontWeight.w500,
            ),
            centerTitle: true,
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(Icons.arrow_back_ios, color: Colors.white)),
            actions: [
              IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () {
                  Get.toNamed(AppRoutes.menuPage);
                },
              ),
            ],
          ),
          body: Padding(
            padding: getPadding(left: 10),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: getPadding(all: 10),
                      child: GetBuilder(
                          init: controller,
                          builder: (context) {
                            if (controller.getProfileModel != null) {
                              return Form(
                                key: controller.formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: ColorConstant.apppWhite,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      width: double.infinity,
                                      padding: getPadding(left: 30, right: 30, top: 20, bottom: 20),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              Container(
                                                height: 150,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: ColorConstant.anbtnBlue,
                                                ),
                                                child: CommonImageView(
                                                  imagePath: ImageConstant.myprofileIcon,
                                                  fit: BoxFit.contain,
                                                ).paddingAll(25),
                                              ),
                                              Positioned(
                                                right: 15,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: ColorConstant.anbtnBlue,
                                                      border: Border.all(width: .5, color: ColorConstant.whiteA700)),
                                                  child: Icon(
                                                    Icons.add,
                                                    color: ColorConstant.whiteA700,
                                                    size: 20,
                                                  ).paddingAll(5),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: getVerticalSize(10),
                                          ),
                                          MyText(
                                              title: controller.getProfileModel?.name ?? " ",
                                              fontSize: 30,
                                              weight: "Bold"),
                                          MyText(
                                            title: controller.getProfileModel?.email ?? "",
                                            clr: ColorConstant.antextlightgray,
                                            fontSize: 15,
                                          ),
                                          SizedBox(
                                            height: getVerticalSize(10),
                                          ),
                                          // MyText(
                                          //   title: "Upload profile",
                                          //   clr: ColorConstant.anblueText,
                                          //   fontSize: 12,
                                          // ),
                                        ],
                                      ),
                                    ).paddingSymmetric(horizontal: 10),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    MyText(
                                      title: "First Name",
                                      fontSize: 16,
                                      clr: ColorConstant.textgraydark,
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    CustomTextFieldForms(
                                      controller: controller.firstNameController,
                                      isFinal: false,
                                      keyboardType: TextInputType.name,
                                      limit: 80,
                                      validator: (value) {
                                        return HelperFunction.fullNameFieldValidator(value!);
                                      },
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    MyText(
                                      title: "Last Name",
                                      fontSize: 16,
                                      clr: ColorConstant.textgraydark,
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    CustomTextFieldForms(
                                      controller: controller.lastNameController,
                                      isFinal: false,
                                      keyboardType: TextInputType.name,
                                      limit: 80,
                                      validator: (value) {
                                        return HelperFunction.empthyFieldValidator(value!);
                                      },
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    MyText(
                                      title: "Email Address",
                                      fontSize: 16,
                                      clr: ColorConstant.textgraydark,
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    CustomTextFieldForms(
                                      enabled: false,
                                      controller: controller.emailController,
                                      isFinal: false,
                                      keyboardType: TextInputType.emailAddress,
                                      limit: 80,
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    MyText(
                                      title: "CNIC",
                                      fontSize: 16,
                                      clr: ColorConstant.textgraydark,
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    CustomTextFieldForms(
                                      controller: controller.cnicController,
                                      isFinal: false,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        TextInputFormatterWithPattern('#####-#######-#'),
                                      ],
                                      limit: 80,
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    MyText(
                                      title: "Present Address",
                                      fontSize: 16,
                                      clr: ColorConstant.textgraydark,
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    CustomTextFieldForms(
                                      controller: controller.presentAddresController,
                                      isFinal: false,
                                      keyboardType: TextInputType.streetAddress,
                                      limit: 80,
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    MyText(
                                      title: "New Password",
                                      fontSize: 16,
                                      clr: ColorConstant.textgraydark,
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    CustomTextFieldForms(
                                      controller: controller.newPassController,
                                      isFinal: false,
                                      keyboardType: TextInputType.streetAddress,
                                      limit: 80,
                                      //  maxLines: 8,
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(16),
                                    ),
                                    MyAnimatedButton(
                                      radius: 15.0,
                                      height: getVerticalSize(60),
                                      width: getHorizontalSize(400),
                                      fontSize: 20,
                                      bgColor: ColorConstant.anbtnBlue,
                                      controller: controller.btnController,
                                      title: "Update".tr,
                                      onTap: () async {
                                        await controller.updateProfile(context);
                                        controller.isResponse ? Get.back() : null;
                                      },
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return Center(child: CircularProgressIndicator.adaptive());
                            }
                          }),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowLeft() {
    Get.back();
  }
}

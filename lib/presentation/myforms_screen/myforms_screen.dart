import 'dart:developer';

import 'package:anchorageislamabad/Shared_prefrences/app_prefrences.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_expensiontile.dart';
import 'controller/myforms_controller.dart';

class MyFormsScreen extends StatefulWidget {
  @override
  State<MyFormsScreen> createState() => _MyFormsScreenState();
}

class _MyFormsScreenState extends State<MyFormsScreen> {
  AppPreferences appPreferences = AppPreferences();

  String role = '';

  @override
  Widget build(BuildContext context) {
    appPreferences.getRole().then((value) {
      role = value;
      setState(() {});
    });
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'), // Replace 'assets/background_image.jpg' with your image path
          fit: BoxFit.cover, // Adjust as needed
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: Colors.transparent,
          title: MyText(
            title: "My Forms",
            clr: ColorConstant.whiteA700,
            fontSize: 20,
            customWeight: FontWeight.w500,
          ),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.homePage);
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.white)),
          actions: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () async {
                Get.toNamed(AppRoutes.menuPage);
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: getPadding(all: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        //height: getVerticalSize(200),
                        color: ColorConstant.apppWhite,
                        padding: getPadding(left: 30, right: 30, top: 20, bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.entryFormsPage, arguments: {"status": "", "id": ""});
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.profileIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Entry Form",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.serventFormsPage, arguments: {"status": "", "id": ""});
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myFormsIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Servant Form",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.vechicleFormsPage, arguments: {"status": "", "id": ""});
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myFormsIcon1,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Vehicle Forms",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getVerticalSize(10),
                      ),
                      MyText(
                        title: "Forms Lists",
                        clr: ColorConstant.whiteA700,
                        fontSize: 20,
                        customWeight: FontWeight.w500,
                      ),
                      Container(
                        //height: getVerticalSize(200),
                        color: ColorConstant.apppWhite,
                        padding: getPadding(left: 30, right: 30, top: 20, bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.formsList, arguments: "Entry Form");
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.profileIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Entry Form",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.formsList, arguments: "Servant Form");
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myFormsIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Servant Form",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.formsList, arguments: "Vehicle Form");
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myFormsIcon1,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Vehicle Forms",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getVerticalSize(10),
                      ),
                      MyText(
                        title: "Application Forms",
                        clr: ColorConstant.blackColor,
                        fontSize: 20,
                        customWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: getVerticalSize(5),
                      ),
                      Container(
                        //height: getVerticalSize(200),
                        color: ColorConstant.apppWhite,
                        padding: getPadding(left: 50, right: 30, top: 20, bottom: 20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (role == "Owner") {
                                            Get.toNamed(AppRoutes.formsList, arguments: "Owner Form");
                                          } else {
                                            Get.toNamed(AppRoutes.formsList, arguments: "Tenant Form");
                                          }
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.profileIcon,
                                          height: 50,
                                          width: 50,
                                        ).paddingOnly(left: 5),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: role == "Owner" ? "Owner Form" : "Tenant Form",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowLeft() {
    Get.back();
  }
}

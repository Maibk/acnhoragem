import 'package:anchorageislamabad/Shared_prefrences/app_prefrences.dart';
import 'package:anchorageislamabad/core/utils/image_constant.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:anchorageislamabad/widgets/common_image_view.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../widgets/custom_dialogue.dart';

class MenuScreen extends StatelessWidget {
  // MenuController controller = Get.put(MenuController());
  // const DiscoverScreen({Key? key}) : super(key: key);

  AppPreferences _appPreferences = AppPreferences();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/menubg.png'), // Replace 'assets/background_image.jpg' with your image path
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
            title: "Menu",
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
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: getPadding(all: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CommonImageView(
                            imagePath: ImageConstant.logo,
                            height: 80,
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: getVerticalSize(25),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Get.toNamed(AppRoutes.myProfilePage);
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(color: ColorConstant.whiteA700)),
                                  child: CommonImageView(
                                    imagePath: "assets/images/menuprofile.png",
                                  ).paddingAll(15),
                                ),
                                SizedBox(
                                  width: getHorizontalSize(20),
                                ),
                                MyText(
                                  title: "My Profile",
                                  clr: ColorConstant.whiteA700,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          Divider(
                            color: ColorConstant.antextlightgray,
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Get.toNamed(AppRoutes.myComplaintsPage);
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(color: ColorConstant.whiteA700)),
                                  child: CommonImageView(
                                    imagePath: "assets/images/menucomplain.png",
                                  ).paddingAll(15),
                                ),
                                SizedBox(
                                  width: getHorizontalSize(20),
                                ),
                                MyText(
                                  title: "My Complaints",
                                  clr: ColorConstant.whiteA700,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          Divider(
                            color: ColorConstant.antextlightgray,
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Get.toNamed(AppRoutes.billsPage);
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(color: ColorConstant.whiteA700)),
                                  child: CommonImageView(
                                    imagePath: "assets/images/menubilldetail.png",
                                  ).paddingAll(15),
                                ),
                                SizedBox(
                                  width: getHorizontalSize(20),
                                ),
                                MyText(
                                  title: "Bill Details",
                                  clr: ColorConstant.whiteA700,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          Divider(
                            color: ColorConstant.antextlightgray,
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Get.toNamed(AppRoutes.propertiesPage);
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(color: ColorConstant.whiteA700)),
                                  child: CommonImageView(
                                    imagePath: "assets/images/menuproperty.png",
                                  ).paddingAll(15),
                                ),
                                SizedBox(
                                  width: getHorizontalSize(20),
                                ),
                                MyText(
                                  title: "My Properties",
                                  clr: ColorConstant.whiteA700,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          Divider(
                            color: ColorConstant.antextlightgray,
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Get.toNamed(AppRoutes.myformsPage);
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(color: ColorConstant.whiteA700)),
                                  child: CommonImageView(
                                    imagePath: "assets/images/menuOnlineform.png",
                                  ).paddingAll(15),
                                ),
                                SizedBox(
                                  width: getHorizontalSize(20),
                                ),
                                MyText(
                                  title: "Online Forms",
                                  clr: ColorConstant.whiteA700,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          Divider(
                            color: ColorConstant.antextlightgray,
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Get.toNamed(AppRoutes.downLoadFormsPage);
                            },
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.transparent,
                                      border: Border.all(color: ColorConstant.whiteA700)),
                                  child: CommonImageView(
                                    imagePath: "assets/images/menudownloadform.png",
                                  ).paddingAll(15),
                                ),
                                SizedBox(
                                  width: getHorizontalSize(20),
                                ),
                                MyText(
                                  title: "Download Forms",
                                  clr: ColorConstant.whiteA700,
                                  fontSize: 18,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          Divider(
                            color: ColorConstant.antextlightgray,
                          ),
                          SizedBox(
                            height: getVerticalSize(5),
                          ),
                          GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (ct) {
                                      return CustomDialogue(
                                        dialogueBoxHeading: 'Logout'.tr,
                                        dialogueBoxText: 'Are you sure want to Logout?'.tr,
                                        actionOnNo: () {
                                          Navigator.pop(ct);
                                        },
                                        actionOnYes: () async {
                                          await _appPreferences.getAppPreferences().isPreferenceReady;
                                          await _appPreferences.clearPreference();

                                          Get.offAllNamed(AppRoutes.loginPage);
                                        },
                                      );
                                    });
                              },
                              child: Container(
                                width: Get.width,
                                decoration: BoxDecoration(
                                    color: ColorConstant.apppWhite, borderRadius: BorderRadius.circular(6)),
                                child: Center(
                                  child: MyText(
                                    title: "Logout",
                                    clr: ColorConstant.anbtnBlue,
                                    fontSize: 18,
                                  ).paddingSymmetric(vertical: 10),
                                ),
                              )),
                          SizedBox(
                            height: getVerticalSize(20),
                          ),
                          SizedBox(
                            height: getVerticalSize(20),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 40)
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

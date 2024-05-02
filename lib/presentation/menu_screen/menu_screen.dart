import 'dart:developer';

import 'package:anchorageislamabad/Shared_prefrences/app_prefrences.dart';
import 'package:anchorageislamabad/core/utils/image_constant.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/data/services/api_exceptions.dart';
import 'package:anchorageislamabad/data/services/base_client.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:anchorageislamabad/widgets/common_image_view.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:anchorageislamabad/widgets/paginations/paged_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../core/utils/utils.dart';
import '../../widgets/custom_dialogue.dart';

class MenuScreen extends StatelessWidget {
  // MenuController controller = Get.put(MenuController());
  // const DiscoverScreen({Key? key}) : super(key: key);

  AppPreferences _appPreferences = AppPreferences();

  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences appPreferences = AppPreferences();
  final GlobalKey<PagedViewState> pageKey = GlobalKey();
  GlobalKey<FormState> formKey = new GlobalKey();

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
          toolbarHeight: 70.0,
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
        body: Container(
          decoration: BoxDecoration(),
          child: Column(
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
                              height: 70,
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
                                      scale: 2,
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
                            Divider(
                              color: ColorConstant.antextlightgray,
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
                                      scale: 2,
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
                            Divider(
                              color: ColorConstant.antextlightgray,
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
                                      scale: 2,
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
                            Divider(
                              color: ColorConstant.antextlightgray,
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
                                      scale: 2,
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
                            Divider(
                              color: ColorConstant.antextlightgray,
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
                                      scale: 2,
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
                            Divider(
                              color: ColorConstant.antextlightgray,
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
                                      scale: 2,
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
                            Divider(
                              color: ColorConstant.antextlightgray,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                launchUrl(
                                  Uri.parse("https://anchorageislamabad.com/about"),
                                );
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
                                      scale: 2,
                                    ).paddingAll(15),
                                  ),
                                  SizedBox(
                                    width: getHorizontalSize(20),
                                  ),
                                  MyText(
                                    title: "About App",
                                    clr: ColorConstant.whiteA700,
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: ColorConstant.antextlightgray,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                launchUrl(
                                  Uri.parse("https://anchorageislamabad.com/terms-and-conditions"),
                                );
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
                                      scale: 2,
                                    ).paddingAll(15),
                                  ),
                                  SizedBox(
                                    width: getHorizontalSize(20),
                                  ),
                                  MyText(
                                    title: "Terms and Conditions",
                                    clr: ColorConstant.whiteA700,
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: ColorConstant.antextlightgray,
                            ),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                launchUrl(
                                  Uri.parse("https://anchorageislamabad.com/privacy-policy"),
                                );
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
                                      scale: 2,
                                    ).paddingAll(15),
                                  ),
                                  SizedBox(
                                    width: getHorizontalSize(20),
                                  ),
                                  MyText(
                                    title: "Privacy Policy",
                                    clr: ColorConstant.whiteA700,
                                    fontSize: 18,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: ColorConstant.antextlightgray,
                            ),
                            GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () async {
                                  await showDialog(
                                      context: context,
                                      builder: (ct) {
                                        return CustomDialogue(
                                          dialogueBoxHeading: 'Delete Account'.tr,
                                          dialogueBoxText: 'Are you sure want to delete your account?'.tr,
                                          actionOnNo: () {
                                            Navigator.pop(ct);
                                          },
                                          actionOnYes: () {
                                            Get.offAllNamed(AppRoutes.loginPage);
                                            Utils.check().then((value) async {
                                              if (value) {
                                                isInternetAvailable.value = true;

                                                apiCallStatus.value = ApiCallStatus.loading;

                                                _appPreferences
                                                    .getAccessToken(prefName: AppPreferences.prefAccessToken)
                                                    .then((token) async {
                                                  await BaseClient.get(headers: {
                                                    'Authorization': "Bearer $token"
                                                  }, "https://anchorageislamabad.com/api/account-delete?user_id=0&is_delete=1",
                                                      onSuccess: (response) {
                                                    log(response.toString());

                                                    return true;
                                                  }, onError: (error) {
                                                    log(error.toString());
                                                    ApiException apiException = error;

                                                    print(apiException.message);

                                                    BaseClient.handleApiError(error);

                                                    apiCallStatus.value = ApiCallStatus.error;

                                                    return false;
                                                  });
                                                });
                                              } else {
                                                isInternetAvailable.value = false;
                                              }
                                            });

                                            return null;
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
                                      title: "Delete Account",
                                      clr: ColorConstant.anbtnBlue,
                                      fontSize: 18,
                                    ).paddingSymmetric(vertical: 10),
                                  ),
                                )).paddingOnly(bottom: 5),
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
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowLeft() {
    Get.back();
  }
}

import 'dart:developer';

import 'package:anchorageislamabad/Shared_prefrences/app_prefrences.dart';
import 'package:anchorageislamabad/core/utils/image_constant.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/data/services/api_exceptions.dart';
import 'package:anchorageislamabad/data/services/base_client.dart';
import 'package:anchorageislamabad/routes/app_routes.dart';
import 'package:anchorageislamabad/widgets/common_image_view.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:anchorageislamabad/widgets/loader_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/size_utils.dart';
import '../../core/utils/utils.dart';
import '../../widgets/custom_dialogue.dart';
import '../home_screen/controller/home_controller.dart';

class MenuScreen extends StatelessWidget {
  AppPreferences _appPreferences = AppPreferences();

  final HomeController controller = Get.put(HomeController());

  RxBool isInternetAvailable = true.obs;
  Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.success.obs;
  AppPreferences appPreferences = AppPreferences();

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
          surfaceTintColor: Colors.transparent,
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
                                        shape: BoxShape.circle, color: Colors.transparent, border: Border.all(color: ColorConstant.whiteA700)),
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
                                if (controller.profileModel?.appFormApproved == 0) {
                                  Utils.showToast(
                                    "Your application form is not approved yet, kindly wait for Approval",
                                    false,
                                  );
                                } else {
                                  Get.toNamed(AppRoutes.myComplaintsPage);
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Colors.transparent, border: Border.all(color: ColorConstant.whiteA700)),
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
                                if (controller.profileModel?.appFormApproved == 0) {
                                  Utils.showToast(
                                    "Your application form is not approved yet, kindly wait for Approval",
                                    false,
                                  );
                                } else {
                                  Get.toNamed(AppRoutes.billsPage);
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Colors.transparent, border: Border.all(color: ColorConstant.whiteA700)),
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
                                Get.toNamed(AppRoutes.propertiesPage, arguments: [
                                  controller.profileModel?.appFormApproved == 0 ? false : true,
                                  controller.profileModel?.userCategory ?? "Owner"
                                ]);
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Colors.transparent, border: Border.all(color: ColorConstant.whiteA700)),
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
                                if (controller.profileModel?.appFormApproved == 0) {
                                  Utils.showToast(
                                    "Your application form is not approved yet, kindly wait for Approval",
                                    false,
                                  );
                                } else {
                                  Get.toNamed(AppRoutes.myformsPage);
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Colors.transparent, border: Border.all(color: ColorConstant.whiteA700)),
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
                                if (controller.profileModel?.appFormApproved == 0) {
                                  Utils.showToast(
                                    "Your application form is not approved yet, kindly wait for Approval",
                                    false,
                                  );
                                } else {
                                  Get.toNamed(AppRoutes.downLoadFormsPage);
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle, color: Colors.transparent, border: Border.all(color: ColorConstant.whiteA700)),
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
                                        shape: BoxShape.circle, color: Colors.transparent, border: Border.all(color: ColorConstant.whiteA700)),
                                    child: CommonImageView(
                                      imagePath: "assets/images/About-App.png",
                                      scale: 20,
                                    ).paddingAll(10),
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
                                        shape: BoxShape.circle, color: Colors.transparent, border: Border.all(color: ColorConstant.whiteA700)),
                                    child: CommonImageView(
                                      imagePath: "assets/images/Terms & Conditions.png",
                                      scale: 20,
                                    ).paddingAll(10),
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
                                        shape: BoxShape.circle, color: Colors.transparent, border: Border.all(color: ColorConstant.whiteA700)),
                                    child: CommonImageView(
                                      imagePath: "assets/images/Privacy-Policy.png",
                                      scale: 20,
                                    ).paddingAll(10),
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

                                                _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
                                                  await BaseClient.get(
                                                      headers: {'Authorization': "Bearer $token"},
                                                      "https://anchorageislamabad.com/api/account-delete?user_id=0&is_delete=1",
                                                      onSuccess: (response) {
                                                    Get.offAllNamed(AppRoutes.loginPage);
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
                                  decoration: BoxDecoration(color: ColorConstant.apppWhite, borderRadius: BorderRadius.circular(6)),
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
                                            Utils.check().then((value) async {
                                              if (value) {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Loader();
                                                  },
                                                );
                                                isInternetAvailable.value = true;

                                                apiCallStatus.value = ApiCallStatus.loading;

                                                _appPreferences.getAccessToken(prefName: AppPreferences.prefAccessToken).then((token) async {
                                                  await BaseClient.get(headers: {'Authorization': "Bearer $token"}, Constants.logout,
                                                      onSuccess: (response) {
                                                    Get.close(1);
                                                    Utils.showToast("Logout Successfully", false);
                                                    Get.offAllNamed(AppRoutes.loginPage);
                                                    log(response.toString());
                                                    _appPreferences.getAppPreferences().isPreferenceReady;
                                                    _appPreferences.clearPreference();

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
                                  decoration: BoxDecoration(color: ColorConstant.apppWhite, borderRadius: BorderRadius.circular(6)),
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

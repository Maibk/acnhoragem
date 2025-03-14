import 'dart:developer';
import 'package:anchorageislamabad/Shared_prefrences/app_prefrences.dart';
import 'package:anchorageislamabad/core/utils/image_constant.dart';
import 'package:anchorageislamabad/main.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../core/utils/utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_expensiontile.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());

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
        body: Column(
          children: [
            CustomAppBar(
              title: MyText(
                title: "Home",
                clr: ColorConstant.whiteA700,
                fontSize: 20,
                customWeight: FontWeight.w500,
              ),
              centerTitle: true,
              // leading: Icon(Icons.arrow_back_ios),
              trailing: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.menuPage);
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: getPadding(all: 10),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstant.apppWhite,
                        ),
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
                                          Get.toNamed(AppRoutes.myProfilePage);
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
                                        title: "My Profile",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 11,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
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
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myComplaintIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "My Complaints",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 11,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
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
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myBillsIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Bills Details",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 11,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.propertiesPage,
                                              arguments: controller.profileModel?.appFormApproved == 0 ? false : true);
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.mypropertiesIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "My Properties",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 11,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.myformsPage);
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myOnlineIcon,
                                          height: 50,
                                          width: 51,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Online Forms",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 11,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.downLoadFormsPage);
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myDownloadIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Download Forms",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 11,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getVerticalSize(10),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
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
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Application Forms",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 11,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getVerticalSize(20),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: MyText(
                            title: "Quick View",
                            fontSize: 16.sp,
                            clr: ColorConstant.whiteA700,
                          )),
                      SizedBox(
                        height: getVerticalSize(10),
                      ),
                      GetBuilder(
                          init: controller,
                          builder: (context) {
                            return CustomExpansionTile(
                              ontap: () {
                                log("message");
                              },
                              leading: CommonImageView(
                                imagePath: ImageConstant.homeExpicon,
                              ),
                              title: MyText(
                                title: 'My Profile',
                                clr: ColorConstant.antextlightgray,
                                fontSize: 14,
                              ),
                              subtitle: MyText(
                                title: 'Update and modify your photo',
                                clr: ColorConstant.antextlightgray,
                                fontSize: 12,
                              ),
                              children: controller.profileModel != null
                                  ? <Widget>[
                                      ListTile(
                                        title: Text("Name : ${controller.profileModel!.name}"),
                                      ),
                                      ListTile(
                                        title: Text("Email : ${controller.profileModel!.email}"),
                                      ),
                                      ListTile(
                                        title: Text("CNIC : ${controller.profileModel!.cnic}"),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.myProfilePage);
                                        },
                                        child: Center(
                                          child: MyText(
                                            title: "View More",
                                            fontSize: 16,
                                            clr: ColorConstant.antextGrayDark,
                                            customWeight: FontWeight.bold,
                                            under: true,
                                          ),
                                        ),
                                      ),
                                    ]
                                  : [CircularProgressIndicator.adaptive()],
                            );
                          }),
                      SizedBox(
                        height: getVerticalSize(10),
                      ),
                      GetBuilder(
                          init: controller,
                          builder: (context) {
                            return CustomExpansionTile(
                              leading: CommonImageView(
                                imagePath: ImageConstant.homeExpicon1,
                              ),
                              title: MyText(
                                title: 'My Bills',
                                clr: ColorConstant.antextlightgray,
                                fontSize: 14,
                              ),
                              subtitle: MyText(
                                title: 'Update and modify your bills details',
                                clr: ColorConstant.antextlightgray,
                                fontSize: 12,
                              ),
                              children: controller.bills != null
                                  ? <Widget>[
                                      if (controller.bills?.data?.isNotEmpty == true)
                                        Container(
                                          child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: controller.bills!.data!.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(AppRoutes.billsPage);
                                                },
                                                child: ListTile(
                                                    title: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text("Date : ${controller.bills!.data![index].billMonth}"),
                                                    Text("Amount :${controller.bills!.data![index].beforeDueDateAmount} ")
                                                  ],
                                                )),
                                              );
                                            },
                                          ),
                                        ),
                                      InkWell(
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
                                        child: Center(
                                          child: MyText(
                                            title: "View More",
                                            fontSize: 16,
                                            clr: ColorConstant.antextGrayDark,
                                            customWeight: FontWeight.bold,
                                            under: true,
                                          ),
                                        ),
                                      ),
                                    ]
                                  : [CircularProgressIndicator.adaptive()],
                            );
                          }),
                      SizedBox(
                        height: getVerticalSize(10),
                      ),
                      GetBuilder(
                          init: controller,
                          builder: (context) {
                            return CustomExpansionTile(
                              leading: CommonImageView(
                                imagePath: ImageConstant.homeExpicon2,
                              ),
                              title: MyText(
                                title: 'My Complaints',
                                clr: ColorConstant.antextlightgray,
                                fontSize: 14,
                              ),
                              subtitle: MyText(
                                title: 'Update and modify your complaints',
                                clr: ColorConstant.antextlightgray,
                                fontSize: 12,
                              ),
                              children: <Widget>[
                                if (controller.complaints != null)
                                  Padding(
                                    padding: getPadding(left: 10, right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start, // Adjusted alignment
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: getHorizontalSize(320), // Set the width explicitly

                                              child: ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                scrollDirection: Axis.vertical,
                                                itemCount: controller.complaints!.data!.length < 3
                                                    ? controller.complaints?.data?.length
                                                    : 3, // Increase the itemCount by 1 to accommodate the "View All" item
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 220,
                                                        child: MyText(
                                                          title: controller.complaints?.data?[index].description ?? "",
                                                          clr: ColorConstant.antextGrayDark,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding: getPadding(left: 10, right: 10),
                                                            height: getVerticalSize(20),
                                                            decoration: BoxDecoration(
                                                              color: controller.complaints!.data![index].status! == "Resolved"
                                                                  ? ColorConstant.appgreenColor
                                                                  : controller.complaints!.data![index].status! == "Pending"
                                                                      ? ColorConstant.pendingColor
                                                                      : ColorConstant.assignedColor,
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: MyText(
                                                              title: controller.complaints!.data![index].status!,
                                                              fontSize: 9,
                                                              clr: ColorConstant.whiteA700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ).paddingOnly(bottom: 15);
                                                },
                                              ),
                                            ),
                                            Center(
                                              child: InkWell(
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
                                                child: Center(
                                                  child: MyText(
                                                    title: "View More",
                                                    fontSize: 16,
                                                    clr: ColorConstant.antextGrayDark,
                                                    customWeight: FontWeight.bold,
                                                    under: true,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: getVerticalSize(10)),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                              ],
                            );
                          }),
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

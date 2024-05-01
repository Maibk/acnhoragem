import 'dart:developer';

import 'package:anchorageislamabad/core/utils/image_constant.dart';
import 'package:anchorageislamabad/presentation/login_screen/models/login_model.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../baseviews/baseview_process_screen.dart';
import '../../core/model_classes/deal_model.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_expensiontile.dart';
import '../../widgets/no_internet_found.dart';
import '../../widgets/paginations/paged_listview.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeController controller = Get.put(HomeController());

  // const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('assets/images/background.png'), // Replace 'assets/background_image.jpg' with your image path
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
                                          Get.toNamed(AppRoutes.myComplaintsPage);
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
                                          Get.toNamed(AppRoutes.billsPage);
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
                                          Get.toNamed(AppRoutes.propertiesPage);
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
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getVerticalSize(10),
                      ),
                      Align(
                          alignment: Alignment.topLeft,
                          child: MyText(
                            title: "Quick View",
                            fontSize: 16,
                            clr: ColorConstant.apppWhite,
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
                                          width: getHorizontalSize(320), //
                                          height: Get.height,
                                          child: ListView.builder(
                                            physics: NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: controller.bills!.data!.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                  title: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text("Date : ${controller.bills!.data![index].billMonth}"),
                                                  Text("Amount :${controller.bills!.data![index].beforeDueDateAmount} ")
                                                ],
                                              ));
                                            },
                                          ),
                                        )
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
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: getHorizontalSize(320), // Set the width explicitly

                                              child: ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                padding: EdgeInsets.zero,
                                                scrollDirection: Axis.vertical,
                                                itemCount: controller.complaints!.data!
                                                    .length, // Increase the itemCount by 1 to accommodate the "View All" item
                                                itemBuilder: (BuildContext context, int index) {
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: 220,
                                                        child: MyText(
                                                          title: controller.complaints!.data![index].description!,
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
                                                              color: controller.complaints!.data![index].status! ==
                                                                      "Resolved"
                                                                  ? ColorConstant.appgreenColor
                                                                  : controller.complaints!.data![index].status! ==
                                                                          "Pending"
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

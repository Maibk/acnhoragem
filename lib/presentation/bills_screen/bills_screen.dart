import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_button.dart';
import 'controller/bills_controller.dart';

class billsScreen extends StatelessWidget {
  BillsController controller = Get.put(BillsController());
  // const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String originalDateString = DateTime.now().toString();
    DateTime originalDate = DateTime.parse(originalDateString);

    String formattedDate = DateFormat('EEEE dd-yyyy hh:mm a').format(originalDate);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('assets/images/background.png'), // Replace 'assets/background_image.jpg' with your image path
          fit: BoxFit.cover, // Adjust as needed
        ),
      ),
      child: Scaffold(
        extendBodyBehindAppBar: false,
        extendBody: false,
        appBar: AppBar(
          toolbarHeight: 100.0,
          title: Text(
            "My Bills",
            style: TextStyle(color: ColorConstant.whiteA700),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              ),
              onPressed: () {
                Get.toNamed(AppRoutes.menuPage);
              },
            ),
          ],
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.homePage);
              },
              child: Icon(Icons.arrow_back_ios, color: Colors.white)),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            // Padding(
            //   padding: getPadding(left: 10),
            //   child: CustomAppBar(
            //     title: MyText(
            //       title: "My Bills",
            //       clr: ColorConstant.whiteA700,
            //       fontSize: 20,
            //       customWeight: FontWeight.w500,
            //     ),
            //     centerTitle: true,
            //     trailing: IconButton(
            //       icon: const Icon(Icons.menu),
            //       onPressed: () {
            //         Get.toNamed(AppRoutes.menuPage);
            //       },
            //     ),
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: getPadding(all: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      MyText(
                        title: formattedDate,
                        clr: ColorConstant.apppWhite,
                        fontSize: 12,
                      ),
                      SizedBox(
                        height: getVerticalSize(10),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.apppWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: double.infinity,
                        padding: getPadding(left: 30, right: 30, top: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  title: "ACMS ID",
                                  fontSize: 12,
                                ),
                                MyText(
                                  title: "Month",
                                  fontSize: 12,
                                ),
                                MyText(
                                  title: "Amount",
                                  fontSize: 12,
                                ),
                                MyText(
                                  title: "Actions",
                                  fontSize: 12,
                                ),
                              ],
                            ),
                            Divider(
                              color: ColorConstant.antextlightgray,
                            ),
                            GetBuilder(
                              init: controller,
                              builder: (controller) {
                                if (controller.bills?.data?.isEmpty == true) {
                                  return Center(child: Text("No bills to show"));
                                }

                                if (controller.bills?.data != null) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    padding: getPadding(top: 5),
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.bills?.data
                                        ?.length, // Increase the itemCount by 1 to accommodate the "View All" item
                                    itemBuilder: (BuildContext context, int index) {
                                      return Padding(
                                        padding: getPadding(top: 5, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            MyText(
                                              title: "#",
                                              clr: ColorConstant.antextGrayDark,
                                              fontSize: 13,
                                            ),
                                            MyText(
                                              title: controller.bills!.data![index].billMonth!,
                                              clr: ColorConstant.antextGrayDark,
                                              fontSize: 12,
                                            ).paddingOnly(left: 30),
                                            MyText(
                                              title: controller.bills!.data![index].beforeDueDateAmount!.toString(),
                                              clr: ColorConstant.antextGrayDark,
                                              fontSize: 12,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: getHorizontalSize(4),
                                                ),
                                                InkWell(
                                               
                                                    onTap: () {
                                                      launchUrl(
                                                        Uri.parse(controller.bills!.data![index].downloadBill!),
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: ColorConstant.anblueText,
                                                      ),
                                                      child: Text(
                                                        "View Bill",
                                                        style: TextStyle(fontSize: 10, color: ColorConstant.apppWhite),
                                                      ).paddingAll(5),
                                                    )

                                                    //  CommonImageView(
                                                    //   imagePath: ImageConstant.billsViewIcon,
                                                    //   height: 25,
                                                    //   width: 25,
                                                    // ),
                                                    ),
                                                SizedBox(
                                                  width: getHorizontalSize(4),
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      Get.toNamed(AppRoutes.payBillPage, arguments: [
                                                        controller.bills!.data![index].beforeDueDateAmount!.toString(),
                                                        controller.bills!.data![index].id!
                                                      ]);
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        color: ColorConstant.errorColor,
                                                      ),
                                                      child: Text(
                                                        "Pay Bill",
                                                        style: TextStyle(fontSize: 10, color: ColorConstant.apppWhite),
                                                      ).paddingAll(5),
                                                    )

                                                    // CommonImageView(
                                                    //   imagePath: ImageConstant.billsDollarIcon,
                                                    //   height: 25,
                                                    //   width: 25,
                                                    // ),
                                                    ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }

                                return SizedBox.shrink();
                              },
                            ),
                            // SizedBox(
                            //   height: getVerticalSize(10),
                            // ),
                            // MyAnimatedButton(
                            //   radius: 5.0,
                            //   height: getVerticalSize(45),
                            //   width: getHorizontalSize(400),
                            //   fontSize: 16,
                            //   bgColor: ColorConstant.anbtnBlue,
                            //   controller: controller.btnController,
                            //   title: "Print bill".tr,
                            //   onTap: () async {
                            //     log(DateTime.now().toString());
                            //   },
                            // ),
                            SizedBox(
                              height: getVerticalSize(10),
                            ),
                            CustomButton(
                              width: getHorizontalSize(350),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.whiteA700,
                              label: "View History".tr,
                              textColor: ColorConstant.anbtnBlue,
                              borderColor: ColorConstant.anbtnBlue,
                              // prefix: Icon(Icons.abc_rounded,color: ColorConstant.blackColor,),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getVerticalSize(16),
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

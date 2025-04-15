import 'dart:developer';

import 'package:anchorageislamabad/presentation/pay_bill_screen/controller/Pay_bill_controller.dart';
import 'package:anchorageislamabad/widgets/animated_custom_button.dart';
import 'package:anchorageislamabad/widgets/custom_button.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class PayBillScreen extends StatelessWidget {
  String? amount;

  final List args = Get.arguments;
  PayBillController controller = Get.put(PayBillController());

  @override
  Widget build(BuildContext context) {
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
            title: "Pay Bill",
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

        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: getPadding(left: 10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                Padding(
                  padding: getPadding(all: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // MyText(title: "Monday Mon-03-2024 10:12 PM",clr: ColorConstant.apppWhite,fontSize: 12,),
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
                        child: GetBuilder(
                            init: controller,
                            builder: (context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Container(
                                        height: 90.h,
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        child: controller.billPhoto != null
                                            ? Image.file(
                                                controller.billPhoto!,
                                                fit: BoxFit.fitWidth,
                                              )
                                            : MyText(title: "Upload payment receipt"),
                                      ),
                                      controller.billPhoto != null
                                          ? GestureDetector(
                                              onTap: () async {
                                                controller.billPhoto = null;
                                                controller.billPhoto = await controller.imagePicker();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                                child: Icon(
                                                  Icons.check_circle_outline_outlined,
                                                  color: ColorConstant.anbtnBlue,
                                                  size: 55,
                                                ),
                                              ),
                                            )
                                          : Positioned(
                                              bottom: -15, // Position halfway up the image

                                              child: GestureDetector(
                                                  onTap: () async {
                                                    controller.billPhoto = await controller.imagePicker();
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(color: ColorConstant.anbtnBlue, shape: BoxShape.circle),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: ColorConstant.whiteA700,
                                                      size: 45,
                                                    ),
                                                  )),
                                            ),
                                    ],
                                  ),
                                  SizedBox(height: getVerticalSize(10)),
                                  MyText(title: "Bill Payment amount: ${args[1]}", fontSize: 15.h),
                                  SizedBox(height: getVerticalSize(15)),
                                  MyAnimatedButton(
                                    radius: 5.0,
                                    height: getVerticalSize(45),
                                    width: getHorizontalSize(400),
                                    fontSize: 16,
                                    bgColor: ColorConstant.anbtnBlue,
                                    controller: controller.btnController,
                                    title: "Pay Bill".tr,
                                    onTap: () async {
                                      log(args[1].toString());
                                      controller.payBill(context, args[1]);
                                    },
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: getVerticalSize(16),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),

        //  Padding(
        //   padding: getPadding(left: 10, right: 10),
        //   child: Column(
        //     children: [
        //       CustomAppBar(
        //         title: MyText(
        //           title: "Pay Bill",
        //           clr: ColorConstant.whiteA700,
        //           fontSize: 20,
        //           customWeight: FontWeight.w500,
        //         ),
        //         centerTitle: true,
        //         leading: GestureDetector(
        //             onTap: () {
        //               Get.back();
        //             },
        //             child: Icon(Icons.arrow_back_ios)),
        //         trailing: IconButton(
        //           icon: const Icon(Icons.menu),
        //           onPressed: () {
        //             Get.toNamed(AppRoutes.menuPage);
        //           },
        //         ),
        //       ),
        //       Expanded(
        //           child: Column(
        //         children: [
        //           Container(
        //             width: getHorizontalSize(350),
        //             color: ColorConstant.anbtnBlue,
        //             child: Text(
        //               "Bill Payment Amount ${args[0]}",
        //               style: TextStyle(color: Colors.white, fontSize: 22),
        //             ).paddingAll(15),
        //           ),
        //           SizedBox(
        //             height: 120,
        //           ),
        //           GestureDetector(
        //             onTap: () async {
        //               controller.billPhoto = await controller.imagePicker();
        //             },
        //             child: GetBuilder(
        //                 init: controller,
        //                 builder: (controller) {
        //                   return Container(
        //                     width: getHorizontalSize(350),
        //                     color: ColorConstant.anbtnBlue,
        //                     child: Center(
        //                       child: Text(
        //                         controller.billPhoto != null ? "Payment Receipt" : "Upload Payment Receipt",
        //                         style: TextStyle(color: Colors.white, fontSize: 22),
        //                       ).paddingAll(15),
        //                     ),
        //                   );
        //                 }),
        //           ),
        //           SizedBox(
        //             height: 120,
        //           ),
        //           CustomButton(
        //             width: getHorizontalSize(350),
        //             fontSize: 22,
        //             fontWeight: FontWeight.w700,
        //             color: ColorConstant.anbtnBlue,
        //             label: "Pay Bill".tr,
        //             textColor: ColorConstant.whiteA700,
        //             borderColor: ColorConstant.whiteA700,
        //             // prefix: Icon(Icons.abc_rounded,color: ColorConstant.blackColor,),
        //             onPressed: () {
        //               log(args[1].toString());
        //               controller.payBill(context, args[1]);
        //             },
        //           ),
        //         ],
        //       ))
        //     ],
        //   ),
        // ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowLeft() {
    Get.back();
  }
}

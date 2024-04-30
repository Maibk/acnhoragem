import 'dart:developer';

import 'package:anchorageislamabad/core/utils/image_constant.dart';
import 'package:anchorageislamabad/presentation/pay_bill_screen/controller/Pay_bill_controller.dart';
import 'package:anchorageislamabad/widgets/custom_button.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_expensiontile.dart';

class PayBillScreen extends StatelessWidget {
  String? amount;

  final List args = Get.arguments;
  PayBillController controller = Get.put(PayBillController());

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
        body: Padding(
          padding: getPadding(left: 10, right: 10),
          child: Column(
            children: [
              CustomAppBar(
                title: MyText(
                  title: "Pay Bill",
                  clr: ColorConstant.whiteA700,
                  fontSize: 20,
                  customWeight: FontWeight.w500,
                ),
                centerTitle: true,
                leading: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back_ios)),
                trailing: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Get.toNamed(AppRoutes.menuPage);
                  },
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    width: getHorizontalSize(350),
                    color: ColorConstant.anbtnBlue,
                    child: Text(
                      "Bill Payment Amount ${args[0]}",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ).paddingAll(15),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  GestureDetector(
                    onTap: () async {
                      controller.billPhoto = await controller.imagePicker();
                    },
                    child: GetBuilder(
                        init: controller,
                        builder: (controller) {
                          return Container(
                            width: getHorizontalSize(350),
                            color: ColorConstant.anbtnBlue,
                            child: Center(
                              child: Text(
                                controller.billPhoto != null ? "Payment Receipt" : "Upload Payment Receipt",
                                style: TextStyle(color: Colors.white, fontSize: 22),
                              ).paddingAll(15),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  CustomButton(
                    width: getHorizontalSize(350),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: ColorConstant.anbtnBlue,
                    label: "Pay Bill".tr,
                    textColor: ColorConstant.whiteA700,
                    borderColor: ColorConstant.whiteA700,
                    // prefix: Icon(Icons.abc_rounded,color: ColorConstant.blackColor,),
                    onPressed: () {
                      log(args[1].toString());
                      controller.payBill(context, args[1]);
                    },
                  ),
                ],
              ))
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

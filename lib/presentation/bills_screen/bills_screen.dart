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

class billsScreen extends StatefulWidget {
  @override
  State<billsScreen> createState() => _billsScreenState();
}

class _billsScreenState extends State<billsScreen> {
  BillsController controller = Get.put(BillsController());

  @override
  void initState() {
    controller.getbills();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String originalDateString = DateTime.now().toString();
    DateTime originalDate = DateTime.parse(originalDateString);

    String formattedDate = DateFormat('EEEE dd-yyyy hh:mm a').format(originalDate);

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'), // Replace 'assets/background_image.jpg' with your image path
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
                                    itemCount: controller.bills?.data?.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      String status = controller.bills?.data?[index].status ?? "";

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
                                                    )),
                                                SizedBox(
                                                  width: getHorizontalSize(4),
                                                ),
                                                if (status.toLowerCase() == "unpaid")
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
                                                      ))
                                                else
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(5),
                                                      color: getColor(status),
                                                    ),
                                                    child: Text(
                                                      status,
                                                      style: TextStyle(fontSize: 10, color: ColorConstant.apppWhite),
                                                    ).paddingAll(5),
                                                  )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                } else {
                                  return Center(child: CircularProgressIndicator());
                                }
                              },
                            ),
                            // SizedBox(
                            //   height: getVerticalSize(10),
                            // ),
                            // CustomButton(
                            //   width: getHorizontalSize(350),
                            //   fontSize: 14,
                            //   fontWeight: FontWeight.w700,
                            //   color: ColorConstant.whiteA700,
                            //   label: "View History".tr,
                            //   textColor: ColorConstant.anbtnBlue,
                            //   borderColor: ColorConstant.anbtnBlue,
                            //   // prefix: Icon(Icons.abc_rounded,color: ColorConstant.blackColor,),
                            //   onPressed: () {},
                            // ),
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

  Color getColor(String status) {
    switch (status) {
      case "Unpaid":
        return Colors.red;
      case "Paid":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  /// Navigates to the previous screen.
  onTapArrowLeft() {
    Get.back();
  }
}

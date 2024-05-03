import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import 'controller/properties_controller.dart';

class PropertiesScreen extends StatelessWidget {
  PropertiesController controller = Get.put(PropertiesController());
  // const DiscoverScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: Colors.transparent,
          title: MyText(
            title: "My Properties",
            clr: ColorConstant.whiteA700,
            fontSize: 20,
            customWeight: FontWeight.w500,
          ),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.homePage);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
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
                                  title: "Property Type",
                                  fontSize: 12,
                                  customWeight: FontWeight.w500,
                                ),
                                MyText(
                                  title: "Plot No",
                                  fontSize: 12,
                                  customWeight: FontWeight.w500,
                                ),
                                MyText(
                                  title: "Blockt",
                                  fontSize: 12,
                                  customWeight: FontWeight.w500,
                                ),
                                MyText(
                                  title: "Status",
                                  fontSize: 12,
                                  customWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            Divider(
                              color: ColorConstant.antextlightgray,
                            ),
                            GetBuilder(
                                init: controller,
                                builder: (value) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    padding: getPadding(top: 5),
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.properties?.data?.length ??
                                        0, // Increase the itemCount by 1 to accommodate the "View All" item
                                    itemBuilder: (BuildContext context, int index) {
                                      final iteration = controller.properties!.data![index];
                                      return Padding(
                                        padding: getPadding(top: 5, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 72,
                                              child: MyText(
                                                title: iteration.storyType.toString(),
                                                clr: ColorConstant.antextGrayDark,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Container(
                                              child: MyText(
                                                title: iteration.plotNo ?? "N/A",
                                                clr: ColorConstant.antextGrayDark,
                                                fontSize: 12,
                                              ),
                                            ),
                                            MyText(
                                              title: iteration.block ?? "N/A",
                                              clr: ColorConstant.antextGrayDark,
                                              fontSize: 12,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: getPadding(left: 10, right: 10),
                                                  height: getVerticalSize(20),
                                                  decoration: BoxDecoration(
                                                    color: ColorConstant.appgreenColor,
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: MyText(
                                                    title: iteration.status.toString(),
                                                    fontSize: 9,
                                                    clr: ColorConstant.whiteA700,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }),
                            SizedBox(
                              height: getVerticalSize(10),
                            ),
                            CustomButton(
                              width: getHorizontalSize(350),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: ColorConstant.whiteA700,
                              label: "Add New Property".tr,
                              textColor: ColorConstant.anbtnBlue,
                              borderColor: ColorConstant.anbtnBlue,
                              // prefix: Icon(Icons.abc_rounded,color: ColorConstant.blackColor,),
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (_) => AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    surfaceTintColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    actions: [
                                      Container(
                                          padding: EdgeInsets.all(20),
                                          height: 230.h,
                                          width: screenWidth,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.white),
                                              borderRadius: BorderRadius.circular(10),
                                              color: Color(0xffFFFFFF)),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Select User Type",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 25,
                                                  color: Color(0xff02045C),
                                                  fontFamily: 'Ageo',
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        controller.userTypeContoller.text = "Owner";
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(4),
                                                          color: Color(0xff0072BC),
                                                        ),
                                                        child: Center(
                                                          child: Text(
                                                            "Owner",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Color(0xffFFFFFF),
                                                              fontFamily: 'Ageo',
                                                            ),
                                                          ).paddingSymmetric(vertical: 5),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: getHorizontalSize(5),
                                                  ),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        controller.userTypeContoller.text = "Tenant";
                                                        Navigator.pop(context);
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            border:
                                                                Border.all(width: 1, color: ColorConstant.anbtnBlue),
                                                            borderRadius: BorderRadius.circular(4),
                                                            color: ColorConstant.whiteA700),
                                                        child: Center(
                                                          child: Text(
                                                            "Tenant",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: ColorConstant.blackColor,
                                                              fontFamily: 'Ageo',
                                                            ),
                                                          ).paddingSymmetric(vertical: 5),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                );

                                controller.userTypeContoller.text == "Owner"
                                    ? Get.toNamed(AppRoutes.ownerFormsPage)
                                    : Get.toNamed(AppRoutes.tenantFormsPage);
                              },
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

import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_expensiontile.dart';
import 'controller/myforms_controller.dart';

class MyFormsScreen extends StatelessWidget {
  final MyFormsController controller = Get.put(MyFormsController());
  // const DiscoverScreen({Key? key}) : super(key: key);

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
            title: "My Forms",
            clr: ColorConstant.whiteA700,
            fontSize: 20,
            customWeight: FontWeight.w500,
          ),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.homePage);
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
                      Container(
                        //height: getVerticalSize(200),
                        color: ColorConstant.apppWhite,
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
                                          Get.toNamed(AppRoutes.entryFormsPage, arguments: {"status": "", "id": ""});
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
                                        title: "Entry Form",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.serventFormsPage);
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myFormsIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Servant Form",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.vechicleFormsPage);
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myFormsIcon1,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Vehicle Forms",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getVerticalSize(10),
                      ),
                      MyText(
                        title: "Forms Lists",
                        clr: ColorConstant.whiteA700,
                        fontSize: 20,
                        customWeight: FontWeight.w500,
                      ),
                      Container(
                        //height: getVerticalSize(200),
                        color: ColorConstant.apppWhite,
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
                                          Get.toNamed(AppRoutes.formsList, arguments: "Entry Form");
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
                                        title: "Entry Form",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.formsList, arguments: "Servant Form");
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myFormsIcon,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Servant Form",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.toNamed(AppRoutes.formsList, arguments: "Vehicle Form");
                                        },
                                        child: CommonImageView(
                                          imagePath: ImageConstant.myFormsIcon1,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      SizedBox(
                                        height: getVerticalSize(10),
                                      ),
                                      MyText(
                                        title: "Vehicle Forms",
                                        clr: ColorConstant.antextGrayDark,
                                        fontSize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: getVerticalSize(20),
                            ),
                          ],
                        ),
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

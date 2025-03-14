import 'package:anchorageislamabad/core/utils/image_constant.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_expensiontile.dart';
import 'controller/downloadforms_controller.dart';

class DownloadFormsScreen extends StatelessWidget {
  DownloadFormsController controller = Get.put(DownloadFormsController());

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
            title: "Download Forms",
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
        body: Padding(
          padding: getPadding(left: 10, right: 10),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: getPadding(all: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getVerticalSize(10),
                        ),
                        SingleChildScrollView(
                          child: CustomExpansionTile(
                            leading: Icon(Icons.add, color: ColorConstant.whiteA700),
                            title: MyText(title: 'Administration Department', clr: ColorConstant.black900, fontSize: 14),
                            children: <Widget>[
                              Padding(
                                padding: getPadding(left: 15, right: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      // Wrap the Column with Expanded
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          GetBuilder(
                                            init: controller,
                                            builder: (context) {
                                              if (controller.adFroms == null) {
                                                return Center(
                                                  child: Text("No records found"),
                                                );
                                              }
                                              if (controller.adFroms != null) {
                                                return Container(
                                                  width: getHorizontalSize(300), // Set the width explicitly
                                                  child: ListView.builder(
                                                    physics: NeverScrollableScrollPhysics(),
                                                    shrinkWrap: true,
                                                    padding: EdgeInsets.zero,
                                                    scrollDirection: Axis.vertical,
                                                    itemCount: controller
                                                        .adFroms!.data!.length, // Increase the itemCount by 1 to accommodate the "View All" item
                                                    itemBuilder: (BuildContext context, int index) {
                                                      return Column(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              launchUrl(
                                                                Uri.parse(controller.adFroms!.data![index].buttonLink!),
                                                              );
                                                            },
                                                            child: Container(
                                                              padding: getPadding(all: 10),
                                                              decoration: BoxDecoration(
                                                                border: Border.all(color: ColorConstant.anbtnBlue),
                                                                borderRadius: BorderRadius.circular(5),
                                                              ),
                                                              child: Padding(
                                                                padding: getPadding(left: 5, right: 5, top: 0, bottom: 0),
                                                                child: Row(
                                                                  children: [
                                                                    CommonImageView(
                                                                      imagePath: ImageConstant.downloadIcon,
                                                                    ),
                                                                    SizedBox(width: 10), // Add some space between the image and text
                                                                    Expanded(
                                                                      child: MyText(
                                                                        title: controller.adFroms!.data![index].title!,
                                                                        fontSize: 11,
                                                                        clr: ColorConstant.gray600,
                                                                        line: 2,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Divider(), // Add a Divider between items
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                );
                                              }

                                              return Container();
                                            },
                                          ),
                                          SizedBox(height: getVerticalSize(10)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getVerticalSize(10),
                        ),
                        CustomExpansionTile(
                          expanded: true,
                          expand: true,
                          leading: Icon(
                            Icons.add,
                            color: ColorConstant.whiteA700,
                          ),
                          title: MyText(
                            title: 'Building Control Department',
                            clr: ColorConstant.black900,
                            fontSize: 14,
                          ),
                          children: <Widget>[
                            Padding(
                              padding: getPadding(left: 15, right: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    // Wrap the Column with Expanded
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GetBuilder(
                                            init: controller,
                                            builder: (context) {
                                              if (controller.bcdFormsLoading.value == ApiCallStatus.loading) {
                                                return Center(child: CupertinoActivityIndicator());
                                              } else {
                                                if (controller.bcdForms == null) {
                                                  return Center(
                                                    child: Text("No records found"),
                                                  );
                                                }
                                                if (controller.bcdForms != null) {
                                                  return Container(
                                                    width: getHorizontalSize(300), // Set the width explicitly
                                                    child: ListView.builder(
                                                      physics: NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      padding: EdgeInsets.zero,
                                                      scrollDirection: Axis.vertical,
                                                      itemCount: controller
                                                          .bcdForms!.data!.length, // Increase the itemCount by 1 to accommodate the "View All" item
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: () {
                                                                launchUrl(
                                                                  Uri.parse(controller.bcdForms!.data![index].buttonLink!),
                                                                );
                                                              },
                                                              child: Container(
                                                                padding: getPadding(all: 10),
                                                                decoration: BoxDecoration(
                                                                  border: Border.all(color: ColorConstant.anbtnBlue),
                                                                  borderRadius: BorderRadius.circular(5),
                                                                ),
                                                                child: Padding(
                                                                  padding: getPadding(left: 5, right: 5, top: 0, bottom: 0),
                                                                  child: Row(
                                                                    children: [
                                                                      CommonImageView(
                                                                        imagePath: ImageConstant.downloadIcon,
                                                                      ),
                                                                      SizedBox(width: 10), // Add some space between the image and text
                                                                      Expanded(
                                                                        child: MyText(
                                                                          title: controller.bcdForms!.data![index].title!,
                                                                          fontSize: 11,
                                                                          clr: ColorConstant.gray600,
                                                                          line: 2,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Divider(), // Add a Divider between items
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                }

                                                return Container();
                                              }
                                            }),
                                        SizedBox(height: getVerticalSize(10)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getVerticalSize(10),
                        ),
                        CustomExpansionTile(
                          leading: Icon(
                            Icons.add,
                            color: ColorConstant.whiteA700,
                          ),
                          title: MyText(
                            title: 'Record Office',
                            clr: ColorConstant.black900,
                            fontSize: 14,
                          ),
                          children: <Widget>[
                            Padding(
                              padding: getPadding(left: 15, right: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    // Wrap the Column with Expanded
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GetBuilder(
                                          init: controller,
                                          builder: (context) {
                                            if (controller.roForms == null) {
                                              return Center(
                                                child: Text("No records found"),
                                              );
                                            }
                                            if (controller.roForms != null) {
                                              return Container(
                                                width: getHorizontalSize(300), // Set the width explicitly
                                                child: ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: controller
                                                      .roForms!.data!.length, // Increase the itemCount by 1 to accommodate the "View All" item
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            launchUrl(
                                                              Uri.parse(controller.roForms!.data![index].buttonLink!),
                                                            );
                                                          },
                                                          child: Container(
                                                            padding: getPadding(all: 10),
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: ColorConstant.anbtnBlue),
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            child: Padding(
                                                              padding: getPadding(left: 5, right: 5, top: 0, bottom: 0),
                                                              child: Row(
                                                                children: [
                                                                  CommonImageView(
                                                                    imagePath: ImageConstant.downloadIcon,
                                                                  ),
                                                                  SizedBox(width: 10), // Add some space between the image and text
                                                                  Expanded(
                                                                    child: MyText(
                                                                      title: controller.roForms!.data![index].title!,
                                                                      fontSize: 11,
                                                                      clr: ColorConstant.gray600,
                                                                      line: 2,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(), // Add a Divider between items
                                                      ],
                                                    );
                                                  },
                                                ),
                                              );
                                            }

                                            return Container();
                                          },
                                        ),
                                        SizedBox(height: getVerticalSize(10)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getVerticalSize(10),
                        ),
                        CustomExpansionTile(
                          leading: Icon(
                            Icons.add,
                            color: ColorConstant.whiteA700,
                          ),
                          title: MyText(
                            title: 'Property Exchange Centre',
                            clr: ColorConstant.black900,
                            fontSize: 14,
                          ),
                          children: <Widget>[
                            Padding(
                              padding: getPadding(left: 15, right: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    // Wrap the Column with Expanded
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GetBuilder(
                                          init: controller,
                                          builder: (context) {
                                            if (controller.pecForms == null) {
                                              return Center(
                                                child: Text("No records found"),
                                              );
                                            }
                                            if (controller.pecForms != null) {
                                              return Container(
                                                width: getHorizontalSize(300), // Set the width explicitly
                                                child: ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: controller
                                                      .pecForms!.data!.length, // Increase the itemCount by 1 to accommodate the "View All" item
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            launchUrl(
                                                              Uri.parse(controller.pecForms!.data![index].buttonLink!),
                                                            );
                                                          },
                                                          child: Container(
                                                            padding: getPadding(all: 10),
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: ColorConstant.anbtnBlue),
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            child: Padding(
                                                              padding: getPadding(left: 5, right: 5, top: 0, bottom: 0),
                                                              child: Row(
                                                                children: [
                                                                  CommonImageView(
                                                                    imagePath: ImageConstant.downloadIcon,
                                                                  ),
                                                                  SizedBox(width: 10), // Add some space between the image and text
                                                                  Expanded(
                                                                    child: MyText(
                                                                      title: controller.pecForms!.data![index].title!,
                                                                      fontSize: 11,
                                                                      clr: ColorConstant.gray600,
                                                                      line: 2,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(), // Add a Divider between items
                                                      ],
                                                    );
                                                  },
                                                ),
                                              );
                                            }

                                            return Container();
                                          },
                                        ),
                                        SizedBox(height: getVerticalSize(10)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getVerticalSize(10),
                        ),
                        CustomExpansionTile(
                          leading: Icon(
                            Icons.add,
                            color: ColorConstant.whiteA700,
                          ),
                          title: MyText(
                            title: 'Anchorage Medical Centre',
                            clr: ColorConstant.black900,
                            fontSize: 14,
                          ),
                          children: <Widget>[
                            Padding(
                              padding: getPadding(left: 15, right: 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    // Wrap the Column with Expanded
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        GetBuilder(
                                          init: controller,
                                          builder: (context) {
                                            if (controller.pecForms == null) {
                                              return Center(
                                                child: Text("No records found"),
                                              );
                                            }
                                            if (controller.pecForms != null) {
                                              return Container(
                                                width: getHorizontalSize(300), // Set the width explicitly
                                                child: ListView.builder(
                                                  physics: NeverScrollableScrollPhysics(),
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: controller
                                                      .pecForms!.data!.length, // Increase the itemCount by 1 to accommodate the "View All" item
                                                  itemBuilder: (BuildContext context, int index) {
                                                    return Column(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            launchUrl(
                                                              Uri.parse(controller.pecForms!.data![index].buttonLink!),
                                                            );
                                                          },
                                                          child: Container(
                                                            padding: getPadding(all: 10),
                                                            decoration: BoxDecoration(
                                                              border: Border.all(color: ColorConstant.anbtnBlue),
                                                              borderRadius: BorderRadius.circular(5),
                                                            ),
                                                            child: Padding(
                                                              padding: getPadding(left: 5, right: 5, top: 0, bottom: 0),
                                                              child: Row(
                                                                children: [
                                                                  CommonImageView(
                                                                    imagePath: ImageConstant.downloadIcon,
                                                                  ),
                                                                  SizedBox(width: 10), // Add some space between the image and text
                                                                  Expanded(
                                                                    child: MyText(
                                                                      title: controller.pecForms!.data![index].title!,
                                                                      fontSize: 11,
                                                                      clr: ColorConstant.gray600,
                                                                      line: 2,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Divider(), // Add a Divider between items
                                                      ],
                                                    );
                                                  },
                                                ),
                                              );
                                            }

                                            return Container();
                                          },
                                        ),
                                        SizedBox(height: getVerticalSize(10)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
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

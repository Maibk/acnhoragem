import 'package:anchorageislamabad/core/utils/helper_functions.dart';
import 'package:anchorageislamabad/presentation/complaints_screen/controller/complaints_controller.dart';
import 'package:anchorageislamabad/presentation/mycomplaints_screen/controller/view_complaint_controller.dart';
import 'package:anchorageislamabad/widgets/common_image_view.dart';
import 'package:anchorageislamabad/widgets/custom_image_view.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:anchorageislamabad/widgets/custom_textfield_forms.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/animated_custom_button.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../complaints_screen/complaints_screen.dart';
import 'controller/mycomplaints_controller.dart';

class VIewComplaintsScreen extends StatelessWidget {
  VIewComplaintsScreen({Key? key, this.complainType, this.description, this.status, this.complaintID})
      : super(key: key);
  ComplaintsController controller = Get.put(ComplaintsController());
  ViewComplaintController viewcontroller = Get.put(ViewComplaintController());
  String? complainType;
  String? description;
  String? status;
  int? complaintID;

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
        appBar: AppBar(
          toolbarHeight: 80.0,
          backgroundColor: Colors.transparent,
          title: MyText(
            title: "Complaints",
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
                            init: viewcontroller,
                            builder: (context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      if (viewcontroller.viewComplaintModel?.data?.attachment?.isNotEmpty == true)
                                        CommonImageView(
                                          url: viewcontroller.viewComplaintModel?.data?.attachment?.first ?? "",
                                          imagePath: ImageConstant.complaintImage,
                                          height: getVerticalSize(120),
                                          width: double.infinity,
                                        )
                                      else
                                        CommonImageView(
                                          imagePath: ImageConstant.noImage,
                                          height: getVerticalSize(120),
                                          width: double.infinity,
                                        ),
                                      Positioned(
                                        right: 80,
                                        bottom: getVerticalSize(100),
                                        child: Container(
                                          padding: getPadding(left: 10, right: 10),
                                          height: getVerticalSize(30),
                                          width: getHorizontalSize(150),
                                          decoration: BoxDecoration(
                                            color: status == "Resolved"
                                                ? ColorConstant.appgreenColor
                                                : status == "Pending"
                                                    ? ColorConstant.pendingColor
                                                    : ColorConstant.assignedColor,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          alignment: Alignment.center,
                                          child: MyText(
                                            title: status!,
                                            fontSize: 16,
                                            customWeight: FontWeight.bold,
                                            clr: ColorConstant.whiteA700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: getVerticalSize(10)),
                                  MyText(title: "Complaint Type", fontSize: 12),
                                  SizedBox(height: getVerticalSize(10)),
                                  MyText(title: complainType ?? "", fontSize: 18),
                                  SizedBox(height: getVerticalSize(10)),
                                  MyText(title: "Description", fontSize: 12),
                                  SizedBox(height: getVerticalSize(10)),
                                  MyText(title: description ?? "", fontSize: 18),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: getVerticalSize(16),
                      ),
                      SizedBox(
                        height: getVerticalSize(10),
                      ),
                      status == "Resolved"
                          ? Column()
                          : GetBuilder<ViewComplaintController>(builder: (context) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (viewcontroller.complainMessages?.data?.messages?.isEmpty == true)
                                    SizedBox.shrink()
                                  else if (viewcontroller.complainMessages?.data?.messages != null)
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        MyText(
                                          title: "History",
                                          fontSize: 16,
                                          clr: ColorConstant.antextGrayDark,
                                          customWeight: FontWeight.bold,
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(16),
                                        ),
                                        Container(
                                          height: context.isExpanded ? null : 150,
                                          decoration: BoxDecoration(
                                              color: ColorConstant.whiteA700, borderRadius: BorderRadius.circular(12)),
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: context.isExpanded
                                                ? NeverScrollableScrollPhysics()
                                                : ClampingScrollPhysics(),
                                            itemCount: viewcontroller.complainMessages?.data?.messages?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                leading: CustomImageView(
                                                  imagePath: ImageConstant.profileIcon,
                                                ).paddingOnly(bottom: 15),
                                                title: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: 120,
                                                          child: MyText(
                                                            title: viewcontroller.complainMessages?.data
                                                                    ?.messages?[index].userName ??
                                                                "",
                                                            fontSize: 16,
                                                            clr: ColorConstant.antextGrayDark,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 120,
                                                          child: MyText(
                                                            title: viewcontroller.complainMessages?.data
                                                                    ?.messages?[index].dateTime ??
                                                                "",
                                                            fontSize: 15,
                                                            clr: ColorConstant.antextGrayDark,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    MyText(
                                                      title: viewcontroller
                                                              .complainMessages?.data?.messages?[index].message ??
                                                          "",
                                                      fontSize: 16,
                                                      clr: ColorConstant.blackColor,
                                                    ).paddingOnly(top: 10),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(16),
                                        ),
                                        context.isExpanded
                                            ? SizedBox.shrink()
                                            : InkWell(
                                                onTap: () {
                                                  context.expand();
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
                                      ],
                                    ),
                                  SizedBox(
                                    height: getVerticalSize(16),
                                  ),
                                  MyText(
                                    title: "Feedback / Message",
                                    fontSize: 16,
                                    clr: ColorConstant.antextGrayDark,
                                    customWeight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: getVerticalSize(16),
                                  ),
                                  CustomTextFieldForms(
                                    hintText: "Type Your text here",
                                    controller: controller.messageController,
                                    isFinal: false,
                                    keyboardType: TextInputType.streetAddress,
                                    limit: 80,
                                    maxLines: 8,
                                    validator: (value) {
                                      return HelperFunction.empthyFieldValidator(value!);
                                    },
                                  ),
                                  SizedBox(
                                    height: getVerticalSize(16),
                                  ),
                                  MyAnimatedButton(
                                    radius: 5.0,
                                    height: getVerticalSize(45),
                                    width: getHorizontalSize(400),
                                    fontSize: 16,
                                    bgColor: ColorConstant.anbtnBlue,
                                    controller: controller.btnController,
                                    title: "Send Message".tr,
                                    onTap: () async {
                                      controller.submitMessge(context, complaintID);
                                    },
                                  ),
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

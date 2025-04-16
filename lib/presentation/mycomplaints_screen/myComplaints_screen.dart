import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/presentation/mycomplaints_screen/controller/view_complaint_controller.dart';
import 'package:anchorageislamabad/presentation/mycomplaints_screen/view_complaint.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/animated_custom_button.dart';
import '../complaints_screen/complaints_screen.dart';
import 'controller/mycomplaints_controller.dart';

class MyComplaintsScreen extends StatefulWidget {
  @override
  State<MyComplaintsScreen> createState() => _MyComplaintsScreenState();
}

class _MyComplaintsScreenState extends State<MyComplaintsScreen> {
  final ViewComplaintController viewCompplaincontroller = Get.put(ViewComplaintController());

  final MyComplaintsController controller = Get.put(MyComplaintsController());

  @override
  initState() {
    super.initState();
    controller.getComplaints();
  }

  // const DiscoverScreen({Key? key}) : super(key: key);7
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
            title: "My Complaints",
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
                                SizedBox(
                                  width: 70,
                                  child: MyText(
                                    title: "Title",
                                    fontSize: 12,
                                  ),
                                ),
                                MyText(
                                  title: "Description",
                                  fontSize: 12,
                                ),
                                MyText(
                                  title: "Status",
                                  fontSize: 12,
                                ),
                                MyText(
                                  title: "Action",
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
                                if (controller.apiCallStatus == ApiCallStatus.empty) {
                                  return Text("No records found");
                                }
                                if (controller.complaints?.data == null) {
                                  return Center(child: CircularProgressIndicator.adaptive());
                                }

                                if (controller.complaints?.data?.isEmpty == true) {
                                  return Center(
                                    child: Text("No records found"),
                                  );
                                }
                                if (controller.complaints?.data != null) {
                                  return ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: getPadding(top: 5),
                                    scrollDirection: Axis.vertical,
                                    itemCount: controller.complaints!.data!.length, // Increase the itemCount by 1 to accommodate the "View All" item
                                    itemBuilder: (BuildContext context, int index) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: getPadding(top: 10, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context).size.width / 3.8,
                                                  child: MyText(
                                                    title: controller.complaints?.data?[index].complaintType ?? "N/A",
                                                    clr: ColorConstant.antextGrayDark,
                                                    fontSize: 12,
                                                    line: 1,
                                                    toverflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(
                                                  constraints: BoxConstraints(maxWidth: 80, minWidth: 80),
                                                  child: MyText(
                                                    title: controller.complaints!.data![index].description!,
                                                    clr: ColorConstant.antextGrayDark,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      // width: 80,
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
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        viewCompplaincontroller.getViewComplain(controller.complaints!.data![index].id ?? 0);
                                                        viewCompplaincontroller.getMessagesOnComplain(controller.complaints!.data![index].id ?? 0);
                                                        Get.to(() => VIewComplaintsScreen(
                                                              description: controller.complaints!.data![index].description ?? "",
                                                              status: controller.complaints!.data![index].status ?? "",
                                                              complainType: controller.complaints!.data![index].complaintType ?? "",
                                                              complaintID: controller.complaints!.data![index].id ?? 0,
                                                            ));
                                                      },
                                                      child: Container(margin: EdgeInsets.only(left: 30), child: Icon(Icons.remove_red_eye)),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          // if (index != 14) // Add divider after all items except the last one
                                          const Divider(
                                            height: 1,
                                            color: Colors.grey, // Adjust color as needed
                                            thickness: 1,
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  CircularProgressIndicator.adaptive();
                                }

                                return SizedBox.shrink();
                              },
                            ),
                            SizedBox(
                              height: getVerticalSize(40),
                            ),
                            MyAnimatedButton(
                              radius: 5.0,
                              height: getVerticalSize(40),
                              width: getHorizontalSize(400),
                              fontSize: 16,
                              bgColor: ColorConstant.anbtnBlue,
                              controller: controller.btnController,
                              title: "Create New Complaint".tr,
                              onTap: () async {
                                Get.to(() => CreateNewComplaintScreen());
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

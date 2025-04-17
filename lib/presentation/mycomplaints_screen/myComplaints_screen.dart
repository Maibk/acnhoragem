import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/presentation/mycomplaints_screen/controller/view_complaint_controller.dart';
import 'package:anchorageislamabad/presentation/mycomplaints_screen/view_complaint.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                        height: getVerticalSize(5),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.apppWhite,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: getPadding(left: 10.w, right: 10.w, top: 10, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                  return Container(
                                    // padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
                                    child: DataTable(
                                      horizontalMargin: 0,
                                      dataRowMaxHeight: 50.0,
                                      showBottomBorder: false,
                                      columnSpacing: 20.w,
                                      dividerThickness: 0.0,
                                      columns: [
                                        DataColumn(label: Text('Title')),
                                        DataColumn(label: Text('Description')),
                                        DataColumn(label: Text('Status')),
                                        DataColumn(label: Text('Action').paddingOnly(left: 20.w)),
                                      ],
                                      rows: controller.complaints!.data!.map((complain) {
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              Container(
                                                // color: Colors.red,
                                                width: 50.w,
                                                child: MyText(
                                                  title: "${complain.complaintType}",
                                                  fontSize: 12.sp,
                                                  line: 1,
                                                  toverflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              SizedBox(
                                                width: 90.w,
                                                child: MyText(
                                                  title: "${complain.description}",
                                                  fontSize: 12.sp,
                                                  line: 1,
                                                  toverflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              Container(
                                                // width: 80,
                                                padding: getPadding(left: 10.w, right: 10.w),
                                                height: getVerticalSize(20),
                                                decoration: BoxDecoration(
                                                  color: complain.status! == "Resolved"
                                                      ? ColorConstant.appgreenColor
                                                      : complain.status! == "Pending"
                                                          ? ColorConstant.pendingColor
                                                          : ColorConstant.assignedColor,
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                alignment: Alignment.center,
                                                child: MyText(
                                                  title: complain.status!,
                                                  fontSize: 9.sp,
                                                  clr: ColorConstant.whiteA700,
                                                ),
                                              ),
                                            ),
                                            DataCell(GestureDetector(
                                              onTap: () {
                                                viewCompplaincontroller.getViewComplain(complain.id ?? 0);
                                                viewCompplaincontroller.getMessagesOnComplain(complain.id ?? 0);
                                                Get.to(() => VIewComplaintsScreen(
                                                      description: complain.description ?? "",
                                                      status: complain.status ?? "",
                                                      complainType: complain.complaintType ?? "",
                                                      complaintID: complain.id ?? 0,
                                                    ));
                                              },
                                              child: Container(margin: EdgeInsets.only(left: 30.w), child: Icon(Icons.remove_red_eye)),
                                            )),
                                          ],
                                        );
                                      }).toList(),
                                    ),
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
                              fontSize: 16.sp,
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

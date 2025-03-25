import 'dart:developer';

import 'package:anchorageislamabad/Shared_prefrences/app_prefrences.dart';
import 'package:anchorageislamabad/core/utils/size_utils.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/presentation/forms_list/controller/forms_lists_controller.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/utils/color_constant.dart';
import '../../routes/app_routes.dart';

class FormsListScreen extends StatefulWidget {
  @override
  State<FormsListScreen> createState() => _FormsListScreenState();
}

class _FormsListScreenState extends State<FormsListScreen> {
  final args = Get.arguments;
  FormsListsController controller = Get.put(FormsListsController());

  AppPreferences appPreferences = AppPreferences();
  @override
  initState() {
    controller.getAllFormsList(args);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(args.toString());
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
            title: args + " List",
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
            if (args == "Owner Form" || args == "Tenant Form")
              GestureDetector(
                onTap: () {
                  if (args == "Owner Form") {
                    Get.toNamed(AppRoutes.ownerFormsPage, arguments: {'status': "", 'id': ""});
                  } else {
                    Get.toNamed(AppRoutes.tenantFormsPage, arguments: {'status': "", 'id': ""});
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(7)),
                  child: Center(child: MyText(title: "Add new application form")),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: getPadding(all: 10),
                  child: GetBuilder(
                      init: controller,
                      builder: (context) {
                        if (controller.apiCallStatus.value == ApiCallStatus.loading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListView.builder(
                                itemCount: controller.formsListModel.data?.length ?? 0,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  int? id = controller.formsListModel.data?[index].id ?? 0;
                                  String? status = controller.formsListModel.data?[index].status ?? "";
                                  // String? status = "Rejected";
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    width: Get.width,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(color: Colors.white),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          // crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width / 2.7,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  MyText(title: "Name:"),
                                                  2.verticalSpace,
                                                  if (args == "Owner Form" || args == "Tenant Form")
                                                    MyText(title: "House No:")
                                                  else
                                                    MyText(title: "Father Name:"),
                                                  2.verticalSpace,
                                                  MyText(title: "CNIC:"),
                                                  2.verticalSpace,
                                                  MyText(title: args == "Vehicle Form" ? "Rank:" : "Phone:"),
                                                  2.verticalSpace,
                                                  MyText(title: "Status:"),
                                                  2.verticalSpace,
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: .6.sw,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  MyText(title: controller.formsListModel.data?[index].name ?? ""),
                                                  2.verticalSpace,
                                                  if (args == "Owner Form" || args == "Tenant Form")
                                                    MyText(line: 10, title: controller.formsListModel.data?[index].houseNo ?? "")
                                                  else
                                                    MyText(line: 10, title: controller.formsListModel.data?[index].fatherName ?? ""),
                                                  2.verticalSpace,
                                                  MyText(title: controller.formsListModel.data?[index].cnic ?? ""),
                                                  2.verticalSpace,
                                                  args == "Vehicle Form"
                                                      ? MyText(title: controller.formsListModel.data?[index].rank ?? "")
                                                      : MyText(title: controller.formsListModel.data?[index].phone ?? ""),
                                                  2.verticalSpace,
                                                  Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(10),
                                                          color: controller.getColor(status).withOpacity(0.5)),
                                                      child: MyText(
                                                          fontSize: 10.sp,
                                                          clr: controller.getColor(status),
                                                          title: controller.formsListModel.data?[index].status ?? "")),
                                                  2.verticalSpace,
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        5.verticalSpace,
                                        GestureDetector(
                                          onTap: () {
                                            if (args.toString() == "Entry Form") {
                                              Get.toNamed(AppRoutes.entryFormsPage, arguments: {
                                                "id": id,
                                                "status": status,
                                              });
                                            } else if (args.toString() == "Servant Form") {
                                              Get.toNamed(AppRoutes.serventFormsPage, arguments: {
                                                "id": id,
                                                "status": status,
                                              });
                                            } else if (args.toString() == "Owner Form") {
                                              Get.toNamed(AppRoutes.ownerFormsPage, arguments: {
                                                "id": id,
                                                "status": status,
                                              });
                                            } else if (args.toString() == "Tenant Form") {
                                              Get.toNamed(AppRoutes.tenantFormsPage, arguments: {
                                                "id": id,
                                                "status": status,
                                              });
                                            } else {
                                              Get.toNamed(AppRoutes.vechicleFormsPage, arguments: {
                                                "id": id,
                                                "status": status,
                                              });
                                            }
                                          },
                                          child: Center(
                                            child: Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: controller.getColor(status)),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    status == "Rejected" ? Icons.mode_edit_outlined : Icons.remove_red_eye,
                                                    color: Colors.white,
                                                  ),
                                                  2.horizontalSpace,
                                                  MyText(clr: Colors.white, title: status == "Rejected" ? "Edit Details" : "View Details"),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )
                            ],
                          );
                        }
                      }),
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

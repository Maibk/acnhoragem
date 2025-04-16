import 'dart:math';

import 'package:anchorageislamabad/core/utils/utils.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_button.dart';
import 'controller/properties_controller.dart';

class PropertiesScreen extends StatefulWidget {
  bool? isAppFormApproved;

  PropertiesScreen({Key? key, this.isAppFormApproved}) : super(key: key);

  @override
  State<PropertiesScreen> createState() => _PropertiesScreenState();
}

class _PropertiesScreenState extends State<PropertiesScreen> {
  final List args = Get.arguments;

  final PropertiesController controller = Get.put(PropertiesController());

  @override
  void initState() {
    controller.getPropertiesApi();
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
                        padding: getPadding(left: 25, right: 25, top: 20, bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetBuilder(
                                init: controller,
                                builder: (context) {
                                  return propertiesTable();
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
                                if (args[0]) {
                                  if (args[1] == "Owner") {
                                    controller.userTypeContoller.text = "Owner";
                                    Get.toNamed(AppRoutes.ownerFormsPage, arguments: {'status': "", 'id': ""});
                                  } else {
                                    controller.userTypeContoller.text = "Tenant";
                                    Get.toNamed(AppRoutes.tenantFormsPage, arguments: {'status': "", 'id': ""});
                                  }
                                } else {
                                  Utils.showToast(
                                    "Your application form is not approved yet, kindly wait for Approval",
                                    false,
                                  );
                                }
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

  Widget propertiesTable() {
    if (controller.apiCallStatus.value == ApiCallStatus.loading) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    } else if (controller.apiCallStatus.value == ApiCallStatus.empty) {
      return MyText(
        title: 'No Properties found.',
        clr: ColorConstant.antextlightgray,
        fontSize: 14,
      );
    } else if (controller.apiCallStatus.value == ApiCallStatus.success) {
      return Container(
        child: DataTable(
          horizontalMargin: 0,
          dataRowMaxHeight: 50.0,
          showBottomBorder: false,
          dividerThickness: 0.0,
          columns: const [
            DataColumn(label: Text('Street')),
            DataColumn(label: Text('Plot No')),
            DataColumn(label: Text('Block')),
            DataColumn(label: Text('Status')),
          ],
          rows: controller.properties!.data!.map((property) {
            return DataRow(
              cells: [
                DataCell(
                  MyText(
                    title: "${property.street}",
                    fontSize: 12.sp,
                  ),
                ),
                DataCell(
                  MyText(
                    title: "${property.plotNo}",
                    fontSize: 12.sp,
                  ),
                ),
                DataCell(
                  MyText(
                    title: "${property.block}",
                    fontSize: 12.sp,
                  ),
                ),
                DataCell(Container(
                  padding: getPadding(left: 10, right: 10),
                  height: getVerticalSize(20),
                  decoration: BoxDecoration(
                    color: property.status == 1 ? ColorConstant.appgreenColor : Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: MyText(
                    title: property.status == 1 ? "Active " : "Inactive",
                    fontSize: 9,
                    clr: ColorConstant.whiteA700,
                  ),
                )),
              ],
            );
          }).toList(),
        ),
      );
    } else {
      return Container();
    }
  }
}

import 'dart:developer';
import 'package:anchorageislamabad/Shared_prefrences/app_prefrences.dart';
import 'package:anchorageislamabad/core/utils/image_constant.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/main.dart';
import 'package:anchorageislamabad/theme/app_style.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../core/utils/utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/common_image_view.dart';
import '../../widgets/custom_expensiontile.dart';
import 'controller/home_controller.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController controller = Get.put(HomeController());

  AppPreferences appPreferences = AppPreferences();

  String role = '';

  @override
  Widget build(BuildContext context) {
    appPreferences.getRole().then((value) {
      role = value;
      setState(() {});
    });
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
        body: Column(
          children: [
            CustomAppBar(
              title: MyText(
                title: "Home",
                clr: ColorConstant.whiteA700,
                fontSize: 20,
                customWeight: FontWeight.w500,
              ),
              centerTitle: true,
              // leading: Icon(Icons.arrow_back_ios),
              trailing: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.toNamed(AppRoutes.menuPage);
                },
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.getProfile();
                  controller.getbills();
                  controller.getComplaints();
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: getPadding(all: 10),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorConstant.apppWhite,
                          ),
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
                                            Get.toNamed(AppRoutes.myProfilePage);
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
                                          title: "My Profile",
                                          clr: ColorConstant.antextGrayDark,
                                          fontSize: 11,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (controller.profileModel?.appFormApproved == 0) {
                                              Utils.showToast(
                                                "Your application form is not approved yet, kindly wait for Approval",
                                                false,
                                              );
                                            } else {
                                              Get.toNamed(AppRoutes.myComplaintsPage);
                                            }
                                          },
                                          child: CommonImageView(
                                            imagePath: ImageConstant.myComplaintIcon,
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(10),
                                        ),
                                        MyText(
                                          title: "My Complaints",
                                          clr: ColorConstant.antextGrayDark,
                                          fontSize: 11,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (controller.profileModel?.appFormApproved == 0) {
                                              Utils.showToast(
                                                "Your application form is not approved yet, kindly wait for Approval",
                                                false,
                                              );
                                            } else {
                                              Get.toNamed(AppRoutes.billsPage);
                                            }
                                          },
                                          child: CommonImageView(
                                            imagePath: ImageConstant.myBillsIcon,
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(10),
                                        ),
                                        MyText(
                                          title: "Bills Details",
                                          clr: ColorConstant.antextGrayDark,
                                          fontSize: 11,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getVerticalSize(20),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.propertiesPage, arguments: [
                                              controller.profileModel?.appFormApproved == 0 ? false : true,
                                              controller.profileModel?.userCategory ?? "Owner"
                                            ]);
                                          },
                                          child: CommonImageView(
                                            imagePath: ImageConstant.mypropertiesIcon,
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(10),
                                        ),
                                        MyText(
                                          title: "My Properties",
                                          clr: ColorConstant.antextGrayDark,
                                          fontSize: 11,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (controller.profileModel?.appFormApproved == 0) {
                                              Utils.showToast(
                                                "Your application form is not approved yet, kindly wait for Approval",
                                                false,
                                              );
                                            } else {
                                              Get.toNamed(AppRoutes.myformsPage);
                                            }
                                          },
                                          child: CommonImageView(
                                            imagePath: ImageConstant.myOnlineIcon,
                                            height: 50,
                                            width: 51,
                                          ),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(10),
                                        ),
                                        MyText(
                                          title: "Online Forms",
                                          clr: ColorConstant.antextGrayDark,
                                          fontSize: 11,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (controller.profileModel?.appFormApproved == 0) {
                                              Utils.showToast(
                                                "Your application form is not approved yet, kindly wait for Approval",
                                                false,
                                              );
                                            } else {
                                              Get.toNamed(AppRoutes.downLoadFormsPage);
                                            }
                                          },
                                          child: CommonImageView(
                                            imagePath: ImageConstant.myDownloadIcon,
                                            height: 50,
                                            width: 50,
                                          ),
                                        ),
                                        SizedBox(
                                          height: getVerticalSize(10),
                                        ),
                                        MyText(
                                          title: "Download Forms",
                                          center: true,
                                          clr: ColorConstant.antextGrayDark,
                                          fontSize: 11,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: getVerticalSize(10),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            if (role == "Owner") {
                                              Get.toNamed(AppRoutes.formsList, arguments: "Owner Form");
                                            } else {
                                              Get.toNamed(AppRoutes.formsList, arguments: "Tenant Form");
                                            }
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
                                          title: "Application Forms",
                                          clr: ColorConstant.antextGrayDark,
                                          fontSize: 11,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getVerticalSize(20),
                        ),
                        Align(
                            alignment: Alignment.topLeft,
                            child: MyText(
                              title: "Quick View",
                              fontSize: 16.sp,
                              clr: ColorConstant.whiteA700,
                            )),
                        SizedBox(
                          height: getVerticalSize(10),
                        ),
                        GetBuilder(
                            init: controller,
                            builder: (context) {
                              return CustomExpansionTile(
                                ontap: () {
                                  log("message");
                                },
                                leading: CommonImageView(
                                  imagePath: ImageConstant.homeExpicon,
                                ),
                                title: MyText(
                                  title: 'My Profile',
                                  clr: ColorConstant.antextlightgray,
                                  fontSize: 14,
                                ),
                                subtitle: MyText(
                                  title: 'Update and modify your photo',
                                  clr: ColorConstant.antextlightgray,
                                  fontSize: 12,
                                ),
                                children: controller.profileModel != null
                                    ? <Widget>[
                                        ListTile(
                                          minTileHeight: 10,
                                          title: MyText(fontSize: 12.sp, title: "Name : ${controller.profileModel!.name}"),
                                        ),
                                        ListTile(
                                          minTileHeight: 10,
                                          title: MyText(fontSize: 12.sp, title: "Email : ${controller.profileModel!.email}"),
                                        ),
                                        ListTile(
                                          minTileHeight: 10,
                                          title: MyText(fontSize: 12.sp, title: "CNIC : ${controller.profileModel!.cnic}"),
                                        ),
                                        10.verticalSpace,
                                        InkWell(
                                          onTap: () {
                                            Get.toNamed(AppRoutes.myProfilePage);
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
                                      ]
                                    : [CircularProgressIndicator.adaptive()],
                              );
                            }),
                        SizedBox(
                          height: getVerticalSize(10),
                        ),
                        GetBuilder(
                            init: controller,
                            builder: (context) {
                              return CustomExpansionTile(
                                  leading: CommonImageView(
                                    imagePath: ImageConstant.homeExpicon1,
                                  ),
                                  title: MyText(
                                    title: 'My Bills',
                                    clr: ColorConstant.antextlightgray,
                                    fontSize: 14,
                                  ),
                                  subtitle: MyText(
                                    title: 'Update and modify your bills details',
                                    clr: ColorConstant.antextlightgray,
                                    fontSize: 12,
                                  ),
                                  children: buildBillsList(controller.billsStatus.value));
                            }),
                        SizedBox(
                          height: getVerticalSize(10),
                        ),
                        GetBuilder(
                            init: controller,
                            builder: (context) {
                              return CustomExpansionTile(
                                  leading: CommonImageView(
                                    imagePath: ImageConstant.homeExpicon2,
                                  ),
                                  title: MyText(
                                    title: 'My Complaints',
                                    clr: ColorConstant.antextlightgray,
                                    fontSize: 14,
                                  ),
                                  subtitle: MyText(
                                    title: 'Update and modify your complaints',
                                    clr: ColorConstant.antextlightgray,
                                    fontSize: 12,
                                  ),
                                  children: buildComplaintChildren(controller.complaintsStatus.value));
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> buildComplaintChildren(ApiCallStatus status) {
    final complaints = controller.complaints;

    switch (status) {
      case ApiCallStatus.empty:
        return [
          MyText(
            title: 'No Complaints found.',
            clr: ColorConstant.antextlightgray,
            fontSize: 14,
          ),
          10.verticalSpace,
        ];

      case ApiCallStatus.success:
        return [
          Column(
            children: [
              Container(
                child: DataTable(
                  horizontalMargin: 0,
                  columnSpacing: .2.sw,
                  dataRowMaxHeight: 50.0,
                  showBottomBorder: false,
                  dividerThickness: 0.0,
                  columns: const [
                    DataColumn(label: Text('Title')),
                    DataColumn(label: Text('Status')),
                  ],
                  rows: complaints!.data!.take(5).map((bill) {
                    return DataRow(
                      cells: [
                        DataCell(
                          SizedBox(
                            width: .5.sw,
                            child: MyText(
                              line: 1,
                              toverflow: TextOverflow.ellipsis,
                              title: "${bill.complaintType}",
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        DataCell(
                          Container(
                            padding: getPadding(left: 10, right: 10),
                            height: getVerticalSize(20),
                            decoration: BoxDecoration(
                              color: bill.status! == "Resolved"
                                  ? ColorConstant.appgreenColor
                                  : bill.status! == "Pending"
                                      ? ColorConstant.pendingColor
                                      : ColorConstant.assignedColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            alignment: Alignment.center,
                            child: MyText(
                              title: bill.status!,
                              fontSize: 9,
                              clr: ColorConstant.whiteA700,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          10.verticalSpace,
          InkWell(
            onTap: () {
              if (controller.profileModel?.appFormApproved == 0) {
                Utils.showToast(
                  "Your application form is not approved yet, kindly wait for Approval",
                  false,
                );
              } else {
                Get.toNamed(AppRoutes.myComplaintsPage);
              }
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
        ];
      case ApiCallStatus.error:
        return [
          MyText(
            title: "Something went wrong.",
            clr: ColorConstant.antextlightgray,
            fontSize: 14,
          ),
          10.verticalSpace,
        ];

      default:
        return [CircularProgressIndicator.adaptive()];
    }
  }

  List<Widget> buildBillsList(ApiCallStatus status) {
    switch (status) {
      case ApiCallStatus.empty:
        return [
          MyText(
            title: 'No Bills found.',
            clr: ColorConstant.antextlightgray,
            fontSize: 14,
          ),
          10.verticalSpace,
        ];

      case ApiCallStatus.success:
        return [
          Column(
            children: [
              Container(
                child: DataTable(
                  horizontalMargin: 0,
                  columnSpacing: .2.sw,
                  dataRowMaxHeight: 50.0,
                  showBottomBorder: false,
                  dividerThickness: 0.0,
                  columns: const [
                    DataColumn(label: Text('Month')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Status')),
                  ],
                  rows: controller.bills!.data!.take(5).map((bill) {
                    return DataRow(
                      cells: [
                        DataCell(
                          MyText(
                            title: "${bill.billMonth}",
                            fontSize: 12.sp,
                          ),
                        ),
                        DataCell(
                          MyText(
                            title: "${bill.beforeDueDateAmount}",
                            fontSize: 12.sp,
                          ),
                        ),
                        DataCell(
                          Container(
                            width: 60.w,
                            height: 20,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: bill.status! == "Paid"
                                  ? ColorConstant.appgreenColor
                                  : bill.status! == "Pending"
                                      ? ColorConstant.pendingColor
                                      : bill.status!.toLowerCase() == "review"
                                          ? Colors.grey
                                          : Colors.red,
                            ),
                            child: MyText(
                              title: "${bill.status}",
                              fontSize: 11.sp,
                              clr: ColorConstant.whiteA700,
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          10.verticalSpace,
          InkWell(
            onTap: () {
              if (controller.profileModel?.appFormApproved == 0) {
                Utils.showToast(
                  "Your application form is not approved yet, kindly wait for Approval",
                  false,
                );
              } else {
                Get.toNamed(AppRoutes.billsPage);
              }
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
        ];
      case ApiCallStatus.error:
        return [
          MyText(
            title: "Something went wrong.",
            clr: ColorConstant.antextlightgray,
            fontSize: 14,
          ),
          10.verticalSpace,
        ];
      default:
        return [CircularProgressIndicator.adaptive()];
    }
  }
}

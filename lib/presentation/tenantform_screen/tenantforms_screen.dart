import 'dart:developer';

import 'package:anchorageislamabad/core/utils/constants.dart';
import 'package:anchorageislamabad/core/utils/image_gallery.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/presentation/ownerform_screen/models/owner_form_model.dart';
import 'package:anchorageislamabad/theme/app_style.dart';
import 'package:anchorageislamabad/widgets/custom_image_view.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:csc_picker_plus/csc_picker_plus.dart';
// import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/size_utils.dart';
import '../../core/utils/utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/animated_custom_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dialogue.dart';
import '../../widgets/custom_expensiontile.dart';
import '../../widgets/custom_textfield_new.dart';
import 'controller/tenantforms_controller.dart';

class TenantFornsScreen extends StatefulWidget {
  @override
  State<TenantFornsScreen> createState() => _TenantFornsScreenState();
}

class _TenantFornsScreenState extends State<TenantFornsScreen> {
  TenantFornsScreenController controller = Get.put(TenantFornsScreenController());
  final ImageGalleryClass imageGalleryClass = ImageGalleryClass();

  final args = Get.arguments;
  int vehicleFormIndex = 0;

  bool isEditable = false;
  @override
  initState() {
    if ((args['status']) == Constants.formStatusRejected || args['status'] == "") {
      isEditable = true;
    }
    Future.delayed(Duration(), () {
      args['status'] != "" ? controller.getEntryFormsDetails(args['id']) : null;
      args['status'] != "" ? null : controller.addvehicleControllers();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hasPagePushed = Navigator.of(context).canPop();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/background.png'), // Replace 'assets/background_image.jpg' with your image path
          fit: BoxFit.cover, // Adjust as needed
        ),
      ),
      child: PopScope(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100.0,
            backgroundColor: Colors.transparent,
            title: MyText(
              title: "Tenant Forms",
              clr: ColorConstant.whiteA700,
              fontSize: 20.sp,
              customWeight: FontWeight.w500,
            ),
            centerTitle: true,
            leading: InkWell(
                onTap: () {
                  hasPagePushed
                      ? Get.back()
                      : showDialog(
                          context: context,
                          builder: (ct) {
                            return CustomDialogue(
                              dialogueBoxHeading: 'Exit'.tr,
                              dialogueBoxText: 'Are you sure want to Exit?'.tr,
                              actionOnNo: () {
                                Navigator.pop(ct);
                              },
                              actionOnYes: () {
                                SystemNavigator.pop();
                              },
                            );
                          });
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: getPadding(left: 10),
            child: Column(
              children: [
                GetBuilder(
                    init: controller,
                    builder: (_) {
                      if (args['status'] != "" && controller.formsLoadingStatus == ApiCallStatus.loading) {
                        return Column(
                          children: [
                            Center(
                                child: CircularProgressIndicator(
                              color: Colors.white,
                            )),
                          ],
                        );
                      } else {
                        return Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: getPadding(all: 10),
                              child: Form(
                                key: controller.formKey,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: MyText(
                                          title: "Record Form",
                                          fontSize: 16.sp,
                                          clr: ColorConstant.apppWhite,
                                        )),
                                    if (args['status'] == "Rejected")
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(7)),
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: MyText(
                                              title: "Rejection Reason : " + (controller.tenantFormModel.data?.rejection_reason ?? ""),
                                              fontSize: 20,
                                              clr: ColorConstant.apppWhite,
                                            )),
                                      ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    CustomExpansionTile(
                                      expanded: true,
                                      expand: true,
                                      title: MyText(
                                        title: 'PARTICULARS OF TENANT',
                                        clr: ColorConstant.black900,
                                        fontSize: 16.sp,
                                      ),
                                      children: <Widget>[
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomTextField(
                                              fieldText: "Full Name".tr,
                                              controller: controller.fullNameController,
                                              isFinal: false,
                                              enabled: isEditable,
                                              keyboardType: TextInputType.emailAddress,
                                              limit: HelperFunction.EMAIL_VALIDATION,
                                              validator: (value) {
                                                return HelperFunction.validateAlphabetsOnly(value!);
                                              },
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(5),
                                            ),
                                            CustomTextField(
                                              fieldText: "Father’s Name".tr,
                                              controller: controller.fathersController,
                                              isFinal: false,
                                              enabled: isEditable,
                                              keyboardType: TextInputType.emailAddress,
                                              limit: HelperFunction.EMAIL_VALIDATION,
                                              validator: (value) {
                                                return HelperFunction.validateAlphabetsOnly(value!);
                                              },
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(5),
                                            ),
                                            CustomTextField(
                                              fieldText: "Telephone No.".tr,
                                              controller: controller.telephoneController,
                                              isFinal: false,
                                              enabled: isEditable,
                                              keyboardType: TextInputType.phone,
                                              limit: HelperFunction.EMAIL_VALIDATION,
                                              validator: (value) {
                                                return HelperFunction.validatePakistaniPhoneNumber(value!);
                                              },
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(5),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 8.0, top: 5),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Nationality",
                                                          style: AppStyle.txtSourceSansProRegular16Gray600
                                                              .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                        ).paddingOnly(
                                                          left: 10,
                                                        ),
                                                        CSCPickerPlus(
                                                          currentCountry: controller.natinalityController.text,
                                                          countryDropdownLabel: "Select",
                                                          disableCountry: isEditable ? false : true,
                                                          disabledDropdownDecoration: BoxDecoration(
                                                            color: Colors.transparent,
                                                            border: Border(
                                                                bottom: BorderSide(width: .5, color: ColorConstant.appBorderGray.withOpacity(.3))),
                                                          ),
                                                          onCountryChanged: isEditable
                                                              ? (value) {
                                                                  controller.natinalityController.text = value;
                                                                }
                                                              : null,
                                                          dropdownHeadingStyle: TextStyle(color: ColorConstant.appBorderGray),
                                                          onCityChanged: (value) {},
                                                          onStateChanged: (value) {},
                                                          showCities: false,
                                                          showStates: false,
                                                          dropdownDecoration: BoxDecoration(
                                                              border: Border(bottom: BorderSide(width: .5, color: ColorConstant.appBorderGray)),
                                                              color: Colors.transparent,
                                                              borderRadius: BorderRadius.circular(00.0)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Block/COMM ",
                                                        style: AppStyle.txtSourceSansProRegular16Gray600
                                                            .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                      ).paddingOnly(
                                                        left: 0,
                                                      ),
                                                      DropdownButton(
                                                        isExpanded: true,
                                                        hint: controller.selectedValue == null
                                                            ? Text(
                                                                "Select",
                                                                style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                    fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                              )
                                                            : Text(controller.selectedValue.toString()),
                                                        value: controller.selectedValue,
                                                        items: controller.block.map((item) {
                                                          return DropdownMenuItem<int>(
                                                            value: item['id'],
                                                            child: Text(item['title']),
                                                          );
                                                        }).toList(),
                                                        onChanged: isEditable
                                                            ? (int? value) {
                                                                setState(() {
                                                                  controller.selectedValue = value!;
                                                                  controller.streetSelectedValue = null;
                                                                  controller.streets.clear();
                                                                  controller.plots.clear();
                                                                  controller.getStreetByBlock(value);
                                                                });
                                                              }
                                                            : null,
                                                      ),
                                                    ],
                                                  ).paddingOnly(left: 12),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(5),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GetBuilder(
                                                    init: controller,
                                                    builder: (_) {
                                                      return Expanded(
                                                          child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "Street",
                                                            style: AppStyle.txtSourceSansProRegular16Gray600
                                                                .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                          ).paddingOnly(
                                                            left: 14,
                                                          ),
                                                          DropdownButton<Street>(
                                                            isExpanded: true,
                                                            hint: controller.streetSelectedValue == null
                                                                ? Text(
                                                                    "Select",
                                                                    style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                        fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                                  )
                                                                : Text(controller.streetSelectedValue?.title?.toString() ?? ""),
                                                            value: controller.streetSelectedValue,
                                                            items: controller.streets.map((item) {
                                                              return DropdownMenuItem<Street>(
                                                                value: item,
                                                                child: Text(item.title.toString()),
                                                              );
                                                            }).toList(),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                controller.streetSelectedValue = value;
                                                                controller.plotstSelectedValue = null;
                                                                controller.plots.clear();
                                                                controller.getPlotNoByStreet(value!.id);
                                                              });
                                                            },
                                                          ).paddingOnly(left: 12),
                                                        ],
                                                      ));
                                                    }),
                                                GetBuilder(
                                                    init: controller,
                                                    builder: (_) {
                                                      return Expanded(
                                                          child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            "Plot",
                                                            style: AppStyle.txtSourceSansProRegular16Gray600
                                                                .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                          ).paddingOnly(
                                                            left: 14,
                                                          ),
                                                          DropdownButton<Plots>(
                                                            isExpanded: true,
                                                            hint: controller.plotstSelectedValue == null
                                                                ? Text(
                                                                    "Select",
                                                                    style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                        fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                                  )
                                                                : Text(controller.plotstSelectedValue?.title.toString() ?? ""),
                                                            value: controller.plotstSelectedValue,
                                                            items: controller.plots.map((item) {
                                                              return DropdownMenuItem<Plots>(
                                                                value: item,
                                                                child: Text(item.title.toString()),
                                                              );
                                                            }).toList(),
                                                            onChanged: (value) {
                                                              setState(() {
                                                                controller.plotstSelectedValue = value;
                                                                log(controller.plotstSelectedValue!.id.toString());
                                                                for (var i = 0; i < controller.plots.length; i++) {
                                                                  controller.plotstSelectedValue?.id == controller.plots[i].id;
                                                                  if (controller.plotstSelectedValue?.id == controller.plots[i].id) {
                                                                    controller.sizeHouseAddController.text = controller.plots[i].sq_yards.toString();
                                                                    log("Square yard found ${controller.sizeHouseAddController.text}");
                                                                    break;
                                                                  }
                                                                }
                                                              });
                                                            },
                                                          ).paddingOnly(left: 12),
                                                        ],
                                                      ));
                                                    })
                                              ],
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(5),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: CustomTextField(
                                                    fieldText: "CNIC".tr,
                                                    controller: controller.cnicController,
                                                    isFinal: false,
                                                    enabled: isEditable,
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.digitsOnly,
                                                      TextInputFormatterWithPattern('#####-#######-#'),
                                                    ],
                                                    limit: HelperFunction.EMAIL_VALIDATION,
                                                    validator: (value) {
                                                      return HelperFunction.cnicValidator(value!);
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomTextField(
                                                    fieldText: "Occupation".tr,
                                                    enabled: isEditable,
                                                    controller: controller.occupationController,
                                                    isFinal: false,
                                                    keyboardType: TextInputType.emailAddress,
                                                    validator: (value) {
                                                      return HelperFunction.empthyFieldValidator(value!);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(5),
                                            ),
                                            CustomTextField(
                                              fieldText: "Permanent Address.".tr,
                                              controller: controller.presentAddController,
                                              isFinal: false,
                                              enabled: isEditable,
                                              keyboardType: TextInputType.emailAddress,
                                              limit: HelperFunction.EMAIL_VALIDATION,
                                              validator: (value) {
                                                return HelperFunction.empthyFieldValidator(value!);
                                              },
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(5),
                                            ),
                                            CustomTextField(
                                              fieldText: "Size of House/ Plot".tr,
                                              controller: controller.sizeHouseAddController,
                                              isFinal: false,
                                              enabled: false,
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(20),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 0.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  MyText(
                                                    title: 'PARTICULARS OF OWNER',
                                                    clr: ColorConstant.black900,
                                                    fontSize: 16.sp,
                                                  ).paddingOnly(left: 15),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  CustomTextField(
                                                    fieldText: "Name".tr,
                                                    controller: controller.ownerNameController,
                                                    isFinal: false,
                                                    enabled: isEditable,
                                                    keyboardType: TextInputType.emailAddress,
                                                    limit: HelperFunction.EMAIL_VALIDATION,
                                                    validator: (value) {
                                                      return HelperFunction.validateAlphabetsOnly(value!);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  CustomTextField(
                                                    fieldText: "Telephone No".tr,
                                                    controller: controller.ownerPhoneController,
                                                    isFinal: false,
                                                    enabled: isEditable,
                                                    keyboardType: TextInputType.phone,
                                                    limit: HelperFunction.EMAIL_VALIDATION,
                                                    validator: (value) {
                                                      return HelperFunction.validatePakistaniPhoneNumber(value!);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  CustomTextField(
                                                    fieldText: "CNIC No".tr,
                                                    controller: controller.ownerCNICController,
                                                    isFinal: false,
                                                    enabled: isEditable,
                                                    keyboardType: TextInputType.number,
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter.digitsOnly,
                                                      TextInputFormatterWithPattern('#####-#######-#'),
                                                    ],
                                                    limit: HelperFunction.EMAIL_VALIDATION,
                                                    validator: (value) {
                                                      return HelperFunction.cnicValidator(value!);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  CustomTextField(
                                                    fieldText: "Present Address".tr,
                                                    controller: controller.ownerPresenttAddressController,
                                                    isFinal: false,
                                                    enabled: isEditable,
                                                    keyboardType: TextInputType.emailAddress,
                                                    limit: HelperFunction.EMAIL_VALIDATION,
                                                    validator: (value) {
                                                      return HelperFunction.validateAlphabetsOnly(value!);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  CustomTextField(
                                                    fieldText: "Permanent Address".tr,
                                                    controller: controller.ownerPermanentAddressController,
                                                    isFinal: false,
                                                    enabled: isEditable,
                                                    keyboardType: TextInputType.emailAddress,
                                                    limit: HelperFunction.EMAIL_VALIDATION,
                                                    validator: (value) {
                                                      return HelperFunction.validateAlphabetsOnly(value!);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(10),
                                                  ),
                                                  MyText(
                                                    clr: ColorConstant.gray600,
                                                    fontSize: 14,
                                                    title: "Size of House/Plot ",
                                                  ).paddingOnly(
                                                    left: 10,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                                    width: Get.width,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(12),
                                                        border: Border(bottom: BorderSide(color: ColorConstant.gray600))),
                                                    child: DropdownButton<String>(
                                                      underline: Container(
                                                        color: Colors.black,
                                                      ),
                                                      isExpanded: true,
                                                      hint: MyText(
                                                        title: "Select",
                                                        fontSize: 12,
                                                        clr: ColorConstant.gray600,
                                                      ),
                                                      value: controller.ownerHouseSize,
                                                      items: controller.ownerHousesSize.map((e) {
                                                        return DropdownMenuItem<String>(
                                                          value: e,
                                                          child: Text(
                                                            e,
                                                            style: TextStyle(fontSize: 12),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged: isEditable
                                                          ? (newValue) {
                                                              controller.ownerHouseSize = null;
                                                              controller.ownerHouseSize = newValue;
                                                              setState(() {});
                                                            }
                                                          : null,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(15),
                                            ),
                                            AbsorbPointer(
                                              absorbing: !isEditable,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  GetBuilder(
                                                      init: controller,
                                                      builder: (_) {
                                                        return Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Padding(
                                                                  padding: getPadding(
                                                                    left: 10,
                                                                  ),
                                                                  child: Text(
                                                                    "Allotment Letter held:",
                                                                    style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                        fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: getVerticalSize(10),
                                                                ),
                                                                Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    GetBuilder(
                                                                      init: controller,
                                                                      builder: (controller) {
                                                                        return GestureDetector(
                                                                          onTap: () {
                                                                            controller.updateAllotmentLetter("Yes");
                                                                          },
                                                                          child: Row(
                                                                            children: [
                                                                              controller.alottmentletter == "Yes"
                                                                                  ? Icon(
                                                                                      Icons.circle,
                                                                                      color: ColorConstant.blackColor,
                                                                                      size: 14,
                                                                                    )
                                                                                  : Icon(
                                                                                      Icons.circle_outlined,
                                                                                      color: ColorConstant.blackColor,
                                                                                      size: 14,
                                                                                    ),
                                                                              SizedBox(
                                                                                width: getHorizontalSize(10),
                                                                              ),
                                                                              Text(
                                                                                "Yes",
                                                                                style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                                    fontSize: 14,
                                                                                    color: ColorConstant.gray600,
                                                                                    fontWeight: FontWeight.normal),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                    GetBuilder(
                                                                      init: controller,
                                                                      builder: (controller) {
                                                                        return GestureDetector(
                                                                          onTap: () {
                                                                            controller.updateAllotmentLetter("No");
                                                                          },
                                                                          child: Row(
                                                                            children: [
                                                                              controller.alottmentletter == "No"
                                                                                  ? Icon(
                                                                                      Icons.circle,
                                                                                      color: ColorConstant.blackColor,
                                                                                      size: 14,
                                                                                    )
                                                                                  : Icon(
                                                                                      Icons.circle_outlined,
                                                                                      color: ColorConstant.blackColor,
                                                                                      size: 14,
                                                                                    ),
                                                                              SizedBox(
                                                                                width: getHorizontalSize(10),
                                                                              ),
                                                                              Text(
                                                                                "No",
                                                                                style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                                    fontSize: 14,
                                                                                    color: ColorConstant.gray600,
                                                                                    fontWeight: FontWeight.normal),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ],
                                                                ).paddingOnly(left: 14),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: getVerticalSize(10),
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(5),
                                            ),
                                            AbsorbPointer(
                                              absorbing: !isEditable,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  GetBuilder(
                                                      init: controller,
                                                      builder: (_) {
                                                        return Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Container(
                                                                  width: .5.sw,
                                                                  child: Padding(
                                                                    padding: getPadding(left: 0.w),
                                                                    child: Text(
                                                                      "Completion certificate held:",
                                                                      style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                          fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: getVerticalSize(10),
                                                                ),
                                                                GetBuilder(
                                                                  init: controller,
                                                                  builder: (controller) {
                                                                    return GestureDetector(
                                                                      onTap: () {
                                                                        controller.updateCompletionCertificate("Yes");
                                                                      },
                                                                      child: Row(
                                                                        children: [
                                                                          controller.completionCertificate == "Yes"
                                                                              ? Icon(
                                                                                  Icons.circle,
                                                                                  color: ColorConstant.blackColor,
                                                                                  size: 14.r,
                                                                                )
                                                                              : Icon(
                                                                                  Icons.circle_outlined,
                                                                                  color: ColorConstant.blackColor,
                                                                                  size: 14,
                                                                                ),
                                                                          SizedBox(
                                                                            width: getHorizontalSize(10.w),
                                                                          ),
                                                                          Text(
                                                                            "Yes",
                                                                            style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                                fontSize: 15,
                                                                                color: ColorConstant.gray600,
                                                                                fontWeight: FontWeight.normal),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                                SizedBox(
                                                                  width: getHorizontalSize(20),
                                                                ),
                                                                GetBuilder(
                                                                  init: controller,
                                                                  builder: (controller) {
                                                                    return GestureDetector(
                                                                      onTap: () {
                                                                        controller.updateCompletionCertificate("No");
                                                                      },
                                                                      child: Row(
                                                                        children: [
                                                                          controller.completionCertificate == "No"
                                                                              ? Icon(
                                                                                  Icons.circle,
                                                                                  color: ColorConstant.blackColor,
                                                                                  size: 14,
                                                                                )
                                                                              : Icon(
                                                                                  Icons.circle_outlined,
                                                                                  color: ColorConstant.blackColor,
                                                                                  size: 14,
                                                                                ),
                                                                          SizedBox(
                                                                            width: getHorizontalSize(10),
                                                                          ),
                                                                          Text(
                                                                            "No",
                                                                            style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                                fontSize: 15,
                                                                                color: ColorConstant.gray600,
                                                                                fontWeight: FontWeight.normal),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ).paddingOnly(left: 10),
                                                            SizedBox(
                                                              height: getVerticalSize(20),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () async {
                                                                await showDialog(
                                                                  context: context,
                                                                  barrierDismissible: false,
                                                                  builder: (_) => SingleChildScrollView(
                                                                    child: AlertDialog(
                                                                      insetPadding: EdgeInsets.symmetric(
                                                                        horizontal: 10,
                                                                      ),
                                                                      backgroundColor: Colors.transparent,
                                                                      shadowColor: Colors.transparent,
                                                                      surfaceTintColor: Colors.transparent,
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(25),
                                                                      ),
                                                                      actions: [
                                                                        Container(
                                                                            padding: EdgeInsets.all(15),
                                                                            // height: MediaQuery.of(context).size.speight,
                                                                            // width: MediaQuery.of(context).size.width,
                                                                            decoration: BoxDecoration(
                                                                                border: Border.all(color: Colors.white),
                                                                                borderRadius: BorderRadius.circular(10),
                                                                                color: Color(0xffFFFFFF)),
                                                                            child: Column(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Text(
                                                                                      "Declaration by the Tenant",
                                                                                      textAlign: TextAlign.left,
                                                                                      style:
                                                                                          TextStyle(fontSize: 18.sp, color: ColorConstant.blackColor),
                                                                                    ),
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Icon(
                                                                                        Icons.close_sharp,
                                                                                        color: ColorConstant.gray600,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                                Divider(
                                                                                  height: 30,
                                                                                  color: ColorConstant.appTextGray.withOpacity(.7),
                                                                                ),
                                                                                RichText(
                                                                                  text: TextSpan(
                                                                                    text: 'I ',
                                                                                    style: TextStyle(
                                                                                      fontSize: 11.sp,
                                                                                      color: ColorConstant.greyColor,
                                                                                      decoration: TextDecoration.none,
                                                                                    ),
                                                                                    children: <TextSpan>[
                                                                                      TextSpan(
                                                                                          text: controller.fullNameController.text.capitalize
                                                                                              .toString(),
                                                                                          style: TextStyle(
                                                                                              fontSize: 11.sp,
                                                                                              color: ColorConstant.greyColor,
                                                                                              decoration: TextDecoration.none,
                                                                                              fontWeight: FontWeight.bold)),
                                                                                      TextSpan(
                                                                                          text: ' S/O or D/O ',
                                                                                          style: TextStyle(
                                                                                            fontSize: 11.sp,
                                                                                            color: ColorConstant.greyColor,
                                                                                            decoration: TextDecoration.none,
                                                                                          )),
                                                                                      TextSpan(
                                                                                          text:
                                                                                              controller.fathersController.text.capitalize.toString(),
                                                                                          style: TextStyle(
                                                                                              fontSize: 11.sp,
                                                                                              color: ColorConstant.greyColor,
                                                                                              decoration: TextDecoration.none,
                                                                                              fontWeight: FontWeight.bold)),
                                                                                      TextSpan(
                                                                                          text: ' CNIC NO: ',
                                                                                          style: TextStyle(
                                                                                            fontSize: 11.sp,
                                                                                            color: ColorConstant.greyColor,
                                                                                            decoration: TextDecoration.none,
                                                                                          )),
                                                                                      TextSpan(
                                                                                          text: controller.cnicController.text.capitalize.toString(),
                                                                                          style: TextStyle(
                                                                                              fontSize: 11.sp,
                                                                                              color: ColorConstant.greyColor,
                                                                                              decoration: TextDecoration.none,
                                                                                              fontWeight: FontWeight.bold)),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Text(
                                                                                  Constants.agreementText,
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(fontSize: 12.sp, color: ColorConstant.greyColor),
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                  children: [
                                                                                    GestureDetector(
                                                                                      onTap: () {
                                                                                        Get.back();
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          borderRadius: BorderRadius.circular(7),
                                                                                          color: ColorConstant.gray600,
                                                                                        ),
                                                                                        child: Text(
                                                                                          "Close",
                                                                                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                                                                                        ).paddingSymmetric(horizontal: 15, vertical: 10),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                )
                                                                              ],
                                                                            )),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: MyText(
                                                                title: 'Survey Declaration',
                                                                clr: Color(0xff007BFF),
                                                                fontSize: 16.sp,
                                                              ).paddingOnly(left: 15),
                                                            ),
                                                          ],
                                                        );
                                                      }),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: getVerticalSize(15),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    CustomExpansionTile(
                                      expanded: true,
                                      expand: true,
                                      title: MyText(
                                        title: 'PRIVATE ARMS',
                                        clr: ColorConstant.black900,
                                        fontSize: 16.sp,
                                      ),
                                      children: <Widget>[
                                        GetBuilder(
                                            init: controller,
                                            builder: (_) {
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AbsorbPointer(
                                                    absorbing: !isEditable,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: getPadding(left: 10),
                                                          child: MyText(
                                                            title: "PRIVATE ARMS*:",
                                                            clr: ColorConstant.antextlightgray,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: getHorizontalSize(20),
                                                        ),
                                                        GetBuilder(
                                                          init: controller,
                                                          builder: (controller) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                controller.updatePrivatearms("Yes");
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  controller.privatearms == "Yes"
                                                                      ? Icon(
                                                                          Icons.circle,
                                                                          color: ColorConstant.blackColor,
                                                                          size: 14,
                                                                        )
                                                                      : Icon(
                                                                          Icons.circle_outlined,
                                                                          color: ColorConstant.blackColor,
                                                                          size: 14,
                                                                        ),
                                                                  SizedBox(
                                                                    width: getHorizontalSize(10),
                                                                  ),
                                                                  Text(
                                                                    "Yes",
                                                                    style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                        fontSize: 15, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: getHorizontalSize(20),
                                                        ),
                                                        GetBuilder(
                                                          init: controller,
                                                          builder: (controller) {
                                                            return GestureDetector(
                                                              onTap: () {
                                                                controller.updatePrivatearms("No");
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  controller.privatearms == "No"
                                                                      ? Icon(
                                                                          Icons.circle,
                                                                          color: ColorConstant.blackColor,
                                                                          size: 14,
                                                                        )
                                                                      : Icon(
                                                                          Icons.circle_outlined,
                                                                          color: ColorConstant.blackColor,
                                                                          size: 14,
                                                                        ),
                                                                  SizedBox(
                                                                    width: getHorizontalSize(10),
                                                                  ),
                                                                  Text(
                                                                    "No",
                                                                    style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                        fontSize: 15, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  controller.privatearms == "Yes"
                                                      ? Column(
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: CustomTextField(
                                                                    fieldText: "License Number".tr,
                                                                    controller: controller.privateLicenseController,
                                                                    isFinal: false,
                                                                    enabled: isEditable,
                                                                    keyboardType: TextInputType.emailAddress,
                                                                    limit: HelperFunction.EMAIL_VALIDATION,
                                                                    validator: (value) {
                                                                      return HelperFunction.empthyFieldValidator(value!);
                                                                    },
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: CustomTextField(
                                                                    fieldText: "Arms Quantity".tr,
                                                                    controller: controller.privateArmsController,
                                                                    isFinal: false,
                                                                    enabled: isEditable,
                                                                    keyboardType: TextInputType.phone,
                                                                    validator: (value) {
                                                                      return HelperFunction.empthyFieldValidator(value!);
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: getVerticalSize(5),
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child: CustomTextField(
                                                                    fieldText: "Ammunition Quantity".tr,
                                                                    controller: controller.privateAmmunitionController,
                                                                    isFinal: false,
                                                                    enabled: isEditable,
                                                                    keyboardType: TextInputType.emailAddress,
                                                                    limit: HelperFunction.EMAIL_VALIDATION,
                                                                    validator: (value) {
                                                                      return HelperFunction.empthyFieldValidator(value!);
                                                                    },
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child: CustomTextField(
                                                                    fieldText: "Bore/Type".tr,
                                                                    controller: controller.privateBoreController,
                                                                    isFinal: false,
                                                                    enabled: isEditable,
                                                                    keyboardType: TextInputType.emailAddress,
                                                                    validator: (value) {
                                                                      return HelperFunction.empthyFieldValidator(value!);
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: getVerticalSize(5),
                                                            ),
                                                            SizedBox(
                                                              height: getVerticalSize(20),
                                                            ),
                                                          ],
                                                        )
                                                      : Column(),
                                                ],
                                              );
                                            })
                                      ],
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    CustomExpansionTile(
                                      expanded: true,
                                      expand: true,
                                      title: MyText(
                                        title: 'Vehicles Information',
                                        clr: ColorConstant.black900,
                                        fontSize: 16,
                                      ),
                                      children: <Widget>[
                                        GetBuilder(
                                            init: controller,
                                            builder: (context) {
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  AbsorbPointer(
                                                    absorbing: !isEditable,
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: getPadding(left: 10),
                                                          child: MyText(
                                                            title: "VEHICLE(s) IN USE",
                                                            clr: ColorConstant.antextlightgray,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: getHorizontalSize(20),
                                                        ),
                                                        GetBuilder(
                                                          init: controller,
                                                          builder: (controller) {
                                                            return GestureDetector(
                                                              behavior: HitTestBehavior.opaque,
                                                              onTap: () {
                                                                controller.updateVehicle("Yes");
                                                                if (args['status'] == Constants.formStatusRejected) {
                                                                  setState(() {
                                                                    controller.eTag.add("");
                                                                    controller.tenantFormModel.data?.vehicle = [Vehicle()];
                                                                    controller.vehicleFormKey.add(GlobalKey());
                                                                  });
                                                                }
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  controller.hasVehicle == "Yes"
                                                                      ? Icon(
                                                                          Icons.circle,
                                                                          color: ColorConstant.blackColor,
                                                                          size: 14,
                                                                        )
                                                                      : Icon(
                                                                          Icons.circle_outlined,
                                                                          color: ColorConstant.blackColor,
                                                                          size: 14,
                                                                        ),
                                                                  SizedBox(
                                                                    width: getHorizontalSize(10),
                                                                  ),
                                                                  Text(
                                                                    "Yes",
                                                                    style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                        fontSize: 16, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: getHorizontalSize(20),
                                                        ),
                                                        GetBuilder(
                                                          init: controller,
                                                          builder: (controller) {
                                                            return GestureDetector(
                                                              behavior: HitTestBehavior.opaque,
                                                              onTap: () {
                                                                controller.updateVehicle("No");
                                                                if (args['status'] == Constants.formStatusRejected) {
                                                                  setState(() {
                                                                    controller.eTag.clear();
                                                                    controller.tenantFormModel.data?.vehicle = null;
                                                                    controller.vehicleFormKey.clear();
                                                                  });
                                                                }
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  controller.hasVehicle == "No"
                                                                      ? Icon(
                                                                          Icons.circle,
                                                                          color: ColorConstant.blackColor,
                                                                          size: 14,
                                                                        )
                                                                      : Icon(
                                                                          Icons.circle_outlined,
                                                                          color: ColorConstant.blackColor,
                                                                          size: 14,
                                                                        ),
                                                                  SizedBox(
                                                                    width: getHorizontalSize(10),
                                                                  ),
                                                                  Text(
                                                                    "No",
                                                                    style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                        fontSize: 16, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  controller.hasVehicle == "Yes"
                                                      ? ListView.builder(
                                                          physics: NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          padding: EdgeInsets.zero,
                                                          itemCount: args['status'] != ""
                                                              ? (controller.tenantFormModel.data?.vehicle?.length ?? 0) +
                                                                  (args['status'] == Constants.formStatusRejected ? 1 : 0)
                                                              : controller.vehicleTypeControllers.length + 1,
                                                          itemBuilder: (context, index) {
                                                            vehicleFormIndex = index;
                                                            bool isLastIndex = index ==
                                                                (args['status'] != ""
                                                                    ? (controller.tenantFormModel.data?.vehicle?.length ?? 0)
                                                                    : controller.vehicleTypeControllers.length);

                                                            if (isLastIndex &&
                                                                (args['status'] == Constants.formStatusRejected || args['status'] == "")) {
                                                              return Padding(
                                                                padding: getPadding(left: 10, right: 10, top: 20, bottom: 10),
                                                                child: MyAnimatedButton(
                                                                  radius: 5.0,
                                                                  height: getVerticalSize(50),
                                                                  width: getHorizontalSize(400),
                                                                  fontSize: 16,
                                                                  bgColor: ColorConstant.anbtnBlue,
                                                                  controller: controller.uselessbtnController,
                                                                  title: "Add Vehicle".tr,
                                                                  onTap: () async {
                                                                    final formKey = controller.vehicleFormKey[index - 1];
                                                                    final formState = formKey.currentState;

                                                                    if (args['status'] == Constants.formStatusRejected) {
                                                                      if (formState != null && formState.validate()) {
                                                                        controller.eTag.add("");
                                                                        controller.tenantFormModel.data?.vehicle?.add(Vehicle());
                                                                        controller.vehicleFormKey.add(GlobalKey<FormState>());
                                                                        controller.update();
                                                                      }
                                                                    } else {
                                                                      controller.vehicleFormKey.add(GlobalKey<FormState>());
                                                                      controller.addvehicle(context, index - 1);
                                                                    }
                                                                  },
                                                                ),
                                                              );
                                                            }
                                                            Vehicle? detail;
                                                            if ((controller.tenantFormModel.data?.vehicle?.length ?? 0) > 0 &&
                                                                index < (controller.tenantFormModel.data?.vehicle?.length ?? 0)) {
                                                              detail = controller.tenantFormModel.data?.vehicle?[index];
                                                            }

                                                            return Form(
                                                              key: controller.vehicleFormKey[index],
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  if (index != 0)
                                                                    if (args['status'] != Constants.formStatusPending)
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap: () {
                                                                              setState(() {
                                                                                if (args['status'] == Constants.formStatusRejected) {
                                                                                  controller.eTag.removeAt(index);

                                                                                  controller.tenantFormModel.data?.vehicle?.removeAt(index);
                                                                                } else {
                                                                                  controller.vehicleTypeControllers.removeAt(index);
                                                                                }
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                                margin: EdgeInsets.only(right: 15),
                                                                                padding: EdgeInsets.all(8),
                                                                                decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                                                                child: Icon(
                                                                                  Icons.delete_outlined,
                                                                                  color: Colors.white,
                                                                                )),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                  MyText(
                                                                    title: 'Vehicle ${index + 1}',
                                                                    clr: ColorConstant.black900,
                                                                    fontSize: 16,
                                                                  ).paddingOnly(left: 10, bottom: 6, top: 7),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        child: CustomTextField(
                                                                          enabled: isEditable,
                                                                          fieldText: "Vehicle Type".tr,
                                                                          controller: args['status'] == Constants.formStatusRejected
                                                                              ? detail?.vehicleTypeController
                                                                              : controller.vehicleTypeControllers[index],
                                                                          isFinal: false,
                                                                          keyboardType: TextInputType.emailAddress,
                                                                          limit: HelperFunction.EMAIL_VALIDATION,
                                                                          validator: (value) {
                                                                            return HelperFunction.empthyFieldValidator(value!);
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child: CustomTextField(
                                                                          enabled: isEditable,
                                                                          fieldText: "Registration No.".tr,
                                                                          controller: args['status'] == Constants.formStatusRejected
                                                                              ? detail?.registrationController
                                                                              : controller.vehicleRegisterNoControllers[index],
                                                                          isFinal: false,
                                                                          keyboardType: TextInputType.emailAddress,
                                                                          validator: (value) {
                                                                            return HelperFunction.empthyFieldValidator(value!);
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: getVerticalSize(5),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      Expanded(
                                                                        child: CustomTextField(
                                                                          enabled: isEditable,
                                                                          fieldText: "Color".tr,
                                                                          controller: args['status'] == Constants.formStatusRejected
                                                                              ? detail?.colorController
                                                                              : controller.vehicleColorControllers[index],
                                                                          isFinal: false,
                                                                          keyboardType: TextInputType.emailAddress,
                                                                          limit: HelperFunction.EMAIL_VALIDATION,
                                                                          validator: (value) {
                                                                            return HelperFunction.empthyFieldValidator(value!);
                                                                          },
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child: CustomTextField(
                                                                          enabled: isEditable,
                                                                          fieldText: "Sticker No.".tr,
                                                                          controller: args['status'] == Constants.formStatusRejected
                                                                              ? detail?.stickerNoController
                                                                              : controller.vehicleStikerControllers[index],
                                                                          isFinal: false,
                                                                          keyboardType: TextInputType.emailAddress,
                                                                          validator: (value) {
                                                                            return HelperFunction.empthyFieldValidator(value!);
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: getVerticalSize(15),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding: getPadding(left: 10),
                                                                        child: MyText(
                                                                          title: "E-Tag",
                                                                          clr: ColorConstant.antextlightgray,
                                                                          fontSize: 14,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: getHorizontalSize(20),
                                                                      ),
                                                                      AbsorbPointer(
                                                                        absorbing: !isEditable,
                                                                        child: GetBuilder(
                                                                          init: controller,
                                                                          builder: (controller) {
                                                                            return GestureDetector(
                                                                              behavior: HitTestBehavior.opaque,
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  controller.eTag[index] = "Yes";
                                                                                });

                                                                                log(controller.eTag.toString());
                                                                              },
                                                                              child: Row(
                                                                                children: [
                                                                                  controller.eTag[index] == "Yes"
                                                                                      ? Icon(
                                                                                          Icons.circle,
                                                                                          color: ColorConstant.blackColor,
                                                                                          size: 14,
                                                                                        )
                                                                                      : Icon(
                                                                                          Icons.circle_outlined,
                                                                                          color: ColorConstant.blackColor,
                                                                                          size: 14,
                                                                                        ),
                                                                                  SizedBox(
                                                                                    width: getHorizontalSize(10),
                                                                                  ),
                                                                                  Text(
                                                                                    "Yes",
                                                                                    style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                                        fontSize: 15,
                                                                                        color: ColorConstant.gray600,
                                                                                        fontWeight: FontWeight.normal),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: getHorizontalSize(20),
                                                                      ),
                                                                      GetBuilder(
                                                                        init: controller,
                                                                        builder: (controller) {
                                                                          return GestureDetector(
                                                                            behavior: HitTestBehavior.opaque,
                                                                            onTap: () {
                                                                              setState(() {
                                                                                controller.eTag[index] = "No";
                                                                              });

                                                                              // controller.updateEtag("No");
                                                                            },
                                                                            child: Row(
                                                                              children: [
                                                                                controller.eTag[index] == "No"
                                                                                    ? Icon(
                                                                                        Icons.circle,
                                                                                        color: ColorConstant.blackColor,
                                                                                        size: 14,
                                                                                      )
                                                                                    : Icon(
                                                                                        Icons.circle_outlined,
                                                                                        color: ColorConstant.blackColor,
                                                                                        size: 14,
                                                                                      ),
                                                                                SizedBox(
                                                                                  width: getHorizontalSize(10),
                                                                                ),
                                                                                Text(
                                                                                  "No",
                                                                                  style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                                      fontSize: 15,
                                                                                      color: ColorConstant.gray600,
                                                                                      fontWeight: FontWeight.normal),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: getVerticalSize(5),
                                                                  ),
                                                                  SizedBox(
                                                                    height: getVerticalSize(15),
                                                                  ),
                                                                  // if (args['status'] == "")
                                                                  //   Padding(
                                                                  //     padding: getPadding(left: 10, right: 10),
                                                                  //     child: MyAnimatedButton(
                                                                  //       radius: 5.0,
                                                                  //       height: getVerticalSize(50),
                                                                  //       width: getHorizontalSize(400),
                                                                  //       fontSize: 16.h,
                                                                  //       bgColor: ColorConstant.anbtnBlue,
                                                                  //       controller: controller.uselessbtnController,
                                                                  //       title: "Add Vehicle".tr,
                                                                  //       onTap: () async {
                                                                  //         controller.addvehicle(context, index);
                                                                  //       },
                                                                  //     ),
                                                                  //   ),
                                                                  // SizedBox(
                                                                  //   height: getVerticalSize(15),
                                                                  // ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                        )
                                                      : Column(),
                                                ],
                                              );
                                            })
                                      ],
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: MyText(
                                          title: "Required Documents",
                                          fontSize: 22.sp,
                                        )),
                                    SizedBox(
                                      height: getVerticalSize(10),
                                    ),
                                    CustomExpansionTile(
                                      expanded: true,
                                      title: MyText(
                                        title: 'Required Documents',
                                        clr: ColorConstant.black900,
                                        fontSize: 16.sp,
                                      ),
                                      children: <Widget>[
                                        GetBuilder(
                                            init: controller,
                                            builder: (_) {
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: getPadding(left: 10),
                                                    child: MyText(
                                                      title: "Requirements:",
                                                      clr: ColorConstant.antextlightgray,
                                                      fontSize: 15.sp,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  if (args['status'] != "")
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        MyText(title: "Owner CNIC").paddingOnly(left: 10),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(left: 10, right: 10),
                                                          child: Container(
                                                            width: getHorizontalSize(350),
                                                            color: ColorConstant.whiteA700,
                                                            child: CustomImageView(
                                                              radius: BorderRadius.circular(6),
                                                              border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                              url: controller.tenantFormModel.data?.ownerCnicUrl?.cnicFront ?? "",
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(left: 10, right: 10),
                                                          child: Container(
                                                            width: getHorizontalSize(350),
                                                            color: ColorConstant.whiteA700,
                                                            child: CustomImageView(
                                                              radius: BorderRadius.circular(6),
                                                              border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                              url: controller.tenantFormModel.data?.ownerCnicUrl?.cnicBack ?? "",
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                      ],
                                                    ),
                                                  if (isEditable)
                                                    Padding(
                                                      padding: getPadding(left: 10, right: 10),
                                                      child: CustomButton(
                                                        width: getHorizontalSize(350),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w700,
                                                        color: ColorConstant.whiteA700,
                                                        label: "CNIC OF OWNER (FRONT & BACK)*".tr,
                                                        textColor: ColorConstant.anbtnBlue,
                                                        borderColor: ColorConstant.anbtnBlue,
                                                        prefix: Icon(
                                                          controller.ownerCnicFrontBack != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                          color: ColorConstant.anbtnBlue,
                                                        ),
                                                        onPressed: () async {
                                                          controller.ownerCnicFrontBack = await controller.getImages(context);
                                                        },
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  if (args['status'] != "")
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        MyText(title: "Tenant CNIC").paddingOnly(left: 10),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(left: 10, right: 10),
                                                          child: Container(
                                                            width: getHorizontalSize(350),
                                                            color: ColorConstant.whiteA700,
                                                            child: CustomImageView(
                                                              radius: BorderRadius.circular(6),
                                                              border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                              url: controller.tenantFormModel.data?.tenantCnicUrl?.cnicFront ?? "",
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(left: 10, right: 10),
                                                          child: Container(
                                                            width: getHorizontalSize(350),
                                                            color: ColorConstant.whiteA700,
                                                            child: CustomImageView(
                                                              radius: BorderRadius.circular(6),
                                                              border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                              url: controller.tenantFormModel.data?.tenantCnicUrl?.cnicBack ?? "",
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                      ],
                                                    ),
                                                  if (isEditable)
                                                    Padding(
                                                      padding: getPadding(left: 10, right: 10),
                                                      child: CustomButton(
                                                        width: getHorizontalSize(350),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w700,
                                                        color: ColorConstant.whiteA700,
                                                        label: "CNIC OF TENANT (FRONT & BACK)*".tr,
                                                        textColor: ColorConstant.anbtnBlue,
                                                        borderColor: ColorConstant.anbtnBlue,
                                                        prefix: Icon(
                                                          controller.tenantCnicFrontBack != null
                                                              ? Icons.check_circle_sharp
                                                              : Icons.add_circle_outline,
                                                          color: ColorConstant.anbtnBlue,
                                                        ),
                                                        onPressed: () async {
                                                          controller.tenantCnicFrontBack = await controller.getImages(context);
                                                        },
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  if (args['status'] != "")
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        MyText(title: "Agent CNIC").paddingOnly(left: 10),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(left: 10, right: 10),
                                                          child: Container(
                                                            width: getHorizontalSize(350),
                                                            color: ColorConstant.whiteA700,
                                                            child: CustomImageView(
                                                              radius: BorderRadius.circular(6),
                                                              border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                              url: controller.tenantFormModel.data?.agentCnicUrl?.cnicFront ?? "",
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(left: 10, right: 10),
                                                          child: Container(
                                                            width: getHorizontalSize(350),
                                                            color: ColorConstant.whiteA700,
                                                            child: CustomImageView(
                                                              radius: BorderRadius.circular(6),
                                                              border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                              url: controller.tenantFormModel.data?.agentCnicUrl?.cnicBack ?? "",
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                      ],
                                                    ),
                                                  if (isEditable)
                                                    Padding(
                                                      padding: getPadding(left: 10, right: 10),
                                                      child: CustomButton(
                                                        width: getHorizontalSize(350),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w700,
                                                        color: ColorConstant.whiteA700,
                                                        label: "CNIC OF AGENT (FRONT & BACK)".tr,
                                                        textColor: ColorConstant.anbtnBlue,
                                                        borderColor: ColorConstant.anbtnBlue,
                                                        prefix: Icon(
                                                          controller.estateCnicFrontBack != null
                                                              ? Icons.check_circle_sharp
                                                              : Icons.add_circle_outline,
                                                          color: ColorConstant.anbtnBlue,
                                                        ),
                                                        onPressed: () async {
                                                          controller.estateCnicFrontBack = await controller.getImages(context);
                                                        },
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  if (args['status'] != "")
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        MyText(title: "Tenant Image").paddingOnly(left: 10),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(left: 10, right: 10),
                                                          child: Container(
                                                            width: getHorizontalSize(350),
                                                            color: ColorConstant.whiteA700,
                                                            child: CustomImageView(
                                                              radius: BorderRadius.circular(6),
                                                              border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                              url: controller.tenantFormModel.data?.tenantImageUrl ?? "",
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                      ],
                                                    ),
                                                  if (isEditable)
                                                    Padding(
                                                      padding: getPadding(left: 10, right: 10),
                                                      child: CustomButton(
                                                        width: getHorizontalSize(350),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w700,
                                                        color: ColorConstant.whiteA700,
                                                        label: "PHOTOGRAPH OF TENANT*".tr,
                                                        textColor: ColorConstant.anbtnBlue,
                                                        borderColor: ColorConstant.anbtnBlue,
                                                        prefix: Icon(
                                                          controller.tenantPhoto != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                          color: ColorConstant.anbtnBlue,
                                                        ),
                                                        onPressed: () async {
                                                          imageGalleryClass.imageGalleryBottomSheet(
                                                            context: context,
                                                            onCameraTap: () async {
                                                              controller.tenantPhoto = await imageGalleryClass.getImage(ImageSource.camera);
                                                              setState(() {});
                                                              Get.back();
                                                            },
                                                            onGalleryTap: () async {
                                                              controller.tenantPhoto = await imageGalleryClass.getImage(ImageSource.gallery);
                                                              setState(() {});
                                                              Get.back();
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  if (args['status'] != "")
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        MyText(title: "Agreement Image").paddingOnly(left: 10),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(left: 10, right: 10),
                                                          child: Container(
                                                            width: getHorizontalSize(350),
                                                            color: ColorConstant.whiteA700,
                                                            child: CustomImageView(
                                                              radius: BorderRadius.circular(6),
                                                              border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                              url: controller.tenantFormModel.data?.agreementImageUrl ?? "",
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                      ],
                                                    ),
                                                  if (isEditable)
                                                    Padding(
                                                      padding: getPadding(left: 10, right: 10),
                                                      child: CustomButton(
                                                        width: getHorizontalSize(350),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w700,
                                                        color: ColorConstant.whiteA700,
                                                        label: "RENT AGREEMENT DULLY SIGNED*".tr,
                                                        textColor: ColorConstant.anbtnBlue,
                                                        borderColor: ColorConstant.anbtnBlue,
                                                        prefix: Icon(
                                                          controller.rentAgreement != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                          color: ColorConstant.anbtnBlue,
                                                        ),
                                                        onPressed: () async {
                                                          controller.rentAgreement = null;

                                                          imageGalleryClass.imageGalleryBottomSheet(
                                                            context: context,
                                                            onCameraTap: () async {
                                                              controller.rentAgreement = await imageGalleryClass.getImage(ImageSource.camera);
                                                              setState(() {});
                                                              Get.back();
                                                            },
                                                            onGalleryTap: () async {
                                                              controller.rentAgreement = await imageGalleryClass.getImage(ImageSource.gallery);
                                                              setState(() {});
                                                              Get.back();
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  if (args['status'] != "")
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        MyText(title: "Police Registration Form Image").paddingOnly(left: 10),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(left: 10, right: 10),
                                                          child: Container(
                                                            width: getHorizontalSize(350),
                                                            color: ColorConstant.whiteA700,
                                                            child: CustomImageView(
                                                              radius: BorderRadius.circular(6),
                                                              border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                              url: controller.tenantFormModel.data?.policeRegistrationUrl ?? "",
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                      ],
                                                    ),
                                                  if (isEditable)
                                                    Padding(
                                                      padding: getPadding(left: 10, right: 10),
                                                      child: CustomButton(
                                                        width: getHorizontalSize(350),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w700,
                                                        color: ColorConstant.whiteA700,
                                                        label: "POLICE REGISTRATION FROM *".tr,
                                                        textColor: ColorConstant.anbtnBlue,
                                                        borderColor: ColorConstant.anbtnBlue,
                                                        prefix: Icon(
                                                          controller.policeForm != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                          color: ColorConstant.anbtnBlue,
                                                        ),
                                                        onPressed: () async {
                                                          controller.policeForm = null;

                                                          imageGalleryClass.imageGalleryBottomSheet(
                                                            context: context,
                                                            onCameraTap: () async {
                                                              controller.policeForm = await imageGalleryClass.getImage(ImageSource.camera);
                                                              setState(() {});
                                                              Get.back();
                                                            },
                                                            onGalleryTap: () async {
                                                              controller.policeForm = await imageGalleryClass.getImage(ImageSource.gallery);
                                                              setState(() {});
                                                              Get.back();
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  if (args['status'] != "")
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        MyText(title: "Completion Certificate Image").paddingOnly(left: 10),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                        Padding(
                                                          padding: getPadding(left: 10, right: 10),
                                                          child: Container(
                                                            width: getHorizontalSize(350),
                                                            color: ColorConstant.whiteA700,
                                                            child: CustomImageView(
                                                              radius: BorderRadius.circular(6),
                                                              border: Border.all(width: 2, color: ColorConstant.anbtnBlue),
                                                              url: controller.tenantFormModel.data?.completionCertificateUrl ?? "",
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: getVerticalSize(5),
                                                        ),
                                                      ],
                                                    ),
                                                  if (isEditable)
                                                    Padding(
                                                      padding: getPadding(left: 10, right: 10),
                                                      child: CustomButton(
                                                        width: getHorizontalSize(350),
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w700,
                                                        color: ColorConstant.whiteA700,
                                                        label: "COMPLETION CERTIFICATE".tr,
                                                        textColor: ColorConstant.anbtnBlue,
                                                        borderColor: ColorConstant.anbtnBlue,
                                                        prefix: Icon(
                                                          controller.certificate != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                          color: ColorConstant.anbtnBlue,
                                                        ),
                                                        onPressed: () async {
                                                          controller.certificate = null;

                                                          imageGalleryClass.imageGalleryBottomSheet(
                                                            context: context,
                                                            onCameraTap: () async {
                                                              controller.certificate = await imageGalleryClass.getImage(ImageSource.camera);
                                                              setState(() {});
                                                              Get.back();
                                                            },
                                                            onGalleryTap: () async {
                                                              controller.certificate = await imageGalleryClass.getImage(ImageSource.gallery);
                                                              setState(() {});
                                                              Get.back();
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  if (isEditable)
                                                    Padding(
                                                      padding: getPadding(left: 10, right: 10),
                                                      child: MyAnimatedButton(
                                                        radius: 5.0,
                                                        height: getVerticalSize(50),
                                                        width: getHorizontalSize(400),
                                                        fontSize: 16.sp,
                                                        bgColor: ColorConstant.anbtnBlue,
                                                        controller: args['status'] == Constants.formStatusRejected
                                                            ? controller.editbtnController
                                                            : controller.btnController,
                                                        title: "Submit".tr,
                                                        onTap: () async {
                                                          if (args['status'] == Constants.formStatusRejected) {
                                                            controller.editTenantFormApi(context, args['id'], vehicleFormIndex - 1);
                                                          } else {
                                                            if (controller.ownerCnicFrontBack == null) {
                                                              Utils.showToast(
                                                                "Please select owner CNIC",
                                                                true,
                                                              );
                                                            } else if (controller.tenantCnicFrontBack == null) {
                                                              Utils.showToast(
                                                                "Please select tenant CNIC",
                                                                true,
                                                              );
                                                            } else if (controller.tenantPhoto == null) {
                                                              Utils.showToast(
                                                                "Please select tenant photograph",
                                                                true,
                                                              );
                                                            } else if (controller.rentAgreement == null) {
                                                              Utils.showToast(
                                                                "Please select rent agreement",
                                                                true,
                                                              );
                                                            } else if (controller.policeForm == null) {
                                                              Utils.showToast(
                                                                "Please select police registration form",
                                                                true,
                                                              );
                                                            } else {
                                                              controller.tenantFormApi(context);
                                                            }
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    height: getVerticalSize(15),
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(20),
                                                  ),
                                                ],
                                              );
                                            })
                                      ],
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(30),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    })
              ],
            ),
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

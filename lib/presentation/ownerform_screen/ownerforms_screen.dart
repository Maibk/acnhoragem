import 'dart:developer';

import 'package:anchorageislamabad/core/utils/constants.dart';
import 'package:anchorageislamabad/core/utils/image_gallery.dart';
import 'package:anchorageislamabad/core/utils/utils.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/presentation/ownerform_screen/models/owner_form_model.dart';
import 'package:anchorageislamabad/theme/app_style.dart';
import 'package:anchorageislamabad/widgets/custom_image_view.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:anchorageislamabad/widgets/field_text.dart';
// import 'package:csc_picker/csc_picker.dart';
import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/helper_functions.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../widgets/animated_custom_button.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_dialogue.dart';
import '../../widgets/custom_expensiontile.dart';
import '../../widgets/custom_textfield_new.dart';
import 'controller/ownerforms_controller.dart';

class OwnerFornsScreen extends StatefulWidget {
  @override
  State<OwnerFornsScreen> createState() => _OwnerFornsScreenState();
}

class _OwnerFornsScreenState extends State<OwnerFornsScreen> {
  OwnerFornsScreenController controller = Get.put(OwnerFornsScreenController());
  final ImageGalleryClass imageGalleryClass = ImageGalleryClass();

  final args = Get.arguments;
  bool isEditable = false;
  int vehicleFormIndex = 0;
  @override
  initState() {
    if (args['status'] == Constants.formStatusRejected || args['status'] == "") {
      isEditable = true;
    }
    Future.delayed(Duration(), () {
      args['status'] != "" ? controller.getEntryFormsDetails(args['id']) : null;
      args['status'] == "" ? controller.addvehicleControllers() : null;
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
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100.0,
          backgroundColor: Colors.transparent,
          title: MyText(
            title: "Owner Forms",
            clr: ColorConstant.whiteA700,
            fontSize: 20,
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
          child: Form(
            key: controller.formKey,
            child: GetBuilder(
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
                    return Column(
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
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: MyText(
                                        title: "Record Form",
                                        fontSize: 16,
                                        clr: ColorConstant.apppWhite,
                                      )),
                                  if (args['status'] == "Rejected")
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(7)),
                                      child: Align(
                                          alignment: Alignment.topLeft,
                                          child: MyText(
                                            title: "Rejection Reason : " + (controller.ownerFormModel.data?.rejection_reason ?? ""),
                                            fontSize: 20,
                                            clr: ColorConstant.apppWhite,
                                          )),
                                    ),
                                  SizedBox(
                                    height: getVerticalSize(10),
                                  ),
                                  CustomExpansionTile(
                                    expanded: args['status'] == "Rejected",
                                    title: MyText(
                                      title: 'Owner Application',
                                      clr: ColorConstant.black900,
                                      fontSize: 16,
                                    ),
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CustomTextField(
                                            label: FieldText(
                                              text: "Full Name".tr,
                                            ),
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
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
                                            label: FieldText(
                                              text: "Telephone No.".tr,
                                            ),
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
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
                                                      RichText(
                                                        text: TextSpan(
                                                          text: "Nationality",
                                                          style: AppStyle.txtSourceSansProRegular16Gray600
                                                              .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                          children: [
                                                            TextSpan(
                                                              text: ' *',
                                                              style: TextStyle(color: Colors.red),
                                                            ),
                                                          ],
                                                        ),
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
                                                    RichText(
                                                      text: TextSpan(
                                                        text: "Block/COMM",
                                                        style: AppStyle.txtSourceSansProRegular16Gray600
                                                            .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                        children: [
                                                          TextSpan(
                                                            text: ' *',
                                                            style: TextStyle(color: Colors.red),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    DropdownButton<Street>(
                                                      isExpanded: true,
                                                      hint: controller.selectedValue == null
                                                          ? Text(
                                                              "Select",
                                                              style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                  fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                            )
                                                          : Text(controller.selectedValue?.title.toString() ?? ""),
                                                      // value: controller.selectedValue,
                                                      items: controller.block.map((item) {
                                                        return DropdownMenuItem<Street>(
                                                          value: item,
                                                          child: Text(item.title.toString()),
                                                        );
                                                      }).toList(),
                                                      onChanged: isEditable
                                                          ? (Street? value) {
                                                              setState(() {
                                                                controller.selectedValue = value!;
                                                                controller.streets.clear();
                                                                controller.plots.clear();
                                                                controller.streetSelectedValue = null;
                                                                controller.getStreetByBlock(value.id);
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
                                                  builder: (context) {
                                                    return Expanded(
                                                        child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            text: "Street",
                                                            style: AppStyle.txtSourceSansProRegular16Gray600
                                                                .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                            children: [
                                                              TextSpan(
                                                                text: ' *',
                                                                style: TextStyle(color: Colors.red),
                                                              ),
                                                            ],
                                                          ),
                                                        ).paddingOnly(
                                                          left: 10,
                                                        ),
                                                        DropdownButton<Street>(
                                                          isExpanded: true,
                                                          hint: controller.streetSelectedValue == null
                                                              ? Text(
                                                                  "Select",
                                                                  style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                      fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                                )
                                                              : Text(controller.streetSelectedValue?.title.toString() ?? ""),
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
                                                  builder: (context) {
                                                    return Expanded(
                                                        child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        RichText(
                                                          text: TextSpan(
                                                            text: "Plot",
                                                            style: AppStyle.txtSourceSansProRegular16Gray600
                                                                .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                                            children: [
                                                              TextSpan(
                                                                text: ' *',
                                                                style: TextStyle(color: Colors.red),
                                                              ),
                                                            ],
                                                          ),
                                                        ).paddingOnly(
                                                          left: 10,
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
                                                  label: FieldText(
                                                    text: "CNIC".tr,
                                                  ),
                                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                                  controller: controller.cnicController,
                                                  isFinal: false,
                                                  enabled: isEditable,
                                                  keyboardType: TextInputType.number,
                                                  limit: HelperFunction.EMAIL_VALIDATION,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter.digitsOnly,
                                                    TextInputFormatterWithPattern('#####-#######-#'),
                                                  ],
                                                  validator: (value) {
                                                    return HelperFunction.cnicValidator(value!);
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: CustomTextField(
                                                  label: FieldText(
                                                    text: "Occupation".tr,
                                                  ),
                                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                                  controller: controller.occupationController,
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
                                          CustomTextField(
                                            label: FieldText(
                                              text: "Present Address.".tr,
                                            ),
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
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
                                            label: FieldText(
                                              text: "Permanent Address.".tr,
                                            ),
                                            floatingLabelBehavior: FloatingLabelBehavior.never,
                                            controller: controller.permanantAddController,
                                            isFinal: false,
                                            enabled: isEditable,
                                            keyboardType: TextInputType.emailAddress,
                                            limit: HelperFunction.EMAIL_VALIDATION,
                                            validator: (value) {
                                              return HelperFunction.empthyFieldValidator(value!);
                                            },
                                          ),
                                          SizedBox(
                                            height: getVerticalSize(10),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: "Total Number of wives",
                                              style: TextStyle(color: Colors.black.withOpacity(.5), fontSize: 16),
                                              children: [
                                                TextSpan(
                                                  text: ' *',
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                              ],
                                            ),
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
                                              hint: Text(
                                                "Select",
                                                style: AppStyle.txtSourceSansProRegular16Gray600
                                                    .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                              ),
                                              value: controller.total_wives,
                                              items: controller.wives.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    style: TextStyle(fontSize: 12.h),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: isEditable
                                                  ? (newValue) {
                                                      controller.total_wives = null;
                                                      controller.total_wives = newValue;
                                                      setState(() {});
                                                    }
                                                  : null,
                                            ),
                                          ),
                                          SizedBox(
                                            height: getVerticalSize(10),
                                          ),
                                          SizedBox(
                                            height: getVerticalSize(20),
                                          ),
                                          RichText(
                                            text: TextSpan(
                                              text: "Total Number of children",
                                              style: TextStyle(color: Colors.black.withOpacity(.5), fontSize: 16),
                                              children: [
                                                TextSpan(
                                                  text: ' *',
                                                  style: TextStyle(color: Colors.red),
                                                ),
                                              ],
                                            ),
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
                                              hint: Text(
                                                "Select",
                                                style: AppStyle.txtSourceSansProRegular16Gray600
                                                    .copyWith(fontSize: 14, color: ColorConstant.gray600, fontWeight: FontWeight.normal),
                                              ),
                                              value: controller.total_children,
                                              items: controller.children.map((e) {
                                                return DropdownMenuItem<String>(
                                                  value: e,
                                                  child: Text(
                                                    e,
                                                    style: TextStyle(fontSize: 12.h),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: isEditable
                                                  ? (newValue) {
                                                      controller.total_children = null;
                                                      controller.total_children = newValue;
                                                      setState(() {});
                                                    }
                                                  : null,
                                            ),
                                          ),
                                          AbsorbPointer(
                                            absorbing: !isEditable,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GetBuilder(
                                                    init: controller,
                                                    builder: (context) {
                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            children: [
                                                              Padding(
                                                                padding: getPadding(left: 8, top: 20),
                                                                child: RichText(
                                                                  text: TextSpan(
                                                                    text: "Allotment Letter held:",
                                                                    style: TextStyle(color: Colors.black.withOpacity(.5), fontSize: 16),
                                                                    children: [
                                                                      TextSpan(
                                                                        text: ' *',
                                                                        style: TextStyle(color: Colors.red),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                children: [
                                                                  GetBuilder(
                                                                    init: controller,
                                                                    builder: (controller) {
                                                                      return GestureDetector(
                                                                        behavior: HitTestBehavior.opaque,
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
                                                                                  fontSize: 16,
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
                                                                        behavior: HitTestBehavior.opaque,
                                                                        onTap: () {
                                                                          controller.updateAllotmentLetter("No");
                                                                          controller.allotmentletter = null;
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
                                                                                  fontSize: 16,
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
                                                    builder: (context) {
                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: getPadding(left: 10),
                                                                child: RichText(
                                                                  text: TextSpan(
                                                                    text: "Completion certificate held:",
                                                                    style: TextStyle(color: Colors.black.withOpacity(.5), fontSize: 16),
                                                                    children: [
                                                                      TextSpan(
                                                                        text: ' *',
                                                                        style: TextStyle(color: Colors.red),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: getHorizontalSize(20),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  GetBuilder(
                                                                    init: controller,
                                                                    builder: (controller) {
                                                                      return GestureDetector(
                                                                        behavior: HitTestBehavior.opaque,
                                                                        onTap: () {
                                                                          controller.updateCompletionCertificate("Yes");
                                                                        },
                                                                        child: Row(
                                                                          children: [
                                                                            controller.completionCertificate == "Yes"
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
                                                                                  fontSize: 16,
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
                                                                        behavior: HitTestBehavior.opaque,
                                                                        onTap: () {
                                                                          controller.updateCompletionCertificate("No");
                                                                          controller.certificate = null;
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
                                                                                  fontSize: 16,
                                                                                  color: ColorConstant.gray600,
                                                                                  fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              ).paddingOnly(left: 20),
                                                            ],
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: CustomTextField(
                                                  label: FieldText(
                                                    text: "Size of House/ Plot.".tr,
                                                  ),
                                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                                  controller: controller.sizeHouseAddController,
                                                  isFinal: false,
                                                  enabled: false,
                                                  keyboardType: TextInputType.emailAddress,
                                                  limit: HelperFunction.EMAIL_VALIDATION,
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
                                          AbsorbPointer(
                                            absorbing: !isEditable,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                GetBuilder(
                                                    init: controller,
                                                    builder: (context) {
                                                      return Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: getPadding(left: 10),
                                                                child: RichText(
                                                                  text: TextSpan(
                                                                    text: "Construction Status:",
                                                                    style: TextStyle(color: Colors.black.withOpacity(.5), fontSize: 16),
                                                                    children: [
                                                                      TextSpan(
                                                                        text: ' *',
                                                                        style: TextStyle(color: Colors.red),
                                                                      ),
                                                                    ],
                                                                  ),
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
                                                                        behavior: HitTestBehavior.opaque,
                                                                        onTap: () {
                                                                          controller.updateConstructionStatus("Under Construction");
                                                                        },
                                                                        child: Row(
                                                                          children: [
                                                                            controller.constructionStatus == "Under Construction"
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
                                                                              "Under Construction",
                                                                              style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                                  fontSize: 16,
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
                                                                  SizedBox(
                                                                    height: getVerticalSize(10),
                                                                  ),
                                                                  GetBuilder(
                                                                    init: controller,
                                                                    builder: (controller) {
                                                                      return GestureDetector(
                                                                        behavior: HitTestBehavior.opaque,
                                                                        onTap: () {
                                                                          controller.updateConstructionStatus("Complete");
                                                                          log(controller.constructionStatus);
                                                                        },
                                                                        child: Row(
                                                                          children: [
                                                                            controller.constructionStatus == "Complete"
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
                                                                              "Complete",
                                                                              style: AppStyle.txtSourceSansProRegular16Gray600.copyWith(
                                                                                  fontSize: 16,
                                                                                  color: ColorConstant.gray600,
                                                                                  fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              ).paddingOnly(left: 12),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: getVerticalSize(5),
                                                          ),
                                                          SizedBox(
                                                            height: getVerticalSize(5),
                                                          ),
                                                          SizedBox(
                                                            height: getVerticalSize(20),
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
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: getVerticalSize(10),
                                  ),
                                  CustomExpansionTile(
                                    expanded: true,
                                    title: MyText(
                                      title: 'PRIVATE ARMS',
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
                                                        child: RichText(
                                                          text: TextSpan(
                                                            text: "Private Arms:",
                                                            style: TextStyle(color: Colors.black.withOpacity(.5), fontSize: 16),
                                                            children: [
                                                              TextSpan(
                                                                text: ' *',
                                                                style: TextStyle(color: Colors.red),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: getHorizontalSize(20),
                                                      ),
                                                      GetBuilder(
                                                        init: controller,
                                                        builder: (_) {
                                                          return GestureDetector(
                                                            behavior: HitTestBehavior.opaque,
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
                                                        builder: (_) {
                                                          return GestureDetector(
                                                            behavior: HitTestBehavior.opaque,
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
                                                controller.privatearms == "Yes"
                                                    ? Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: CustomTextField(
                                                                  enabled: isEditable,
                                                                  label: FieldText(
                                                                    text: "License Number".tr,
                                                                  ),
                                                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                  controller: controller.privateLicenseController,
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
                                                                  label: FieldText(
                                                                    text: "Arms Quantity".tr,
                                                                  ),
                                                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                  controller: controller.privateArmsController,
                                                                  isFinal: false,
                                                                  keyboardType: TextInputType.number,
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
                                                                  label: FieldText(
                                                                    text: "Ammunition Quantity".tr,
                                                                  ),
                                                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                  controller: controller.armQuantityController,
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
                                                                  label: FieldText(
                                                                    text: "Bore/Type".tr,
                                                                  ),
                                                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                  controller: controller.privateBoreController,
                                                                  isFinal: false,
                                                                  keyboardType: TextInputType.emailAddress,
                                                                  validator: (value) {
                                                                    return HelperFunction.empthyFieldValidator(value!);
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    : Column(),
                                                SizedBox(
                                                  height: getVerticalSize(5),
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
                                                              if (args['status'] != Constants.formStatusPending) {
                                                                setState(() {
                                                                  controller.ownerFormModel.data?.vehicleStatus = "Yes";
                                                                  controller.eTag.add("");
                                                                  controller.ownerFormModel.data?.vehicle = [Vehicle()];
                                                                  controller.vehicleFormKey.add(GlobalKey<FormState>());
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
                                                            onTap: () {
                                                              controller.updateVehicle("No");
                                                              controller.eTag.clear();
                                                              controller.ownerFormModel.data?.vehicle = null;
                                                              controller.vehicleFormKey.clear();
                                                              if (args['status'] == Constants.formStatusRejected) {
                                                                controller.ownerFormModel.data?.vehicleStatus = "No";
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
                                                            ? (controller.ownerFormModel.data?.vehicle?.length ?? 0) +
                                                                (args['status'] == Constants.formStatusRejected ? 1 : 0)
                                                            : controller.vehicleTypeControllers.length + 1,
                                                        itemBuilder: (context, index) {
                                                          vehicleFormIndex = index;
                                                          bool isLastIndex = index ==
                                                              (args['status'] != ""
                                                                  ? (controller.ownerFormModel.data?.vehicle?.length ?? 0)
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
                                                                      controller.ownerFormModel.data?.vehicle?.add(Vehicle());
                                                                      controller.vehicleFormKey.add(GlobalKey<FormState>());
                                                                      controller.update();
                                                                    }
                                                                  } else {
                                                                    if (formState != null && formState.validate()) {
                                                                      controller.vehicleFormKey.add(GlobalKey<FormState>());
                                                                      controller.addvehicle(context, index - 1);
                                                                    }
                                                                  }
                                                                },
                                                              ),
                                                            );
                                                          }
                                                          Vehicle? detail;
                                                          if ((controller.ownerFormModel.data?.vehicle?.length ?? 0) > 0 &&
                                                              index < (controller.ownerFormModel.data?.vehicle?.length ?? 0)) {
                                                            detail = controller.ownerFormModel.data?.vehicle?[index];
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

                                                                                controller.ownerFormModel.data?.vehicle?.removeAt(index);
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
                                                                        label: FieldText(
                                                                          text: "Vehicle Type".tr,
                                                                        ),
                                                                        floatingLabelBehavior: FloatingLabelBehavior.never,
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
                                                                        label: FieldText(
                                                                          text: "Registration No.".tr,
                                                                        ),
                                                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                                                        controller: args['status'] == Constants.formStatusRejected
                                                                            ? detail?.registrationController
                                                                            : controller.vehicleRegisterNoControllers[index],
                                                                        isFinal: false,
                                                                        keyboardType: TextInputType.emailAddress,
                                                                        validator: (value) {
                                                                          return HelperFunction.empthyFieldValidator(value!);
                                                                        },
                                                                        // : null,
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
                                                                        label: FieldText(
                                                                          text: "Color".tr,
                                                                        ),
                                                                        floatingLabelBehavior: FloatingLabelBehavior.never,
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
                                                                        label: FieldText(
                                                                          text: "Sticker No.".tr,
                                                                        ),
                                                                        floatingLabelBehavior: FloatingLabelBehavior.never,
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
                                                                      padding: getPadding(left: 14),
                                                                      child: RichText(
                                                                        text: TextSpan(
                                                                          text: "E-Tag",
                                                                          style: TextStyle(
                                                                              color: ColorConstant.blackColor.withOpacity(0.5), fontSize: 15),
                                                                          children: [
                                                                            TextSpan(
                                                                              text: ' *',
                                                                              style: TextStyle(color: Colors.red),
                                                                            ),
                                                                          ],
                                                                        ),
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
                                                                                MyText(
                                                                                  title: "Yes",
                                                                                  clr: ColorConstant.antextlightgray,
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
                                                                              MyText(
                                                                                title: "No",
                                                                                clr: ColorConstant.antextlightgray,
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
                                        fontSize: 22,
                                      )),
                                  SizedBox(
                                    height: getVerticalSize(10),
                                  ),
                                  CustomExpansionTile(
                                    expanded: true,
                                    title: MyText(
                                      title: 'Requirements:',
                                      clr: ColorConstant.black900,
                                      fontSize: 16,
                                    ),
                                    children: <Widget>[
                                      GetBuilder(
                                        init: controller,
                                        builder: (controller) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: getVerticalSize(5),
                                              ),
                                              if (controller.alottmentletter == "Yes")
                                                if (args['status'] != "")
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      MyText(title: "Allotment Letter").paddingOnly(left: 10),
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
                                                            url: controller.ownerFormModel.data?.allotmentLetterUrl ?? "",
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: getVerticalSize(5),
                                                      ),
                                                    ],
                                                  ),
                                              if (controller.alottmentletter == "Yes")
                                                if (args['status'] == Constants.formStatusRejected || args['status'] == "")
                                                  Padding(
                                                    padding: getPadding(left: 10, right: 10),
                                                    child: CustomButton(
                                                      width: getHorizontalSize(350),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                      color: ColorConstant.whiteA700,
                                                      label: controller.allotmentletter != null ? "Allotment Letter" : "Attach Allotment Letter".tr,
                                                      textColor: ColorConstant.anbtnBlue,
                                                      borderColor: ColorConstant.anbtnBlue,
                                                      prefix: Icon(
                                                        controller.allotmentletter != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                        color: ColorConstant.anbtnBlue,
                                                      ),
                                                      onPressed: () async {
                                                        imageGalleryClass.imageGalleryBottomSheet(
                                                          context: context,
                                                          onCameraTap: () async {
                                                            controller.allotmentletter = await imageGalleryClass.getImage(ImageSource.camera);
                                                            setState(() {});
                                                            Get.back();
                                                          },
                                                          onGalleryTap: () async {
                                                            controller.allotmentletter = await imageGalleryClass.getImage(ImageSource.gallery);
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
                                                    MyText(title: "Building Plan").paddingOnly(left: 10),
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
                                                          url: controller.ownerFormModel.data?.approvalBuildingPlanUrl ?? "",
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
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w700,
                                                    color: ColorConstant.whiteA700,
                                                    label: controller.buildingplan != null ? "Building Plan" : "Attach Approval of Building Plan".tr,
                                                    textColor: ColorConstant.anbtnBlue,
                                                    borderColor: ColorConstant.anbtnBlue,
                                                    prefix: Icon(
                                                      controller.buildingplan != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                      color: ColorConstant.anbtnBlue,
                                                    ),
                                                    onPressed: () async {
                                                      imageGalleryClass.imageGalleryBottomSheet(
                                                        context: context,
                                                        onCameraTap: () async {
                                                          controller.buildingplan = await imageGalleryClass.getImage(ImageSource.camera);
                                                          setState(() {});

                                                          Get.back();
                                                        },
                                                        onGalleryTap: () async {
                                                          controller.buildingplan = await imageGalleryClass.getImage(ImageSource.gallery);
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
                                              if (controller.completionCertificate == "Yes")
                                                if (args['status'] != "")
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      MyText(title: "Completion Certificate").paddingOnly(left: 10),
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
                                                            url: controller.ownerFormModel.data?.completionCertificateUrl ?? "",
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: getVerticalSize(5),
                                                      ),
                                                    ],
                                                  ),
                                              if (controller.completionCertificate == "Yes")
                                                if (isEditable)
                                                  Padding(
                                                    padding: getPadding(left: 10, right: 10),
                                                    child: CustomButton(
                                                      width: getHorizontalSize(350),
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.w700,
                                                      color: ColorConstant.whiteA700,
                                                      label: "Completion Certificate".tr,
                                                      textColor: ColorConstant.anbtnBlue,
                                                      borderColor: ColorConstant.anbtnBlue,
                                                      prefix: Icon(
                                                        controller.certificate != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                        color: ColorConstant.anbtnBlue,
                                                      ),
                                                      onPressed: () async {
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
                                                    fontSize: 16,
                                                    bgColor: ColorConstant.anbtnBlue,
                                                    controller: controller.btnController,
                                                    title: "Submit".tr,
                                                    onTap: () async {
                                                      if (args['status'] == Constants.formStatusRejected) {
                                                        controller.editOwnerFormApi(context, args['id'], vehicleFormIndex - 1);
                                                      } else {
                                                        if (controller.buildingplan == null) {
                                                          Utils.showToast(
                                                            "Please select building plan",
                                                            true,
                                                          );
                                                        } else {
                                                          controller.ownerFormApi(context, vehicleFormIndex - 1);
                                                        }
                                                      }
                                                    },
                                                  ),
                                                ),
                                              if (kDebugMode)
                                                ElevatedButton(
                                                    onPressed: () {
                                                      if (args['status'] == Constants.formStatusRejected) {
                                                        controller.editOwnerFormApi(context, args['id'], vehicleFormIndex - 1);
                                                      } else {
                                                        if (controller.buildingplan == null) {
                                                          Utils.showToast(
                                                            "Please select building plan",
                                                            true,
                                                          );
                                                        } else {
                                                          controller.ownerFormApi(context, vehicleFormIndex - 1);
                                                        }
                                                      }
                                                    },
                                                    child: Text("data")),
                                              SizedBox(
                                                height: getVerticalSize(15),
                                              ),
                                              SizedBox(
                                                height: getVerticalSize(20),
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: getVerticalSize(30),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}

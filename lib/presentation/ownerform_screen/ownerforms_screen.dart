import 'dart:developer';

import 'package:anchorageislamabad/core/utils/app_fonts.dart';
import 'package:anchorageislamabad/core/utils/constants.dart';
import 'package:anchorageislamabad/data/services/api_call_status.dart';
import 'package:anchorageislamabad/widgets/custom_image_view.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
// import 'package:csc_picker/csc_picker.dart';
import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
import 'controller/ownerforms_controller.dart';

class OwnerFornsScreen extends StatefulWidget {
  @override
  State<OwnerFornsScreen> createState() => _OwnerFornsScreenState();
}

class _OwnerFornsScreenState extends State<OwnerFornsScreen> {
  OwnerFornsScreenController controller = Get.put(OwnerFornsScreenController());

  final args = Get.arguments;
  bool isEditable = false;
  @override
  initState() {
    if (args['status'] == Constants.formStatusRejected || args['status'] == "") {
      isEditable = true;
    }
    Future.delayed(Duration(), () {
      args['status'] != "" ? controller.getEntryFormsDetails(args['id']) : null;
      args['status'] != "Pending" ? controller.addvehicleControllers() : null;
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
                builder: (context) {
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
                                    expanded: true,
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
                                                  child: CSCPickerPlus(
                                                    currentCountry: controller.natinalityController.text,
                                                    countryDropdownLabel: "Nationality",
                                                    disableCountry: isEditable ? false : true,
                                                    disabledDropdownDecoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      border:
                                                          Border(bottom: BorderSide(width: .5, color: ColorConstant.appBorderGray.withOpacity(.3))),
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
                                                ),
                                              ),
                                              Expanded(
                                                child: DropdownButton(
                                                  hint: controller.selectedValue == null
                                                      ? Text(
                                                          "Block/COMM ",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: ColorConstant.blackColor.withOpacity(0.5),
                                                            fontFamily: AppFonts.lucidaBright,
                                                            fontWeight: FontWeight.w400,
                                                          ),
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
                                                            controller.streets.clear();
                                                            controller.plots.clear();
                                                            controller.getStreetByBlock(value);
                                                          });
                                                        }
                                                      : null,
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
                                                        child: DropdownButton<Street>(
                                                      hint: controller.streetSelectedValue == null
                                                          ? Text(
                                                              "Select Street",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: ColorConstant.blackColor.withOpacity(0.5),
                                                                fontFamily: AppFonts.lucidaBright,
                                                                fontWeight: FontWeight.w400,
                                                              ),
                                                            )
                                                          : Text(controller.selectedValue.toString()),
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
                                                          controller.plots.clear();
                                                          controller.getPlotNoByStreet(value!.id);
                                                        });
                                                      },
                                                    ).paddingOnly(left: 12));
                                                  }),
                                              GetBuilder(
                                                  init: controller,
                                                  builder: (context) {
                                                    return Expanded(
                                                        child: DropdownButton<Plots>(
                                                      hint: controller.plotstSelectedValue == null
                                                          ? Text(
                                                              "Select Plot",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                color: ColorConstant.blackColor.withOpacity(0.5),
                                                                fontFamily: AppFonts.lucidaBright,
                                                                fontWeight: FontWeight.w400,
                                                              ),
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
                                                    ).paddingOnly(left: 12));
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
                                                  fieldText: "Occupation".tr,
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
                                            fieldText: "Present Address.".tr,
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
                                            fieldText: "Permanent Address".tr,
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
                                            height: getVerticalSize(20),
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
                                                title: "Total Number of children",
                                                fontSize: 12,
                                                clr: ColorConstant.gray600,
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
                                          SizedBox(
                                            height: getVerticalSize(10),
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
                                                title: "Total Number of Wives",
                                                fontSize: 12,
                                                clr: ColorConstant.gray600,
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
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding: getPadding(left: 10),
                                                                child: MyText(
                                                                  title: "Allotment Letter held:",
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
                                                                        MyText(
                                                                          title: "Yes",
                                                                          clr: ColorConstant.antextlightgray,
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
                                                          Row(
                                                            children: [
                                                              Padding(
                                                                padding: getPadding(left: 10),
                                                                child: MyText(
                                                                  title: "Completion certificate held:",
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
                                                                        MyText(
                                                                          title: "Yes",
                                                                          clr: ColorConstant.antextlightgray,
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: CustomTextField(
                                                  fieldText: "Size of House/ Plot".tr,
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
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Padding(
                                                                padding: getPadding(left: 10),
                                                                child: MyText(
                                                                  title: "Construction Status:",
                                                                  clr: ColorConstant.antextlightgray,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: getHorizontalSize(20),
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
                                                                            MyText(
                                                                              title: "Under Construction",
                                                                              clr: ColorConstant.antextlightgray,
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
                                                                            MyText(
                                                                              title: "Complete",
                                                                              clr: ColorConstant.antextlightgray,
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
                                                        child: MyText(
                                                          title: "PRIVATE ARMS*:",
                                                          clr: ColorConstant.antextlightgray,
                                                          fontSize: 14,
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
                                                                MyText(
                                                                  title: "Yes",
                                                                  clr: ColorConstant.antextlightgray,
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
                                                                  fieldText: "License Number".tr,
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
                                                                  fieldText: "Arms Quantity".tr,
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
                                                                  fieldText: "Ammunition Qantity ".tr,
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
                                                                  fieldText: "Bore/Typer".tr,
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
                                          builder: (context) {
                                            return Form(
                                              key: controller.vehicleFormKey,
                                              child: Column(
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
                                                                  MyText(
                                                                    title: "Yes",
                                                                    clr: ColorConstant.antextlightgray,
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
                                                  ),
                                                  SizedBox(
                                                    height: getVerticalSize(5),
                                                  ),
                                                  controller.hasVehicle == "Yes"
                                                      ? ListView.builder(
                                                          shrinkWrap: true,
                                                          physics: NeverScrollableScrollPhysics(),
                                                          itemCount: args['status'] != ""
                                                              ? controller.ownerFormModel.data?.vehicle?.length ?? 0
                                                              : controller.vehicleTypeControllers.length == 0
                                                                  ? 1
                                                                  : controller.vehicleTypeControllers.length,
                                                          itemBuilder: (context, index) {
                                                            return Column(
                                                              children: [
                                                                if (index != 0)
                                                                  if (args['status'] != Constants.formStatusPending)
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        GestureDetector(
                                                                          onTap: () {
                                                                            setState(() {
                                                                              controller.vehicleTypeControllers.removeAt(index);
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
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Expanded(
                                                                      child: CustomTextField(
                                                                        enabled: isEditable,
                                                                        fieldText: "Vehicle Type".tr,
                                                                        controller: controller.vehicleTypeControllers[index],
                                                                        isFinal: false,
                                                                        keyboardType: TextInputType.emailAddress,
                                                                        limit: HelperFunction.EMAIL_VALIDATION,
                                                                        validator: controller.vehicleDataIndex < 1
                                                                            ? (value) {
                                                                                return HelperFunction.empthyFieldValidator(value!);
                                                                              }
                                                                            : null,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: CustomTextField(
                                                                        enabled: isEditable,
                                                                        fieldText: "Registration No.".tr,
                                                                        controller: controller.vehicleRegisterNoControllers[index],
                                                                        isFinal: false,
                                                                        keyboardType: TextInputType.emailAddress,
                                                                        validator: controller.vehicleDataIndex < 1
                                                                            ? (value) {
                                                                                return HelperFunction.empthyFieldValidator(value!);
                                                                              }
                                                                            : null,
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
                                                                        controller: controller.vehicleColorControllers[index],
                                                                        isFinal: false,
                                                                        keyboardType: TextInputType.emailAddress,
                                                                        limit: HelperFunction.EMAIL_VALIDATION,
                                                                        validator: controller.vehicleDataIndex < 1
                                                                            ? (value) {
                                                                                return HelperFunction.empthyFieldValidator(value!);
                                                                              }
                                                                            : null,
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: CustomTextField(
                                                                        enabled: isEditable,
                                                                        fieldText: "Sticker No.".tr,
                                                                        controller: controller.vehicleStikerControllers[index],
                                                                        isFinal: false,
                                                                        keyboardType: TextInputType.emailAddress,
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
                                                                        fontSize: 14.h,
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
                                                                if (args['status'] == "")
                                                                  Padding(
                                                                    padding: getPadding(left: 10, right: 10),
                                                                    child: MyAnimatedButton(
                                                                      radius: 5.0,
                                                                      height: getVerticalSize(50),
                                                                      width: getHorizontalSize(400),
                                                                      fontSize: 16.h,
                                                                      bgColor: ColorConstant.anbtnBlue,
                                                                      controller: controller.uselessbtnController,
                                                                      title: "Add Vehicle".tr,
                                                                      onTap: () async {
                                                                        controller.addvehicle(context, index);
                                                                      },
                                                                    ),
                                                                  ),
                                                                SizedBox(
                                                                  height: getVerticalSize(15),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        )
                                                      : Column(),
                                                ],
                                              ),
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
                                                        controller.allotmentletter = await controller.imagePicker();
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
                                                    label:
                                                        controller.allotmentletter != null ? "Building Plan" : "Attach Approval of Building Plan".tr,
                                                    textColor: ColorConstant.anbtnBlue,
                                                    borderColor: ColorConstant.anbtnBlue,
                                                    prefix: Icon(
                                                      controller.buildingplan != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
                                                      color: ColorConstant.anbtnBlue,
                                                    ),
                                                    onPressed: () async {
                                                      controller.buildingplan = await controller.imagePicker();
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
                                                        controller.certificate = await controller.imagePicker();
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
                                                    controller: args['status'] == Constants.formStatusRejected
                                                        ? controller.editbtnController
                                                        : controller.btnController,
                                                    title: "Submit".tr,
                                                    onTap: () async {
                                                      if (args['status'] == Constants.formStatusRejected) {
                                                        controller.editOwnerFormApi(context, args['id']);
                                                      } else {
                                                        if (controller.buildingplan == null) {
                                                          Utils.showToast(
                                                            "Please select building plan",
                                                            true,
                                                          );
                                                        } else {
                                                          controller.ownerFormApi(context);
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

  /// Navigates to the previous screen.
  onTapArrowLeft() {
    Get.back();
  }
}

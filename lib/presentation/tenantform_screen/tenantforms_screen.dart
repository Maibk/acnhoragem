import 'dart:developer';

import 'package:anchorageislamabad/core/utils/app_fonts.dart';
import 'package:anchorageislamabad/core/utils/date_time_utils.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:csc_picker/csc_picker.dart';
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

  // const DiscoverScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final hasPagePushed = Navigator.of(context).canPop();

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image:
              AssetImage('assets/images/background.png'), // Replace 'assets/background_image.jpg' with your image path
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
            child: Column(
              children: [
                Expanded(
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
                                  fontSize: 16,
                                  clr: ColorConstant.apppWhite,
                                )),
                            SizedBox(
                              height: getVerticalSize(10),
                            ),
                            CustomExpansionTile(
                              expanded: true,
                              expand: true,
                              title: MyText(
                                title: 'PARTICULARS OF TENANT',
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
                                      fieldText: "Father’s Name".tr,
                                      controller: controller.fathersController,
                                      isFinal: false,
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
                                      fieldText: "Telephone No.".tr,
                                      controller: controller.telephoneController,
                                      isFinal: false,
                                      keyboardType: TextInputType.phone,
                                      limit: HelperFunction.EMAIL_VALIDATION,
                                      validator: (value) {
                                        return HelperFunction.empthyFieldValidator(value!);
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
                                            child: CSCPicker(
                                              countryDropdownLabel: "Nationality",
                                              onCountryChanged: (value) {
                                                controller.natinalityController.text = value!;
                                                log(controller.natinalityController.text);
                                              },
                                              dropdownHeadingStyle: TextStyle(color: ColorConstant.appBorderGray),
                                              onCityChanged: (value) {},
                                              onStateChanged: (value) {},
                                              showCities: false,
                                              showStates: false,
                                              dropdownDecoration: BoxDecoration(
                                                  border: Border(
                                                      bottom:
                                                          BorderSide(width: .5, color: ColorConstant.appBorderGray)),
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
                                            disabledHint: Text(
                                              "  ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: ColorConstant.blackColor.withOpacity(0.5),
                                                fontFamily: AppFonts.lucidaBright,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            items: controller.block.map((item) {
                                              return DropdownMenuItem<int>(
                                                value: item['id'],
                                                child: Text(item['title']),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              setState(() {
                                                controller.selectedValue = value!;
                                                controller.streets.clear();
                                                controller.plots.clear();
                                                controller.getStreetByBlock(value);
                                              });
                                            },
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
                                                disabledHint: Text(
                                                  "Select Street",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: ColorConstant.blackColor.withOpacity(0.5),
                                                    fontFamily: AppFonts.lucidaBright,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
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
                                                    : Text(controller.plotstSelectedValue.toString()),
                                                value: controller.plotstSelectedValue,
                                                disabledHint: Text(
                                                  "Select Plot",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: ColorConstant.blackColor.withOpacity(0.5),
                                                    fontFamily: AppFonts.lucidaBright,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
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
                                                      if (controller.plotstSelectedValue?.id ==
                                                          controller.plots[i].id) {
                                                        controller.sizeHouseAddController.text =
                                                            controller.plots[i].sq_yards.toString();
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
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                              TextInputFormatterWithPattern('#####-#######-#'),
                                            ],
                                            limit: HelperFunction.EMAIL_VALIDATION,
                                            validator: (value) {
                                              return HelperFunction.empthyFieldValidator(value!);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: CustomTextField(
                                            fieldText: "Occupation".tr,
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
                                    Row(
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
                                    SizedBox(
                                      height: getVerticalSize(5),
                                    ),
                                    Row(
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
                                    SizedBox(
                                      height: getVerticalSize(15),
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
                              expand: true,
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
                                          Row(
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
                                      return Form(
                                        key: controller.vehicleFormKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (controller.vehicleDataIndex != 0)
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(left: 15),
                                                    padding: EdgeInsets.all(10),
                                                    decoration:
                                                        BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                                    child: MyText(
                                                      title: controller.vehicleDataIndex.toString(),
                                                      clr: ColorConstant.whiteA700,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            Row(
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
                                            SizedBox(
                                              height: getVerticalSize(5),
                                            ),
                                            controller.hasVehicle == "Yes"
                                                ? Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: CustomTextField(
                                                              fieldText: "Vehicle Type".tr,
                                                              controller: controller.vehicleTypeController,
                                                              isFinal: false,
                                                              keyboardType: TextInputType.emailAddress,
                                                              limit: HelperFunction.EMAIL_VALIDATION,
                                                              validator: controller.vehicleDataIndex < 1
                                                                  ? (value) {
                                                                      return HelperFunction.empthyFieldValidator(
                                                                          value!);
                                                                    }
                                                                  : null,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: CustomTextField(
                                                              fieldText: "Registration No.".tr,
                                                              controller: controller.vehicleRegisterNoController,
                                                              isFinal: false,
                                                              keyboardType: TextInputType.emailAddress,
                                                              validator: controller.vehicleDataIndex < 1
                                                                  ? (value) {
                                                                      return HelperFunction.empthyFieldValidator(
                                                                          value!);
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
                                                              fieldText: "Color".tr,
                                                              controller: controller.vehicleColorController,
                                                              isFinal: false,
                                                              keyboardType: TextInputType.emailAddress,
                                                              limit: HelperFunction.EMAIL_VALIDATION,
                                                              validator: controller.vehicleDataIndex < 1
                                                                  ? (value) {
                                                                      return HelperFunction.empthyFieldValidator(
                                                                          value!);
                                                                    }
                                                                  : null,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: CustomTextField(
                                                              fieldText: "Sticker No.".tr,
                                                              controller: controller.vehicleStikerController,
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
                                                                onTap: () {
                                                                  controller.updateEtag("Yes");
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    controller.eTag == "Yes"
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
                                                                  controller.updateEtag("No");
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    controller.eTag == "No"
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
                                                      Padding(
                                                        padding: getPadding(left: 10, right: 10),
                                                        child: MyAnimatedButton(
                                                          radius: 5.0,
                                                          height: getVerticalSize(50),
                                                          width: getHorizontalSize(400),
                                                          fontSize: 16,
                                                          bgColor: ColorConstant.anbtnBlue,
                                                          controller: controller.uselessbtnController,
                                                          title: "Add Vehicle".tr,
                                                          onTap: () async {
                                                            if (controller.vehicleDataIndex > 0) {
                                                              if (controller.vehicleTypeController?.text == "" &&
                                                                  controller.vehicleRegisterNoController?.text == "" &&
                                                                  controller.vehicleColorController?.text == "" &&
                                                                  controller.vehicleEngineNoController.text == "" &&
                                                                  controller.vehicleEtagController.text == "") {
                                                                Utils.showToast(
                                                                    "Please fill in the required fields", true);
                                                              } else {
                                                                controller.addvehicle(context);
                                                              }
                                                            } else if (controller.vehicleDataIndex == 0) {
                                                              controller.addvehicle(context);
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: getVerticalSize(15),
                                                      ),
                                                    ],
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
                                title: 'Required Documents',
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
                                          Padding(
                                            padding: getPadding(left: 10),
                                            child: MyText(
                                              title: "Requirements:",
                                              clr: ColorConstant.antextlightgray,
                                              fontSize: 15,
                                            ),
                                          ),
                                          SizedBox(
                                            height: getVerticalSize(15),
                                          ),
                                          Padding(
                                            padding: getPadding(left: 10, right: 10),
                                            child: CustomButton(
                                              width: getHorizontalSize(350),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant.whiteA700,
                                              label: "CNIC OF OWNER (FRONT & BACK)*r".tr,
                                              textColor: ColorConstant.anbtnBlue,
                                              borderColor: ColorConstant.anbtnBlue,
                                              prefix: Icon(
                                                controller.ownerCnicFrontBack != null
                                                    ? Icons.check_circle_sharp
                                                    : Icons.add_circle_outline,
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
                                          Padding(
                                            padding: getPadding(left: 10, right: 10),
                                            child: CustomButton(
                                              width: getHorizontalSize(350),
                                              fontSize: 12,
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
                                          Padding(
                                            padding: getPadding(left: 10, right: 10),
                                            child: CustomButton(
                                              width: getHorizontalSize(350),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant.whiteA700,
                                              label: "CNIC OF ESTATE AGENT (FRONT & BACK)".tr,
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
                                          Padding(
                                            padding: getPadding(left: 10, right: 10),
                                            child: CustomButton(
                                              width: getHorizontalSize(350),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant.whiteA700,
                                              label: "PHOTOGRAPH OF TENANT*".tr,
                                              textColor: ColorConstant.anbtnBlue,
                                              borderColor: ColorConstant.anbtnBlue,
                                              prefix: Icon(
                                                controller.tenantPhoto != null
                                                    ? Icons.check_circle_sharp
                                                    : Icons.add_circle_outline,
                                                color: ColorConstant.anbtnBlue,
                                              ),
                                              onPressed: () async {
                                                controller.tenantPhoto = await controller.imagePicker();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: getVerticalSize(15),
                                          ),
                                          Padding(
                                            padding: getPadding(left: 10, right: 10),
                                            child: CustomButton(
                                              width: getHorizontalSize(350),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant.whiteA700,
                                              label: "RENT AGREEMENT DULLY SIGNED*".tr,
                                              textColor: ColorConstant.anbtnBlue,
                                              borderColor: ColorConstant.anbtnBlue,
                                              prefix: Icon(
                                                controller.rentAgreement != null
                                                    ? Icons.check_circle_sharp
                                                    : Icons.add_circle_outline,
                                                color: ColorConstant.anbtnBlue,
                                              ),
                                              onPressed: () async {
                                                controller.rentAgreement = await controller.imagePicker();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: getVerticalSize(15),
                                          ),
                                          Padding(
                                            padding: getPadding(left: 10, right: 10),
                                            child: CustomButton(
                                              width: getHorizontalSize(350),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant.whiteA700,
                                              label: "POLICE REGISTRATION FROM *".tr,
                                              textColor: ColorConstant.anbtnBlue,
                                              borderColor: ColorConstant.anbtnBlue,
                                              prefix: Icon(
                                                controller.policeForm != null
                                                    ? Icons.check_circle_sharp
                                                    : Icons.add_circle_outline,
                                                color: ColorConstant.anbtnBlue,
                                              ),
                                              onPressed: () async {
                                                controller.policeForm = await controller.imagePicker();
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: getVerticalSize(15),
                                          ),
                                          Padding(
                                            padding: getPadding(left: 10, right: 10),
                                            child: CustomButton(
                                              width: getHorizontalSize(350),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant.whiteA700,
                                              label: "COMPLETION CERTIFICATE (IF APPLICABLE)".tr,
                                              textColor: ColorConstant.anbtnBlue,
                                              borderColor: ColorConstant.anbtnBlue,
                                              prefix: Icon(
                                                controller.certificate != null
                                                    ? Icons.check_circle_sharp
                                                    : Icons.add_circle_outline,
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
                                          if (kDebugMode)
                                            ElevatedButton(
                                                onPressed: () {
                                                  controller.tenantFormApi(context);
                                                },
                                                child: Text("Submit")),
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
                )
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

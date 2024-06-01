import 'dart:developer';

import 'package:anchorageislamabad/core/utils/app_fonts.dart';
import 'package:anchorageislamabad/core/utils/constants.dart';
import 'package:anchorageislamabad/widgets/custom_text.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                                  fontSize: 16.sp,
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
                                                controller.natinalityController.text = value;
                                                log(controller.natinalityController.text);
                                              },
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
                                                      fontSize: 14.sp,
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
                                                fontSize: 14.sp,
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
                                            builder: (_) {
                                              return Expanded(
                                                  child: DropdownButton<Street>(
                                                hint: controller.streetSelectedValue == null
                                                    ? Text(
                                                        "Select Street",
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
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
                                                    fontSize: 14.sp,
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
                                            builder: (_) {
                                              return Expanded(
                                                  child: DropdownButton<Plots>(
                                                hint: controller.plotstSelectedValue == null
                                                    ? Text(
                                                        "Select Plot",
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
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
                                                    fontSize: 14.sp,
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
                                            fieldText: "Telephone No".tr,
                                            controller: controller.ownerPhoneController,
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
                                          CustomTextField(
                                            fieldText: "CNIC No".tr,
                                            controller: controller.ownerCNICController,
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
                                          SizedBox(
                                            height: getVerticalSize(5),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: getVerticalSize(15),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GetBuilder(
                                            init: controller,
                                            builder: (_) {
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
                                            builder: (_) {
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: .5.sw,
                                                        child: Padding(
                                                          padding: getPadding(left: 10.w),
                                                          child: MyText(
                                                            title: "Completion certificate held:",
                                                            clr: ColorConstant.antextlightgray,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: getHorizontalSize(20.w),
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
                                                                            style: TextStyle(fontSize: 18.sp, color: ColorConstant.blackColor),
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
                                                                                text: controller.fullNameController.text.capitalize.toString(),
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
                                                                                text: controller.fathersController.text.capitalize.toString(),
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
                                                                        """
hereby solemnly affirm that the above-mentioned information given by me about business at Naval Anchorage Islamabad is true to the best of my knowledge, if found incorrect at any stage I will be liable to be persecuted under special conditions for residing in Anchorage Society.

I will ensure that utility charges / bills will be paid by me timely. In case of non-compliance owner will be responsible for the same.

I will exercise my utmost efforts to conserve water and will avoid littering in the society.

I will observe good social and moral norms during my stay in Anchorage Society.

I will strictly prohibit employment of child labour at my business.

I will neither provide shelter to anyone who is involved in illegal and criminal activities or required by the law enforcement agencies nor will conduct any activity in violation of the law of Pakistan.

I will not hold any function outside my rented space which can be a source of disturbance for other residents.

I will not hire any private security guard who carries weapon with him in Anchorage society.

I will follow the queue for rectification of minor defects in my house by the maintenance staff.

If I am found involved in any immoral / illegal activity, the Administration has the right to eject me from the society.

I will abide by Naval Anchorage Society terms and conditions and adhere to rules / regulations issued from time to time by Naval Headquarters including NOC.

I shall ensure that conduct of my visitors and my employees always remains above board and in accordance with the established civil norms.

I will register my employee’s and their vehicles at Naval Anchorage Security Office as per the SOPs.

I will give access to Naval Anchorage Administration/ Security to my CCTV if and when required at the earliest convenience without formal writing request.

I fully understand that Administrative Staff of Naval Anchorage is functioning to look after the collective interest of the residents of the Anchorage Society and to whom I shall afford complete co-operation in the execution of their duties and abide by the instructions issued from time to time especially in the terms of security and administration.

Dispute if any shall be mutually resolved in a considerate, thoughtful and understanding manner seeking arbitration of Dy Administrator where felt necessary, and I will not take matters concerning Naval Anchorage dispute to the court but the decision of Dy Administrator as arbitrators will be final. If at all any party opt to go to the court then he will pay all the expenditures incurred during court proceedings till the finalization of the case to the Anchorage Administration. In case the owner wants to serve vacation notice to the tenant prior completion of the contract period the notice has to be processed through Administration Office for approval / consent.

I will handover quiet and peace full possession of subject premises on completion of agreed tenure and before vacating I will submit owner’s NOC in Administration Office.

I will neither accommodate nor allow visit of any foreigner specially INDIAN nationals in the subject premises without prior approval of Anchorage Administration.

I fully understand that even if the Tenancy Agreement is valid but NOC period has expired, I can no longer reside in Naval Anchorage society premises and vice versa.

If the NOC has been cancelled by the issuing authority. I will vacate the rented premises within 30 days of the cancellation of NOC.

In case of any violation/ unbecoming of a law-abiding citizen, the Naval Anchorage Directorate reserves the right to cancel the NOC of the said business.

It is the responsibility of Plaza Owner / nominated Estate Agent to provide rent agreement and filled NOC FORM to the Administration Office before renting out the property/ moving in of tenant. The tenant police registration (Police Service Center F-6 Islamabad) is to be submitted within 15 days of shifting, thereafter fine will be charged on daily basis for 1 x month, failing to which the NOC will be cancelled.

Addition/ alteration in building without obtained revised building plan approval is not allowed. Any construction started/ carried out without prior approval will be removed/ dismantled at risk & cost of the owner(s)/ allotee/ occpants(s) and/ or penalty will be imposed as per policy in vague.

Usage of residential building/ plots for commercial/ industrial use is illegal. Morover, residential buildings usage as regular wirship places like Masjids, Jamat Khanas, Imam Margahs etc. is illegal and not allowed.

Construction of permanent structure of any kind outside the building line is not permitted. Moreover, No temporary structure of any kind outside/ setback of building is allowed without prior approval of BCD.

Service area can be utilized only for plantation/ grass purpose. No wall/ grill/ fence/ hard planter/ fountain/ cages can be constructed in service area. This area should be available for maintenance of services as and when needed by the society.

The ownership rights of green area adjacent to any plot shall remain with the society. Same should not be enclosed by walls, grill and/ or fence in such a manner to restrict public approach/ access.

Allotee(s)/ occupants (s) are required not to throw any waste material in dustbins other than kitchen waste which should be wrapped in plastic bags. No any waste material/ garbage is to be dumped on service area or adjacent plots.

No building, structure, or any part thereof should be occupied or used without obtaining completion certificate (permission to occupy).
""",
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
                                          Row(
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
                                                        MyText(
                                                          title: "Yes",
                                                          fontSize: 16,
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
                                fontSize: 16.sp,
                              ),
                              children: <Widget>[
                                GetBuilder(
                                    init: controller,
                                    builder: (_) {
                                      return Form(
                                        key: controller.vehicleFormKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // if (controller.vehicleDataIndex != 0)
                                            //   Row(
                                            //     mainAxisAlignment: MainAxisAlignment.start,
                                            //     children: [
                                            //       Container(
                                            //         margin: EdgeInsets.only(left: 15),
                                            //         padding: EdgeInsets.all(10),
                                            //         decoration:
                                            //             BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                            //         child: MyText(
                                            //           title: controller.vehicleDataIndex.toString(),
                                            //           clr: ColorConstant.whiteA700,
                                            //           fontSize: 16,
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            Row(
                                              children: [
                                                Padding(
                                                  padding: getPadding(left: 10),
                                                  child: MyText(
                                                    title: "VEHICLE(s) IN USE",
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
                                                      behavior: HitTestBehavior.opaque,
                                                      onTap: () {
                                                        // controller.addvehicleControllers();
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
                                                ? ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        controller.vehicleTypeControllers.length == 0 ? 1 : controller.vehicleTypeControllers.length,
                                                    itemBuilder: (context, index) {
                                                      return Column(
                                                        children: [
                                                          if (index != 0)
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
                                                                    behavior: HitTestBehavior.opaque,
                                                                    onTap: () {
                                                                      setState(() {
                                                                        controller.eTag[index] = "Yes";
                                                                      });
                                                                      // controller.updateEtag(
                                                                      //   "Yes",
                                                                      // );
                                                                      // controller.eTag.add("Yes");
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
                                                              SizedBox(
                                                                width: getHorizontalSize(20),
                                                              ),
                                                              GetBuilder(
                                                                init: controller,
                                                                builder: (controller) {
                                                                  return GestureDetector(
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
                                                          Padding(
                                                            padding: getPadding(left: 10, right: 10),
                                                            child: MyAnimatedButton(
                                                              radius: 5.0,
                                                              height: getVerticalSize(50),
                                                              width: getHorizontalSize(400),
                                                              fontSize: 16.sp,
                                                              bgColor: ColorConstant.anbtnBlue,
                                                              controller: controller.uselessbtnController,
                                                              title: "Add Vehicle".tr,
                                                              onTap: () async {
                                                                // if (controller.vehicleDataIndex > 0) {
                                                                //   if (controller.vehicleTypeController?.text == "" &&
                                                                //       controller.vehicleRegisterNoController?.text ==
                                                                //           "" &&
                                                                //       controller.vehicleColorController?.text == "" &&
                                                                //       controller.vehicleEngineNoController.text == "" &&
                                                                //       controller.vehicleEtagController.text == "") {
                                                                //     Utils.showToast(
                                                                //         "Please fill in the required fields", true);
                                                                //   } else {
                                                                controller.addvehicle(context, index);
                                                                //   }
                                                                // } else if (controller.vehicleDataIndex == 0) {
                                                                //   controller.addvehicle(context);
                                                                // }
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
                                                controller.tenantCnicFrontBack != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
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
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant.whiteA700,
                                              label: "CNIC OF ESTATE AGENT (FRONT & BACK)".tr,
                                              textColor: ColorConstant.anbtnBlue,
                                              borderColor: ColorConstant.anbtnBlue,
                                              prefix: Icon(
                                                controller.estateCnicFrontBack != null ? Icons.check_circle_sharp : Icons.add_circle_outline,
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
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w700,
                                              color: ColorConstant.whiteA700,
                                              label: "COMPLETION CERTIFICATE (IF APPLICABLE)".tr,
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
                                          // if (kDebugMode)
                                          //   ElevatedButton(
                                          //       onPressed: () {
                                          //         controller.tenantFormApi(context);
                                          //       },
                                          //       child: Text("Submit")),
                                          Padding(
                                            padding: getPadding(left: 10, right: 10),
                                            child: MyAnimatedButton(
                                              radius: 5.0,
                                              height: getVerticalSize(50),
                                              width: getHorizontalSize(400),
                                              fontSize: 16.sp,
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
